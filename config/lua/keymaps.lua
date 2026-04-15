vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- 検索ハイライト解除
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ウィンドウ移動
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- バッファ操作
map("n", "<S-h>", "<cmd>bprev<CR>",     { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ファイル操作
map("n", "<leader>w", "<cmd>w<CR>",  { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>",  { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })

-- インデント維持（ビジュアルモード）
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 行の移動（ビジュアルモード）
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- 貼り付け時に上書きしない
map("v", "p", '"_dP')
