(fn migrate-yesterday-tasks []
  (let [yesterday (os.date "%Y/%m/%d" (- (os.time) 86400))
        yesterday-file (vim.fn.expand (.. "~/notes/journal/" yesterday :.norg))
        today (os.date "%Y/%m/%d")
        today-file (vim.fn.expand (.. "~/notes/journal/" today :.norg))
        file (io.open yesterday-file :r)]
    (when (not file) (lua "return "))
    (local lines {})
    (each [line (file:lines)] (table.insert lines line))
    (file:close)
    (local new-lines {})
    (local tasks-by-heading {})
    (var current-heading nil)
    (each [_ line (ipairs lines)]
      (if (and (and (line:match "^%*+ ") (not (line:match "%( %)")))
               (not (line:match "%(x%)")))
          (do
            (set current-heading line)
            (tset tasks-by-heading current-heading
                  (or (. tasks-by-heading current-heading) {}))
            (table.insert new-lines line))
          (or (or (line:match "%(%s*%)") (line:match "%(-%)"))
              (line:match "%(=%)"))
          (do
            (var started-date (line:match "@started%((%d%d%d%d%-%d%d%-%d%d)%)"))
            (when (not started-date) (set started-date yesterday)
              (set-forcibly! line (.. line " @started(" started-date ")")))
            (if current-heading
                (table.insert (. tasks-by-heading current-heading) line)
                (table.insert tasks-by-heading line)))
          (table.insert new-lines line)))
    (local file (io.open yesterday-file :w))
    (when file
      (each [_ line (ipairs new-lines)] (file:write (.. line "\n")))
      (file:close))
    (local today-lines {})
    (local existing-tasks {})
    (local file (io.open today-file :r))
    (when file
      (each [line (file:lines)] (table.insert today-lines line)
        (tset existing-tasks line true))
      (file:close))
    (local output-lines {})
    (set current-heading nil)
    (each [_ line (ipairs today-lines)]
      (table.insert output-lines line)
      (when (. tasks-by-heading line)
        (each [_ task (ipairs (. tasks-by-heading line))]
          (when (not (. existing-tasks task)) (table.insert output-lines task)))
        (tset tasks-by-heading line nil)))
    (each [heading tasks (pairs tasks-by-heading)]
      (table.insert output-lines heading)
      (each [_ task (ipairs tasks)]
        (when (not (. existing-tasks task)) (table.insert output-lines task))))
    (local file (io.open today-file :w))
    (when file
      (each [_ line (ipairs output-lines)] (file:write (.. line "\n")))
      (file:close))
    (vim.notify "Migrated tasks to today's journal!" vim.log.levels.INFO)))
(vim.api.nvim_create_user_command :MigrateYesterdayTasks
                                  (fn [] (migrate-yesterday-tasks)) {})	
