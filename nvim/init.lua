-- Bootstrap lazy.nvim
vim.opt.rtp:prepend("/root/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup(
    {
        spec = {
            -- status line
            {
                "nvim-lualine/lualine.nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                config = function()
                    require("lualine").setup {}
                end
            },
            -- filer
            {
                "nvim-tree/nvim-tree.lua",
                dependencies = {
                    "nvim-tree/nvim-web-devicons",
                },
                lazy = false,
                config = function()
                    require("nvim-web-devicons").setup {}
                    require("nvim-tree").setup {
                        update_focused_file = {
                            enable = true,
                            update_cwd = true
                        },
                        view = {
                          adaptive_size = true
                        },
                        on_attach = function(bufnr)
                            local api = require "nvim-tree.api"
                            api.config.mappings.default_on_attach(bufnr)
                            vim.keymap.set("n", "s", "", { buffer = bufnr })
                        end
                    }

                    vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
                end
            },
            -- fuzy finding
            {
                "junegunn/fzf.vim",
                dependencies = {
                    "junegunn/fzf",
                },
                config = function()
                    vim.api.nvim_set_keymap("n", "<C-f>", ":<C-u>Rg<Space>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "<C-p>", ":<C-u>GFiles<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "<C-h>", ":<C-u>History<CR>", {noremap = true})
                end
            },
            -- lsp
            {
              'neovim/nvim-lspconfig',
              config = function()
                require('lspconfig').clangd.setup({})
              end,
            },
        }
    }
)

vim.opt.encoding = "utf-8"

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.wrap = false
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest,full"

vim.opt.virtualedit = "onemore"
vim.opt.laststatus = 2
vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.title = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.errorbells = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true

vim.opt.completeopt = "menuone,preview,noinsert"

vim.opt.syntax = "on"

vim.cmd("highlight Pmenu ctermfg=white ctermbg=black")
vim.cmd("highlight PmenuSel ctermfg=white ctermbg=gray")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_set_keymap("n", "sj", "<C-w>j", {noremap = true})
vim.api.nvim_set_keymap("n", "sk", "<C-w>k", {noremap = true})
vim.api.nvim_set_keymap("n", "sl", "<C-w>l", {noremap = true})
vim.api.nvim_set_keymap("n", "sh", "<C-w>h", {noremap = true})
vim.api.nvim_set_keymap("n", "ss", "<CMD>sp<CR><C-w>j", {noremap = true})
vim.api.nvim_set_keymap("n", "sv", "<CMD>vs<CR><C-w>l", {noremap = true})

vim.api.nvim_set_keymap("n", "tn", "<CMD>tabnew<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "th", "<CMD>tabprevious<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "tl", "<CMD>tabnext<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("i", "{", "{}<Left>", {noremap = true})
vim.api.nvim_set_keymap("i", "(", "()<Left>", {noremap = true})
vim.api.nvim_set_keymap("i", "[", "[]<Left>", {noremap = true})
vim.api.nvim_set_keymap("i", "'", "''<Left>", {noremap = true})
vim.api.nvim_set_keymap("i", '"', '""<Left>', {noremap = true})

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and vim.api.nvim_replace_termcodes("<C-N>", true, true, true) or
        vim.api.nvim_replace_termcodes("<TAB>", true, true, true)
end

function _G.smart_stab()
    return vim.fn.pumvisible() == 1 and vim.api.nvim_replace_termcodes("<C-P>", true, true, true) or
        vim.api.nvim_replace_termcodes("<S-TAB>", true, true, true)
end

vim.api.nvim_set_keymap("i", "<TAB>", "v:lua.smart_tab()", {expr = true, noremap = true})
vim.api.nvim_set_keymap("i", "<S-TAB>", "v:lua.smart_stab()", {expr = true, noremap = true})

vim.api.nvim_set_keymap("c", "%%", [[getcmdtype() == ':' ? expand('%:h') .. '/' : '%%']], {noremap = true, expr = true})

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "gn", "<CMD>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gh", "<CMD>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[g", "<CMD>lua vim.diagnostic.goto_prev()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]g", "<CMD>lua vim.diagnostic.goto_next()<CR>", {noremap = true, silent = true})
