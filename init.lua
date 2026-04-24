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
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })

vim.g.mapleader = " "

-- Save file
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>")


-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>")       -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>")     -- close tab
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>")      -- next tab
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>")  -- prev tab
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
                    bg1 = "#000000", -- main background
                    bg0 = "#000000",
                },
            },
        })
        vim.cmd.colorscheme("carbonfox")
    end,
},
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup()
        end,
    },

   })
