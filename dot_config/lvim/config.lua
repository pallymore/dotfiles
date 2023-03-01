--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true

-- customization
vim.o.cmdheight = 2
vim.o.updatetime = 100

-- global settings
-- vim.opt.updatetime = 100
-- vim.opt.cursorline = false

-- colorscheme
-- vim.g.nightflyCursorColor = true
-- vim.g.nightflyTransparent = false
-- vim.g.nightflyWinSeparator = 2
vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
-- lvim.colorscheme = "nightfly"
lvim.colorscheme = "tokyonight-storm"

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "\\"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- clear search highlight with Crtl + L
lvim.keys.normal_mode["<C-L>"] = ":nohlsearch<CR>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
--
-- lvim.keys.normal_mode["<leader>h"] = "<C-L>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
--

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

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
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
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true


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
-- :MasonInstall eslint-lsp eslint_d
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint_d", filetypes = { "typescript", "typescriptreact" } },
  { command = "cspell",
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
}

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- LSP Saga
-- https://github.com/glepnir/lspsaga.nvim#rename
-- Rename all occurrences of the hovered word
lvim.keys.normal_mode["<leader>rn"] = ":Lspsaga rename<CR>"
-- use x to mark selected files and enter to confirm
lvim.keys.normal_mode["<leader>rna"] = ":Lspsaga rename ++project<CR>"

-- Additional Plugins
lvim.plugins = {
  {
    "bluz71/vim-nightfly-guicolors",
    as = "nightfly"
  },
  { "jabirali/vim-tmux-yank" },
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
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  { 'stevearc/dressing.nvim' },
  { 'folke/lsp-colors.nvim' }
}

-- Open Alt file
vim.api.nvim_exec([[
 function! AltCommand(path, vim_command)
   let l:alternate = system("alt " . a:path)
   if empty(l:alternate)
     echo "No alternate file for " . a:path . " exists!"
   else
     exec a:vim_command . " " . l:alternate
   endif
 endfunction
" Find the alternate (e.g. test file) file for the current path and open it
  nnoremap <C-t> :w<cr>:call AltCommand(expand('%'), ':vsp')<cr>
]], false)
-- function! AltCommand(path, vim_command)
--   let l:alternate = system("alt " . a:path)
--   if empty(l:alternate)
--     echo "No alternate file for " . a:path . " exists!"
--   else
--     exec a:vim_command . " " . l:alternate
--   endif
-- endfunction
-- " Find the alternate (e.g. test file) file for the current path and open it
-- nnoremap <leader>t :w<cr>:call AltCommand(expand('%'), ':vsp')<cr>


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
