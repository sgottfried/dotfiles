vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function() vim.diagnostic.open_float() end,
  pattern = "*"
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function() vim.lsp.buf.format() end
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  command = "cwindow",
  nested = true,
  pattern = { "[^l]*" }
})

vim.api.nvim_create_autocmd("Filetype", {
  callback = function() vim.opt.bufhidden = "delete" end,
  pattern = { "gitcommit", "gitrebase", "gitconfig" }
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function() vim.cmd("setlocal nonumber norelativenumber") end,
  pattern = { "*" }
})

local function vim_feedkeys(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    "m",
    false
  )
end

vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = { "COMMIT_EDITMSG", "MERGE_MSG", "REBASE_EDITMSG" },
  callback = function() vim_feedkeys("<leader>otA") end,
  desc = "Run <leader>ot when closing git commit/rebase/merge buffers"
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "wezterm.fnl",
  callback = function()
    local output = vim.fn.system(
      "fennel -c " ..
      vim.fn.expand("%") ..
      " > " ..
      vim.fn.expand("%:r") ..
      ".lua"
    )
    if vim.v.shell_error ~= 0 then
      vim.notify("Error compiling wezterm.fnl:\n" .. output, vim.log.levels.ERROR)
    end
  end
})

local function insert_markdown_link()
  local link = vim.fn.input("Link: ")
  local text = vim.fn.input("Text: ")
  vim.api.nvim_set_current_line("[" .. text .. "](" .. link .. ")")
end

vim.api.nvim_create_autocmd("Filetype", {
  callback = function()
    vim.keymap.set("i", "<C-l>", insert_markdown_link, { buffer = true })
    vim.keymap.set("i", "<C-d>", function()
      local year = os.date('%Y')
      vim.api.nvim_put({ '📅 ' .. year .. '-' }, 'c', true, true)
    end, { buffer = true })

    vim.keymap.set("i", "<C-s>", function()
      local year = os.date('%Y')
      vim.api.nvim_put({ '⏳ ' .. year .. '-' }, 'c', true, true)
    end, { buffer = true })
  end,
  pattern = "markdown"
})

vim.api.nvim_create_autocmd({ "UIEnter" }, {
  callback = function(event)
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
    if client and client.name == "Firenvim" then
      vim.o.laststatus = 0
    end
  end
})
