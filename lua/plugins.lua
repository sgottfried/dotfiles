local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local chat_model = "claude-3.5-sonnet"

if os.getenv("NEOVIM_ENVIRONMENT") == "work" then
  chat_model = "claude-sonnet-4"
end

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function() end,
    dependencies = { "nvim-web-devicons" }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)"
      }
    }
  },
  -- Git integration
  {
    "airblade/vim-gitgutter",
    event = { "BufRead", "BufNewFile" }
  },
  {
    "APZelos/blamer.nvim",
    event = { "BufRead", "BufNewFile" },
    cmd = "BlamerToggle"
  },

  -- LSP and Completion
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre"
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp" }
  },
  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x",
    event = "BufReadPre"
  },
  -- Language and Syntax
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate"
  },
  {
    "ianks/vim-tsx",
    ft = { "typescript.tsx", "javascript.jsx" }
  },
  {
    "leafgarland/typescript-vim",
    ft = { "typescript", "javascript" }
  },
  {
    "pangloss/vim-javascript",
    ft = "javascript"
  },
  -- Editor Enhancement
  {
    "tpope/vim-commentary",
    event = { "BufRead", "BufNewFile" }
  },
  {
    "tpope/vim-surround",
    event = { "BufRead", "BufNewFile" }
  },
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy"
  },
  {
    "tpope/vim-projectionist",
    event = "VeryLazy"
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-web-devicons" }
  },
  -- AI Integration
  {
    "github/copilot.vim",
    event = "InsertEnter"
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make tiktoken",
    config = function()
      require("CopilotChat").setup({ model = chat_model })
    end,
    cmd = "CopilotChat",
    dependencies = { "github/copilot.vim", "plenary.nvim" }
  },

  -- Notes
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false, -- this will be removed in the next major release
      daily_notes = {
        template = "daily.md"
      },
      workspaces = {
        {
          name = "Sam's Notes",
          path = "~/notes/obsidian",
        },
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      checkbox = {
        enabled = true,
        create_new = true,
        order = { " ", ">", "x" },
      },
    }

  },

  -- Misc
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      image = {},
      picker = {}
    },
  }
})
