vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        vim.diagnostic.open_float()
    end
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        vim.lsp.buf.format()
    end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    pattern = { '[^l]*' },
    nested = true,
    command = vim.cmd('cwindow')
})


vim.api.nvim_create_autocmd('Filetype', {
    pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
    callback = function() vim.opt.bufhidden = 'delete' end
})


vim.api.nvim_create_autocmd('TermOpen', {
    pattern = { '*' },
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end
})


local insert_neorg_link = function()
    local link = vim.fn.input("Link: ")
    local text = vim.fn.input("Text: ")


    vim.api.nvim_set_current_line("{" .. link .. "}[" .. text .. "]")
end


local insert_markdown_link = function()
    local link = vim.fn.input("Link: ")
    local text = vim.fn.input("Text: ")


    vim.api.nvim_set_current_line("[" .. text .. "](" .. link .. ")")
end




vim.api.nvim_create_autocmd("Filetype", {
    pattern = "norg",
    callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.wrap = false


        vim.keymap.set("n", "<leader>t", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })


        vim.keymap.set("i", "<C-l>", insert_neorg_link, { buffer = true })


        vim.keymap.set("i", "<C-d>", "<Plug>(neorg.tempus.insert-date.insert-mode)", { buffer = true })
    end,
})


vim.api.nvim_create_autocmd("Filetype", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("i", "<C-l>", insert_markdown_link, { buffer = true })
    end,
})


vim.api.nvim_create_autocmd({ 'UIEnter' }, {
    callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
            vim.o.laststatus = 0
        end
    end
})

-- This function migrates unfinished tasks from yesterday's Neorg journal to today's journal

local function migrate_yesterday_tasks()
    local yesterday = os.date("%Y/%m/%d", os.time() - 86400)
    local yesterday_file = vim.fn.expand("~/notes/journal/" .. yesterday .. ".norg")
    local today = os.date("%Y/%m/%d")
    local today_file = vim.fn.expand("~/notes/journal/" .. today .. ".norg")

    -- Read yesterday's file
    local file = io.open(yesterday_file, "r")
    if not file then return end
    local lines = {}
    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()

    -- Process lines: Extract tasks but keep non-task content
    local new_lines = {}
    local tasks_by_heading = {}
    local current_heading = nil

    for _, line in ipairs(lines) do
        if line:match("^%*+ ") and not line:match("%( %)") and not line:match("%(x%)") then
            -- Heading found
            current_heading = line
            tasks_by_heading[current_heading] = tasks_by_heading[current_heading] or {}
            table.insert(new_lines, line) -- Keep heading in yesterday's file
        elseif line:match("%(%s*%)") then -- Detect "* ( ) Task1" format
            -- Move to today's file
            local started_date = line:match("@started%((%d%d%d%d%-%d%d%-%d%d)%)")
            if not started_date then
                started_date = yesterday
                line = line .. " @started(" .. started_date .. ")"
            end
            if current_heading then
                table.insert(tasks_by_heading[current_heading], line)
            else
                table.insert(tasks_by_heading, line)
            end
        else
            table.insert(new_lines, line) -- Keep non-task lines in yesterday's file
        end
    end

    -- Write back modified yesterday's file (without moved tasks)
    local file = io.open(yesterday_file, "w")
    if file then
        for _, line in ipairs(new_lines) do
            file:write(line .. "\n")
        end
        file:close()
    end

    -- Read today's file to avoid duplicates
    local today_lines = {}
    local existing_tasks = {}
    local file = io.open(today_file, "r")
    if file then
        for line in file:lines() do
            table.insert(today_lines, line)
            existing_tasks[line] = true -- Store existing lines to prevent duplicates
        end
        file:close()
    end

    local output_lines = {}
    current_heading = nil

    for _, line in ipairs(today_lines) do
        table.insert(output_lines, line)
        if tasks_by_heading[line] then
            -- Insert the corresponding tasks under the right heading
            for _, task in ipairs(tasks_by_heading[line]) do
                if not existing_tasks[task] then -- Only add if it doesn’t already exist
                    table.insert(output_lines, task)
                end
            end
            tasks_by_heading[line] = nil -- Mark heading as processed
        end
    end

    -- If any tasks are left (orphaned ones), append them to the end
    for heading, tasks in pairs(tasks_by_heading) do
        table.insert(output_lines, heading)
        for _, task in ipairs(tasks) do
            if not existing_tasks[task] then
                table.insert(output_lines, task)
            end
        end
    end

    -- Write the updated today file
    local file = io.open(today_file, "w")
    if file then
        for _, line in ipairs(output_lines) do
            file:write(line .. "\n")
        end
        file:close()
    end

    vim.notify("Migrated tasks to today's journal!", vim.log.levels.INFO)
end

-- Hook into Neorg's journal creation event
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = vim.fn.expand("~/notes/journal") .. "/**/*.norg",
    callback = function()
        local filename = vim.fn.expand("<afile>")
        if filename:match(os.date("%Y/%m/%d") .. "%.norg$") then
            vim.defer_fn(migrate_yesterday_tasks, 500) -- Delay ensures file is fully opened
        end
    end,
})
