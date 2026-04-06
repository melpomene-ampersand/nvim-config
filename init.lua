vim.cmd([[colorscheme galatea]])

vim.o.showmode = false
vim.o.winborder = "rounded"
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.cursorline = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true

vim.o.tabstop = 2        -- Number of spaces a tab counts for
vim.o.shiftwidth = 2     -- Number of spaces for autoindent
vim.o.softtabstop = 2    -- Number of spaces a tab counts for while editing
vim.o.expandtab = true   -- Use spaces instead of tabs (optional)
vim.opt.smartindent = true



vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- Lazy Install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  {
    'nvim-telescope/telescope.nvim', 
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- optional but recommended
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          -- Add this section to customize mappings
          mappings = {
            i = {
              -- Map <ESC> to quit insert mode and close telescope if in normal mode
              ["<ESC>"] = require('telescope.actions').close,
              -- Map q to close telescope in insert mode
              ["q"] = require('telescope.actions').close,
            },
            n = {
              -- Map q to close telescope in normal mode
              ["q"] = require('telescope.actions').close,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          }
        }
      })

      -- Load the fzf extension if you're using it
      pcall(require('telescope').load_extension, 'fzf')

      -- Keybindings for telescope
      local builtin = require('telescope.builtin')

      -- Find files in current directory
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

      -- Live grep (search text in files)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

      -- Grep string under cursor
      vim.keymap.set('n', '<leader>f*', function()
        builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end, { desc = 'Telescope grep current word' })

      -- Search recently opened files
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old files' })

      -- Search git files (if in a git repo)
      vim.keymap.set('n', '<leader>fgs', builtin.git_files, { desc = 'Telescope git files' })

      -- Search git commits
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope git commits' })

      -- Search git branches
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })

    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },

  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter", -- Only load when you enter Insert mode
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "https://github.com/farmergreg/vim-lastplace",
    event = "BufReadPost",
  },

  {
    "https://github.com/nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      -- First, get the current theme
      local theme = require("lualine.themes.auto")
      theme.normal.c.bg = "none"
      theme.insert.c.bg = "none"
      theme.visual.c.bg = "none"
      theme.replace.c.bg = "none"
      theme.command.c.bg = "none"
      theme.terminal.c.bg = "none"
      theme.inactive.c.bg = "none"
      theme.insert.a.bg = "#6d5641"
      theme.insert.a.fg = "#130e09"
      theme.visual.a.bg = "#5e6168"
      theme.visual.a.fg = "#130e09"
      theme.normal.a.bg = "#504b35"
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = theme,  -- Use the modified theme
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16,
            events = {
              'WinEnter',
              'BufEnter',
              'BufWritePost',
              'SessionLoadPost',
              'FileChangedShellPost',
              'VimResized',
              'Filetype',
              'CursorMoved',
              'CursorMovedI',
              'ModeChanged',
            },
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},  -- This section will have transparent background
          lualine_x = {''},
          lualine_y = {},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},  -- Also transparent in inactive windows
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end,
  },



})




-- Colorscheme fixes
vim.api.nvim_set_hl(0, '@variable', { fg = '#a4a2a0' })
