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

vim.api.nvim_create_autocmd("Filetype", {
  callback = function()
    vim.pack.add({
      'https://github.com/ianks/vim-tsx',
      'https://github.com/leafgarland/typescript-vim',
      'https://github.com/pangloss/vim-javascript',
    })
  end,
  pattern = { "typescript", "javascript", "javascript.jsx", "typescript.tsx" }
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

vim.api.nvim_create_autocmd("Filetype", {
  callback = function()
    vim.keymap.set("i", "<C-d>", function()
      vim.api.nvim_put({ '📅 ' .. os.date("%Y-%m-%d") }, "c", true, true)
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

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
