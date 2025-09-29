;; gtd.fnl - GTD module
(local M {})

(local gtd-dir (vim.fn.expand "~/gtd"))

(fn M.capture []
  (vim.cmd (.. "edit " gtd-dir "/inbox.md"))
  (vim.cmd "normal! Go")
  (vim.cmd (.. "normal! o## " (os.date "%Y-%m-%d %H:%M")))
  (vim.cmd "normal! o")
  (vim.cmd :startinsert))

(fn M.open-file [filename]
  (vim.cmd (.. "edit " gtd-dir "/" filename)))

(fn M.inbox [] (M.open-file :inbox.md))
(fn M.next [] (M.open-file :next.md))
(fn M.projects [] (M.open-file :projects.md))
(fn M.waiting [] (M.open-file :waiting.md))
(fn M.someday [] (M.open-file :someday.md))

(fn M.review []
  (let [files [:inbox.md :next.md :projects.md :waiting.md]]
    (each [_ file (ipairs files)]
      (vim.cmd (.. "tabnew " gtd-dir "/" file)))))

(fn M.find-files []
  (let [snacks (require :snacks)]
    (snacks.picker.files {:cwd gtd-dir})))

(fn M.grep []
  (let [snacks (require :snacks)]
    (snacks.picker.grep {:cwd gtd-dir})))

  ;; Create commands
  (vim.api.nvim_create_user_command :GTDCapture M.capture {})
  (vim.api.nvim_create_user_command :GTDInbox M.inbox {})
  (vim.api.nvim_create_user_command :GTDNext M.next {})
  (vim.api.nvim_create_user_command :GTDProjects M.projects {})
  (vim.api.nvim_create_user_command :GTDWaiting M.waiting {})
  (vim.api.nvim_create_user_command :GTDSomeday M.someday {})
  (vim.api.nvim_create_user_command :GTDReview M.review {})
  
  ;; Setup keymaps
  (vim.keymap.set :n :<leader>nc M.capture {:desc "GTD: Quick Capture"})
  (vim.keymap.set :n :<leader>ni M.inbox {:desc "GTD: Open Inbox"})
  (vim.keymap.set :n :<leader>nn M.next {:desc "GTD: Next Actions"})
  (vim.keymap.set :n :<leader>np M.projects {:desc "GTD: Projects"})
  (vim.keymap.set :n :<leader>nw M.waiting {:desc "GTD: Waiting For"})
  (vim.keymap.set :n :<leader>ns M.someday {:desc "GTD: Someday/Maybe"})
  (vim.keymap.set :n :<leader>nr M.review {:desc "GTD: Weekly Review"})
  (vim.keymap.set :n :<leader>nf M.find-files {:desc "GTD: Find Files"})
  (vim.keymap.set :n :<leader>ng M.grep {:desc "GTD: Search Content"})

;; In your GTD module
(fn M.capture-from-meeting []
  (let [lines (vim.api.nvim_buf_get_lines 0 0 -1 false)
        actions []
        meeting-file (vim.fn.expand "%:t:r")]
    (each [_ line (ipairs lines)]
      (when (line:match "^%s*%- %[ %]")
        (let [action (.. line " [from: " meeting-file "]")]
          (table.insert actions action))))
    (when (> (length actions) 0)
      (let [inbox-path (.. gtd-dir "/inbox.md")
            existing (vim.fn.readfile inbox-path)
            new-content (vim.list_extend existing 
                          (vim.list_extend ["" (.. "## " (os.date "%Y-%m-%d %H:%M") 
                                                   " - Meeting Actions")] 
                                          actions))]
        (vim.fn.writefile new-content inbox-path)
        (print (.. "Captured " (length actions) " actions to GTD inbox"))))))

;; Add command
(vim.api.nvim_create_user_command :GTDCaptureFromMeeting
  M.capture-from-meeting {})

;; Add keymap
(vim.keymap.set :n :<leader>nm ":GTDCaptureFromMeeting<CR>"
  {:desc "GTD: Capture from meeting"})
