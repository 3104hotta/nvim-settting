local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = true

-- インデント
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 表示
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- ファイル
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- クリップボード
opt.clipboard = "unnamedplus"

-- マウス
opt.mouse = "a"

-- 分割方向
opt.splitbelow = true
opt.splitright = true

-- 補完
opt.completeopt = { "menu", "menuone", "noselect" }

-- パフォーマンス
opt.updatetime = 250
opt.timeoutlen = 300
