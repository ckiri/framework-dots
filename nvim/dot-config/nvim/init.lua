-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.g.nwtrw_liststyle = 3
vim.g.netrw_banner = 0

-- Options
vim.opt.termguicolors = true
vim.opt.laststatus = 0
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "no"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.scrolloff = 10
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = false
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.formatoptions = "tcqrn1"
vim.opt.hlsearch = true
vim.opt.showtabline = 1
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.ruler = true

-- Legacy vim options, because I can't figure out how to set them in lua
vim.cmd("set path+=**")
vim.cmd("set guicursor=")

vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/vimwiki/vimwiki" },
})

-- Vimwiki configuration -------------------------------------------------------

vim.g.vimwiki_list = {
  {
    path = "~/docs/vimwiki",
    path_html = "~/docs/vimwiki-html",
    template_path = "~/docs/vimwiki/template",
    template_default = "def_template",
    template_ext = ".html",
  },
  {
    path = "~/docs/knet/wiki",
    syntax = 'markdown',
    ext = '.md',
  },
  {
    path = "~/docs/homewiki",
    path_html = "~/docs/homewiki-html",
    template_path = "~/docs/homewiki/template",
    template_default = "def_template",
    template_ext = ".html",
  },
}

vim.g.vimwiki_listsyms = ' 1234'

-- Completion setup -----------------------------------------------------------

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd("set completeopt+=noselect")

-- Key mappings ---------------------------------------------------------------

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-j>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":bprev<CR>", { noremap = true, silent = true })

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

-- Language server setup -------------------------------------------------------

-- Configure individual language servers
local lspconfig = require("lspconfig")

-- C
lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Python
lspconfig.pylsp.setup{}

-- Lua
vim.lsp.enable('lua_ls')

-- CSS
require'lspconfig'.cssls.setup{}

-- Javascript
lspconfig.ts_ls.setup{}

-- UI & colors ----------------------------------------------------------------

-- Borders
vim.opt.winborder = "none"
