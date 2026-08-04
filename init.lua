vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

--------------------------------------------------
-- KEYMAPS
--------------------------------------------------

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>")
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>")
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>")

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

--------------------------------------------------
-- LAZY
--------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({

  {
    "carderne/pi-nvim",
    config = function()
        require("pi-nvim").setup({
            set_default_keymaps = false,
        })

        vim.keymap.set("n", "<leader>pp", ":PiSend<CR>")
        vim.keymap.set("n", "<leader>pf", ":PiSendFile<CR>")
        vim.keymap.set("v", "<leader>ps", ":PiSendSelection<CR>")
        vim.keymap.set("n", "<leader>pb", ":PiSendBuffer<CR>")
        vim.keymap.set("n", "<leader>pi", ":PiPing<CR>")
    end,
},

    --------------------------------------------------
    -- THEME
    --------------------------------------------------

    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = false,
                },
                palettes = {
                    carbonfox = {
                        bg0 = "#000000",
                        bg1 = "#000000",
                    },
                },
            })

            vim.cmd.colorscheme("carbonfox")
        end,
    },

    --------------------------------------------------
    -- CURSOR
    --------------------------------------------------

    {
        "sphamba/smear-cursor.nvim",
        opts = {
            stiffness = 0.8,
            trailing_stiffness = 0.5,
            damping = 0.65,
        },
    },

      --------------------------------------------------
    -- FILE TREE
    --------------------------------------------------

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup()

            vim.keymap.set(
                "n",
                "<leader>e",
                ":NvimTreeToggle<CR>"
            )
        end,
    },

    --------------------------------------------------
    -- STATUS LINE
    --------------------------------------------------

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup()
        end,
    },

    
    --------------------------------------------------
    -- MASON
    --------------------------------------------------

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "basedpyright",
                },
            })
        end,
    },




   {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
},
    --------------------------------------------------
    -- LSP
    --------------------------------------------------
{
    "neovim/nvim-lspconfig",
    config = function()
        -- C++
        vim.lsp.config("clangd", {})
        vim.lsp.enable("clangd")

        -- Python
        vim.lsp.config("basedpyright", {
            handlers = {
                ["textDocument/publishDiagnostics"] = function() end,
            },
        })
        vim.lsp.enable("basedpyright")
    end,
},    --------------------------------------------------
    -- AUTOCOMPLETE
    --------------------------------------------------

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },

        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({
                        select = true,
                    }),
                }),

                sources = {
                    { name = "nvim_lsp" },
                },
            })
        end,
    },


    {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lang = "cpp",

        plugins = {
            non_standalone = true,
        },

        picker = {
            provider = "telescope",
        },
    },
},
    --------------------------------------------------
    -- TELESCOPE
    --------------------------------------------------

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            local telescope = require("telescope.builtin")

            vim.keymap.set(
                "n",
                "<leader>ff",
                telescope.find_files
            )

            vim.keymap.set(
                "n",
                "<leader>fg",
                telescope.live_grep
            )

            vim.keymap.set(
                "n",
                "<leader>fb",
                telescope.buffers
            )
        end,
    },
})


vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
