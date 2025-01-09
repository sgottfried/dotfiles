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
