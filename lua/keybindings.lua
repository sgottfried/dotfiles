local telescope_builtin = require('telescope.builtin')
local default_opts = { remap = false }


local wk = require("which-key")
wk.add({
    { "<leader>;", ':', desc = "Run Command" },
    { "<leader><leader>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>b", group = "buffer" },
    {
        '<leader>bS',
        ':noa w<CR>',
        desc =
        "Save (without formatting)"
    },
    {
        '<leader>bi',
        function() Snacks.picker.buffers() end,
        desc =
        "List buffers"
    },
    { '<leader>bs', ':w<CR>', desc = "Save" },
    { "<leader>c", ':copen<CR>', desc = "Open Quickfix" },
    { "<leader>g", group = "Git" },
    { "<leader>gd", ':Gvdiffsplit<CR>', desc = "Fugitive Diff" },
    { "<leader>gg", ':G<CR>', desc = "Open Fugitive" },
    { "<leader>hh", function() Snacks.picker.help() end, desc = "Search Helptags" },
    { "<leader>nj", function() require('org-roam').ext.dailies.goto_today() end, desc = "Go to today's journal" },
    { "<leader>nJ", function() require('org-roam').ext.dailies.capture_today() end, desc = "Capture today's journal" },
    { "<leader>ns", require("telescope").extensions.orgmode.search_headings, desc = "Search Org Headings" },
    { "<leader>nl", require("telescope").extensions.orgmode.insert_link, desc = "Insert Org Mode Link" },
    { "<leader>oa", ':Org agenda t<CR>', desc = "Open Org Agenda" },
    { "<leader>p", function() require 'telescope'.extensions.projects.projects {} end, desc = "Switch Project" },
    {
        "<leader>s",
        function() Snacks.picker.grep() end,
        desc =
        "Search project"
    },
    { "<leader>t", group = "Neotest" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "test file" },
    {
        "<leader>tt",
        function() require("neotest").run.run() end,
        desc =
        "run test under cursor"
    },
    {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'npx jest --watch ' })<cr>",
        desc =
        "run test watch"
    },
    { "<leader>w", proxy = "<c-w>", group = "windows" },
    { "<leader>x", ":.lua<CR>", desc = "Execute Lua line" },
})


vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'Y', '"+y', default_opts)
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], default_opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], default_opts)
vim.keymap.set('v', 'Y', '"+y', default_opts)
vim.keymap.set('v', '<leader>x', ':lua<CR>', default_opts)
