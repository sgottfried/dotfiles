;; meetings.fnl
(local M {})

(local meetings-dir (vim.fn.expand "~/meetings"))

(fn M.get-date-paths []
  (let [year (os.date "%Y")
        month (os.date "%m-%B")
        date (os.date "%Y-%m-%d")
        time (os.date "%H%M")]
    {:year year
     :month month
     :date date
     :time time
     :month-dir (.. meetings-dir "/" year "/" month)}))

(fn M.ensure-dir [path]
  (vim.fn.mkdir path :p))

(fn M.load-template [template-name]
  (let [template-path (.. meetings-dir "/templates/" template-name ".md")
        file (io.open template-path :r)]
    (if file
      (let [content (file:read :*a)]
        (file:close)
        content)
      "")))

(fn M.process-template [content]
  (-> content
      (string.gsub "{{date}}" (os.date "%Y-%m-%d"))
      (string.gsub "{{time}}" (os.date "%H:%M"))
      (string.gsub "{{datetime}}" (os.date "%Y-%m-%d %H:%M"))
      (string.gsub "{{day}}" (os.date "%A"))
      (string.gsub "{{week}}" (os.date "%W"))))

(fn M.create [template-name title]
  (let [paths (M.get-date-paths)
        safe-title (-> title
                       (string.lower)
                       (string.gsub "%s+" "-")
                       (string.gsub "[^%w%-]" ""))
        filename (.. paths.date "_" paths.time "_" safe-title ".md")
        filepath (.. paths.month-dir "/" filename)]
    
    (M.ensure-dir paths.month-dir)
    (vim.cmd (.. "edit " filepath))
    
    (let [template (M.load-template template-name)
          content (M.process-template template)]
      (when (not= content "")
        (vim.api.nvim_buf_set_lines 0 0 -1 false (vim.split content "\n"))))
    
    (vim.cmd "normal! gg")
    (vim.cmd (.. "normal! /" (or title "# ")))
    (vim.cmd "nohlsearch")
    (vim.cmd "normal! $")
    (vim.cmd :startinsert)))

(fn M.search []
  (let [snacks (require :snacks)]
    (snacks.picker.grep {:cwd meetings-dir})))

(fn M.find []
  (let [snacks (require :snacks)]
    (snacks.picker.files {:cwd meetings-dir})))

(fn M.today []
  (let [paths (M.get-date-paths)
        today-pattern (.. paths.month-dir "/" paths.date "_*.md")
        files (vim.fn.glob today-pattern true true)]
    (if (> (length files) 0)
      (each [_ file (ipairs files)]
        (vim.cmd (.. "edit " file)))
      (print "No meetings today"))))

(fn M.extract-actions []
  (let [lines (vim.api.nvim_buf_get_lines 0 0 -1 false)
        actions []]
    (each [_ line (ipairs lines)]
      (when (line:match "^%s*%- %[ %]")
        (table.insert actions line)))
    (if (> (length actions) 0)
      (do
        (vim.cmd "new")
        (vim.api.nvim_buf_set_lines 0 0 -1 false 
          (vim.list_extend ["# Action Items" ""] actions))
        (vim.bo.buftype :nofile))
      (print "No action items found"))))

;; Recurring meetings
(local recurring-dir (.. meetings-dir "/recurring"))

(fn M.load-recurring-config [name]
  (let [config-path (.. recurring-dir "/" name ".json")
        file (io.open config-path :r)]
    (if file
      (let [content (file:read :*a)
            _ (file:close)]
        (vim.json.decode content))
      nil)))

(fn M.save-recurring-config [name config]
  (M.ensure-dir recurring-dir)
  (let [config-path (.. recurring-dir "/" name ".json")
        file (io.open config-path :w)
        json (vim.json.encode config)]
    (file:write json)
    (file:close)))

(fn M.list-recurring []
  (let [pattern (.. recurring-dir "/*.json")
        files (vim.fn.glob pattern true true)
        meetings []]
    (each [_ file (ipairs files)]
      (let [name (vim.fn.fnamemodify file ":t:r")]
        (table.insert meetings name)))
    meetings))

(fn M.find-previous [recurring-name]
  (let [pattern (.. meetings-dir "/*/*/????-??-??_????_" recurring-name ".md")
        files (vim.fn.glob pattern true true)]
    (if (> (length files) 0)
      (. files (length files))
      nil)))

(fn M.copy-actions [from-file]
  (if (and from-file (= (vim.fn.filereadable from-file) 1))
    (let [lines (vim.fn.readfile from-file)
          actions []
          ]
      (var in-actions false)
      (each [_ line (ipairs lines)]
        (when (line:match "^## Action Items")
          (set in-actions true))
        (when (and in-actions (line:match "^## "))
          (when (not (line:match "^## Action Items"))
            (set in-actions false)))
        (when (and in-actions (line:match "^%s*%- %[ %]"))
          (table.insert actions line)))
      actions)
    []))

