-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
    -- VSCode extension
    vim.g.mapleader = " "
    vim.keymap.set("v", "p", "P")
    vim.keymap.set("n", "U", "<C-r>")
    vim.keymap.set("n", "<leader>C", "<cmd>lua require('vscode').action('workbench.action.closeAllEditors')<CR>")
    vim.keymap.set("n", "<S-l>", "<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>")
    vim.keymap.set("n", "<S-h>", "<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>")
    vim.keymap.set("i", "<A-a>", "<Esc>A")
    vim.keymap.set("i", "<A-i>", "<Esc>I")
else
    local map = vim.keymap.set

    map("i", "<c-h>", "<Left>")
    map("i", "<c-l>", "<Right>")
    map("i", "<A-a>", "<Esc>A")
    map("i", "<A-i>", "<Esc>I")
    map("i", "jj", "<Esc>")
    map("i", "jk", "<Esc>")
    map("i", "kj", "<Esc>")
    map("v", "p", "P")

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "none",
            width = 100000,
            height = 100000,
            zindex = 200,
        },
        on_open = function(_)
            vim.cmd("startinsert!")
        end,
        on_close = function(_) end,
        count = 99,
    })
    function _lazygit_toggle()
        lazygit:toggle()
    end
    -- ordinary Neovim
    map("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { remap = true, silent = true })
end


