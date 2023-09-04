--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = false
vim.o.cmdheight = 2
vim.o.updatetime = 100
vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

-- general
lvim.log.level = "warn"
lvim.format_on_save = {
  enabled = true,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "\\"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- clear search highlight with Crtl + L
lvim.keys.normal_mode["<C-L>"] = ":nohlsearch<CR>"

lvim.colorscheme = "tokyonight-storm"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- Telescope
-- ctrl + p
lvim.keys.normal_mode["<C-p>"] = ":Telescope find_files<cr>"

-- Trouble keybindings
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
lvim.keys.normal_mode["<space>d"] = ":TroubleToggle<cr>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
  "gomod",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  { "stevearc/dressing.nvim" },
  { "folke/lsp-colors.nvim" },
  { "olexsmir/gopher.nvim" },
  { "leoluz/nvim-dap-go" },
  -- { "github/copilot.vim" },
}


-- Bufferline configs
local bufferline = lvim.builtin.bufferline;
bufferline.options = {
  numbers = "ordinal",
  diagnostics = "nvim_lsp", -- | "coc",
  diagnostics_update_in_insert = false,
  color_icons = true,
  show_close_icon = true,
  show_tab_indicators = true,
  separator_style = "slant",
}
-- bufferline keybindings
lvim.keys.normal_mode["t1"] = ":BufferLineGoToBuffer 1<CR>"
lvim.keys.normal_mode["t2"] = ":BufferLineGoToBuffer 2<CR>"
lvim.keys.normal_mode["t3"] = ":BufferLineGoToBuffer 3<CR>"
lvim.keys.normal_mode["t4"] = ":BufferLineGoToBuffer 4<CR>"
lvim.keys.normal_mode["t5"] = ":BufferLineGoToBuffer 5<CR>"
lvim.keys.normal_mode["t6"] = ":BufferLineGoToBuffer 6<CR>"
lvim.keys.normal_mode["t7"] = ":BufferLineGoToBuffer 7<CR>"
lvim.keys.normal_mode["t8"] = ":BufferLineGoToBuffer 8<CR>"
lvim.keys.normal_mode["t9"] = ":BufferLineGoToBuffer 9<CR>"
lvim.keys.normal_mode["t0"] = ":BufferLineGoToBuffer 0<CR>"
-- go to next  previous
lvim.keys.normal_mode["t."] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["t,"] = ":BufferLineCyclePrev<CR>"
-- move buffer
lvim.keys.normal_mode["t<"] = ":BufferLineMoveNext<CR>"
lvim.keys.normal_mode["t>"] = ":BufferLineMovePrev<CR>"
-- close current buffer
lvim.keys.normal_mode["tc"] = ":BufferKill<CR>"

-- local sources = { null_ls.builtins.diagnostics.cspell }
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { command = "cspell", },
}

-- linters
-- :MasonInstall eslint-lsp eslint_d golangci-lint
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "golangci_lint", filetypes = { "go" } },
  { command = "eslint_d",      filetypes = { "typescript", "typescriptreact" } },
  {
    command = "cspell",
    filetypes = { "typescript", "typescriptreact", "html", "markdown", "json", "jsonc", "javascript" },
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
    end,
  }
}

-- file formatters
-- :MasonInstall prettier
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    -- command = "prettier",
    command = "eslint_d", -- only use for projects with eslint+prettier plugin
    filetypes = { "typescript", "typescriptreact" },
  },
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filetypes = { "go" } },
}

lvim.format_on_save.enabled = true

------------------------
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()

------------------------
-- LSP (golang)
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    local map = function(mode, lhs, rhs, desc)
      if desc then
        desc = desc
      end

      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
    end
    map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
    map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
    map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
    map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
    map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
    map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
    map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
    map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
    map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup {
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
}

-- LSP Saga
-- https://github.com/glepnir/lspsaga.nvim#rename
-- Rename all occurrences of the hovered word
lvim.keys.normal_mode["<leader>rn"] = ":Lspsaga rename<CR>"
-- use x to mark selected files and enter to confirm
lvim.keys.normal_mode["<leader>rna"] = ":Lspsaga rename ++project<CR>"
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
lvim.keys.normal_mode["<leader>rl"] = ":Lspsaga show_line_diagnostics ++unfocus<CR>"
lvim.keys.normal_mode["T"] = ":Lspsaga show_line_diagnostics ++unfocus<CR>"
-- Show buffer diagnostics
lvim.keys.normal_mode["<leader>rb"] = ":Lspsaga show_buf_diagnostics<CR>"
-- Show workspace diagnostics
lvim.keys.normal_mode["<leader>rw"] = ":Lspsaga show_workspace_diagnostics<CR>"
-- Show cursor diagnostics
lvim.keys.normal_mode["<leader>rc"] = ":Lspsaga show_cursor_diagnostics<CR>"


-- Open Alt file
-- -- ----------------------------------------------
-- Alternate File Switching
-- ----------------------------------------------
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local alternates_picker = function(alternates, opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "alternates",
    finder = finders.new_table {
      results = alternates
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

local alt = function(path)
  local function isempty(s)
    return s == nil or s == ''
  end

  -- This is where you can configure it with CLI options so
  -- it behaves how you want it to.
  local alternates = vim.fn.system("/opt/homebrew/bin/alt " .. path)
  if isempty(alternates) then
    return nil
  else
    local alternates_table = {}
    for s in alternates:gmatch("[^\r\n]+") do
      table.insert(alternates_table, s)
    end
    return alternates_table
  end
end

local alt_command = function(path, alt_handler)
  local current_file_path = vim.fn.expand('%')
  local alternate_file_paths = alt(current_file_path)
  if alternate_file_paths == nil then
    print("No alternate files found for " .. current_file_path .. "!")
  else
    alt_handler(current_file_path, alternate_file_paths)
  end
end

local alt_handler = function(current_file_path, alternate_file_paths)
  alternates_picker(alternate_file_paths)
end

vim.keymap.set('n', '<C-t>', function()
  alt_command(vim.fn.expand('%'), alt_handler)
end)
-- end of Alt command

-- copilot overrides - maps to Ctrl-e
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"

lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end
