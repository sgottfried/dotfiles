local default_opts = { remap = false }


local wk = require("which-key")
wk.add({
    { "gb", function() require 'dap'.toggle_breakpoint() end, desc = "toggle breakpoint" },
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
    { "<leader>d", group = "debugger" },
    { "<leader>dd", ':DapContinue<CR>', desc = "Continue Debugging" },
    { "<leader>di", ':DapStepInto<CR>', desc = "Step Into" },
    { "<leader>do", ':DapStepOver<CR>', desc = "Step Over" },
    { "<leader>gd", ':Gvdiffsplit<CR>', desc = "Fugitive Diff" },
    { "<leader>g", group = "Git" },
    { "<leader>gd", ':Gvdiffsplit<CR>', desc = "Fugitive Diff" },
    { "<leader>gg", ':G<CR>', desc = "Open Fugitive" },
    { "<leader>hh", function() Snacks.picker.help() end, desc = "Search Helptags" },
    { "<leader>oa", ':Org agenda t<CR>', desc = "Open Org Agenda" },
    {
        "<leader>nj", ":Neorg journal today<CR>", desc = "Neorg journal for today"
    },
    {
        "<leader>nm", ":MigrateYesterdayTasks<CR>", desc = "Neorg journal migrate tasks"
    },
    {
        "<leader>s",
        function() Snacks.picker.grep() end,
        desc =
        "Search project"
    },
    { "<leader>t", group = "Neotest" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "debug test" },
    {
        "<leader>tt",
        function() require("neotest").run.run({ jestCommand = 'npx jest --coverage' }) end,
        desc =
        "run test under cursor"
    },

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
