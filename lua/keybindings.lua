local telescope_builtin = require('telescope.builtin')
local default_opts = { remap = false }

local wk = require("which-key")
wk.add({
    { "<leader>;", ':', desc = "Run Command" },
    { "<leader><leader>", telescope_builtin.find_files, desc = "Find Files" },
    {
        "<leader>S",
        ':Telescope live_grep glob_pattern=!*{test,spec}.*<CR>',
        desc =
        "Search project (without tests)"
    },
    {
        "<leader>N",
        ':Neorg journal today<CR>',
        desc = "Open Neorg journal for today"
    },
    { "<leader>b", group = "buffer" },
    {
        '<leader>bi',
        ':Telescope buffers<CR>',
        desc =
        "List buffers"
    },
    {
        '<leader>bS',
        ':noa w<CR>',
        desc =
        "Save (without formatting)"
    },
    { '<leader>bs', ':w<CR>', desc = "Save" },
    { "<leader>c", ':copen<CR>', desc = "Open Quickfix" },
    { "<leader>g", group = "Git" },
    { "<leader>gd", ':Neogit diff<CR>', desc = "Neogit Diff" },
    { "<leader>gg", ':Neogit<CR>', desc = "Open Neogit" },
    { "<leader>n", ':Telescope neorg find_linkable<CR>', desc = "Find Neorg Heading" },
    {
        "<leader>s",
        ':Telescope live_grep<CR>',
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
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'Y', '"+y', default_opts)
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], default_opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], default_opts)
vim.keymap.set('v', 'Y', '"+y', default_opts)
