-- Tell LuaLS that 'vim' is a known global
vim = vim

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- Telescope: fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  -- Treesitter: better syntax highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- LSP config
  { "neovim/nvim-lspconfig" },
  -- Mason: install and manage LSP/DAP servers, linters, and formatters.
  { "mason-org/mason.nvim", opts = {}},
  { "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  { "nvim-tree/nvim-web-devicons", opts = {} }, -- Nerd Font icons
  -- Aerial -- code outline and navigation
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },
})

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Keymaps
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- Telescope keybinding
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- Telescope / Aerial setup
require("telescope").setup({
  extensions = {
    aerial = {
      -- Set the width of the first two columns (the second
      -- is relevant only when show_columns is set to 'both')
      col1_width = 4,
      col2_width = 30,
      -- How to format the symbols
      format_symbol = function(symbol_path, filetype)
        if filetype == "json" or filetype == "yaml" then
          return table.concat(symbol_path, ".")
        else
          return symbol_path[#symbol_path]
        end
      end,
      -- Available modes: symbols, lines, both
      show_columns = "both",
    },
  },
})

-- Toggle Markdown checkboxes in normal mode without polluting search registers
vim.keymap.set("n", "<leader>tl", [[:keeppatterns s/\v- \[\zs[ x]\ze/\=submatch(0) == ' ' ? 'x' : ' '/<CR>]], {
  desc = "Toggle Markdown checkbox"
})

-- LSP basic config
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({})

-- Aerial config -- code outline and navigation
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- Toggle Aerial with <leader>a
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- Diagnostics config
vim.diagnostic.config({
  virtual_text = true,        -- Show diagnostic messages as virtual text in the code (inline)
  signs = true,               -- Show signs (icons like 'W' or 'E') in the gutter
  underline = true,           -- Underline text with issues (error/warning)
  update_in_insert = true,    -- Update diagnostics while in insert mode (default: false)
  severity_sort = true,       -- Sort diagnostics by severity (error > warning > info > hint)
})

-- Remember cursor position when re-opening file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line = mark[1]
    local col = mark[2]
    local last_line = vim.api.nvim_buf_line_count(0)
    if line > 0 and line <= last_line then
      vim.api.nvim_win_set_cursor(0, { line, col })
      vim.cmd("normal! zz") -- Center cursor in middle of screen
    end
  end,
})
