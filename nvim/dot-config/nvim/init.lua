-- Basic settings --------------------------------------------------------------

-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.g.nwtrw_liststyle = 3 vim.g.netrw_banner = 0

-- Options
vim.opt.termguicolors = false
vim.opt.laststatus = 2
vim.opt.mouse = "a"
vim.opt.showmode = true
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
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = false
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.formatoptions = "tcqrn1"
vim.opt.hlsearch = true
vim.opt.showtabline = 1
vim.opt.background = "light"
vim.opt.wrap = false
vim.opt.cursorline = false
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.smartindent = true
vim.opt.autoindent = true
--vim.opt.colorcolumn = { "80", "120" }

-- Legacy vim options, because I can't figure out how to set them in lua
vim.cmd("set path+=**")
vim.cmd("set guicursor=")

-- Vimwiki configuration -------------------------------------------------------

vim.g.vimwiki_list = {
    {
        path = "~/docs/vimwiki",
        path_html = "~/docs/vimwiki-html",
        template_path = "~/docs/vimwiki/template",
        template_default = "def_template",
        template_ext = ".html"
    },
    {
        path = "~/docs/homewiki",
        path_html = "~/docs/homewiki-html"
    }
}

-- Completion setup -----------------------------------------------------------

local cmp = require("cmp")
cmp.setup({
    window = {
        completion = cmp.config.window.bordered({border = "single" }),
        documentation = cmp.config.window.bordered({border = "single" }),
    },
    mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-Space>"] = cmp.mapping.complete({}),
    }),
    sources = {
        { name = "nvim_lsp" },
    }
})

-- Add LSP capabilities to cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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


-- UI & colors ----------------------------------------------------------------

-- Override default window options for consistent border drawing
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "single"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
