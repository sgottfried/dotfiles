-- [nfnl] fnl/config/completion.fnl
local cmp = require("cmp")
if (cmp ~= nil) then
  local function _1_()
  end
  cmp.setup({mapping = {["<C-Space>"] = cmp.mapping.complete(), ["<C-d>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-e>"] = cmp.mapping.close(), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-p>"] = cmp.mapping.select_prev_item(), ["<C-y>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})}, snippet = {expand = _1_}, sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "buffer"}})})
  return vim.cmd("                                                                                                                                                                                                                    set completeopt=menuone,noinsert,noselect\n           highlight! default link CmpItemKind CmpItemMenuDefault\n           ")
else
  return nil
end
