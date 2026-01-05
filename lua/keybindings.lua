local default_opts = { remap = false }
local wk = require("which-key")

-- Helper functions to replace the macros
local function add_group(prefix, group_name, mappings)
  wk.add({ prefix, name = group_name })
  for _, mapping in ipairs(mappings) do
    local keybinding, command, desc = unpack(mapping)
    wk.add({ prefix .. keybinding, command, desc = desc })
  end
end

local function add_insert_mode_keybinding(keybinding, command)
  vim.keymap.set("i", keybinding, command)
end

local function add_keybinding(keybinding, command, desc)
  wk.add({ keybinding, command, desc = desc })
end

local function add_proxy_group(keybinding, group_name, proxy_keybinding)
  wk.add({ keybinding, name = group_name, proxy = proxy_keybinding })
end

local function add_terminal_mode_keybinding(keybinding, command)
  vim.keymap.set("t", keybinding, command, default_opts)
end

local function add_visual_mode_keybinding(keybinding, command)
  vim.keymap.set("v", keybinding, command, default_opts)
end

-- Buffer mappings
add_group("<leader>b", "buffer", {
  { "S", ":noa w<CR>", "Save (without formatting)" },
  { "i", ":lua Snacks.picker.buffers()<CR>", "List buffers" },
  { "s", ":w<CR>", "Save" }
})

-- Debugger mappings
add_group("<leader>d", "debugger", {
  { "d", ":DapContinue<CR>", "Continue Debugging" },
  { "i", ":DapStepInto<CR>", "Step Into" },
  { "o", ":DapStepOver<CR>", "Step Over" }
})

-- Notes group
add_group("<leader>n", "notes", {
  { "t", ":Obsidian today<CR>", "Open Today's Note" },
  { "y", ":Obsidian yesterday<CR>", "Open Yesterday's Note" },
  { "ss", ":Obsidian search<CR>", "Search Notes" },
})

-- Tasks group
add_group("<leader>t", "tasks", {
  { "i", function()
    vim.api.nvim_put({ '- [ ] ' }, 'c', true, true)
  end, "Insert New Task" },
  { "s", function() require("snacks").picker.grep({ cwd = "~/notes/obsidian", search = "- \\[ \\]" }) end,
    "Find Unfinished Tasks" },
})

-- Insert mode mappings
add_insert_mode_keybinding("jk", "<Esc>")

-- Git blame
add_keybinding("<leader>gb", ":BlamerToggle<CR>", "Toggle Git Blame")

-- Normal mode mappings
add_keybinding("-", ":Oil<CR>", "Open parent directory")
add_keybinding("<leader>;", ":", "Run Command")
add_keybinding("<leader><leader>", ":lua Snacks.picker.smart()<CR>", "Snacks find files")
add_keybinding("<leader>c", ":copen<CR>", "Open Quickfix")
add_keybinding("<leader>hh", ":lua Snacks.picker.help()<CR>", "Search Helptags")
add_keybinding("<leader>ot", function()
  local term_buf = vim.fn.bufnr("term://*")
  if term_buf == -1 then
    vim.cmd("botright split | resize 20 | terminal")
  else
    vim.cmd("botright split | resize 20 | buffer " .. term_buf)
  end
end, "Open Terminal")
add_keybinding("<leader>s", ":lua Snacks.picker.grep()<CR>", "Search project")
add_keybinding("<leader>x", ":.lua<CR>", "Execute Lua line")
add_keybinding("gb", ":DapToggleBreakpoint<CR>", "toggle breakpoint")
add_keybinding("gd", function() vim.lsp.buf.definition() end, "LSP Go to definition")
add_keybinding("gh", function() vim.lsp.buf.hover() end, "LSP Hover")
add_keybinding("gr", function() vim.lsp.buf.references() end, "LSP references")
add_keybinding("gR", function() vim.lsp.buf.rename() end, "LSP rename")
add_keybinding("Y", "\"+y", "Yank to system clipboard")

-- Window mappings
add_proxy_group("<leader>w", "windows", "<c-w>")

-- Terminal mode mappings
add_terminal_mode_keybinding("<C-[>", "<C-\\><C-n>")
add_terminal_mode_keybinding("jk", "<C-\\><C-n>")

-- Visual mode mappings
add_visual_mode_keybinding("<leader>x", ":lua<CR>")
add_visual_mode_keybinding("Y", "\"+y")