(fn M.create-recurring [name]
  (let [config (M.load-recurring-config name)]
    (if config
      (let [title (. config :title)
            template (or (. config :template) :standard)
            prev-file (M.find-previous name)
            prev-actions (M.copy-actions prev-file)
            paths (M.get-date-paths)
            filename (.. paths.date "_" paths.time "_" name ".md")
            filepath (.. paths.month-dir "/" filename)]
        
        (M.ensure-dir paths.month-dir)
        (vim.cmd (.. "edit " filepath))
        
        (let [template-content (M.load-template template)
              content (M.process-template template-content)
              lines (vim.split content "\n")]
          
          (vim.api.nvim_buf_set_lines 0 0 -1 false lines)
          
          ;; Add previous action items
          (when (> (length prev-actions) 0)
            (let [current-lines (vim.api.nvim_buf_get_lines 0 0 -1 false)]
              (var action-idx nil)
              (each [i line (ipairs current-lines)]
                (when (line:match "^## Action Items")
                  (set action-idx i)))
              
              (when action-idx
                (let [before (vim.list_slice current-lines 1 (+ action-idx 1))
                      after (vim.list_slice current-lines (+ action-idx 2))
                      new-lines (vim.list_extend 
                                  (vim.list_extend before 
                                    (vim.list_extend ["" "### Carried over from last meeting"] 
                                                    prev-actions))
                                  (vim.list_extend [""] after))]
                  (vim.api.nvim_buf_set_lines 0 0 -1 false new-lines)))))
          
          ;; Add link to previous meeting
          (when prev-file
            (let [prev-name (vim.fn.fnamemodify prev-file ":t")
                  link (.. "**Previous:** [[" prev-name "]]")]
              (vim.api.nvim_buf_set_lines 0 1 1 false [link ""])))
          
          (vim.cmd "normal! gg")
          (vim.cmd "nohlsearch")
          (vim.cmd "normal! }}")))
      (print (.. "Recurring meeting '" name "' not found. Create it with :MeetingRecurringSetup")))))

(fn M.setup-recurring [name template]
  (let [safe-name (-> name
                      (string.lower)
                      (string.gsub "%s+" "-")
                      (string.gsub "[^%w%-]" ""))
        config {:title name
                :template (or template :standard)
                :frequency "weekly"}]
    (M.save-recurring-config safe-name config)
    (print (.. "Created recurring meeting: " name " (" safe-name ")"))))

(fn M.recurring []
  (let [meetings (M.list-recurring)]
    (if (> (length meetings) 0)
      (vim.ui.select meetings
        {:prompt "Select recurring meeting:"}
        (fn [choice]
          (when choice
            (M.create-recurring choice))))
      (print "No recurring meetings configured. Use :MeetingRecurringSetup"))))

  ;; Commands
  (vim.api.nvim_create_user_command :MeetingNew
    (fn [opts]
      (let [title (if (> (length opts.args) 0) opts.args "Meeting")]
        (M.create :standard title)))
    {:nargs "?"})

  (vim.api.nvim_create_user_command :MeetingSearch M.search {})
  (vim.api.nvim_create_user_command :MeetingFind M.find {})
  (vim.api.nvim_create_user_command :MeetingToday M.today {})
  (vim.api.nvim_create_user_command :MeetingExtractActions M.extract-actions {})
  
  (vim.api.nvim_create_user_command :MeetingRecurring
    (fn [opts]
      (if (> (length opts.args) 0)
        (M.create-recurring opts.args)
        (M.recurring)))
    {:nargs "?"})
  
  (vim.api.nvim_create_user_command :MeetingRecurringSetup
    (fn [opts]
      (if (> (length opts.args) 0)
        (M.setup-recurring opts.args)
        (print "Usage: :MeetingRecurringSetup <name> [template]")))
    {:nargs "?"})

  ;; Keymaps
  (vim.keymap.set :n :<leader>mn ":MeetingNew " {:desc "Meeting: New"})
  (vim.keymap.set :n :<leader>mf ":MeetingFind<CR>" {:desc "Meeting: Find"})
  (vim.keymap.set :n :<leader>ms ":MeetingSearch<CR>" {:desc "Meeting: Search"})
  (vim.keymap.set :n :<leader>mt ":MeetingToday<CR>" {:desc "Meeting: Today's meetings"})
  (vim.keymap.set :n :<leader>ma ":MeetingExtractActions<CR>" {:desc "Meeting: Extract actions"})
  (vim.keymap.set :n :<leader>mR ":MeetingRecurring<CR>" {:desc "Meeting: Start recurring"})
  (vim.keymap.set :n :<leader>mS ":MeetingRecurringSetup " {:desc "Meeting: Setup recurring"})
