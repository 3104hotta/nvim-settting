# nvim-setting

Docker を使って Ubuntu 20.04 上に Neovim 開発環境を構築するリポジトリです。

## 構成

| ファイル | 役割 |
|---|---|
| `Dockerfile` | Ubuntu 20.04 + Neovim をソースビルドするイメージ定義 |
| `docker-compose.yml` | コンテナの起動設定 |
| `config/` | Neovim の設定ファイル置き場（`~/.config/nvim/` にマウント） |
| `workspace/` | 作業ディレクトリ（コンテナ内 `~/workspace/` にマウント） |

### 設定ファイル構成

```
config/
├── init.lua                  # エントリーポイント
└── lua/
    ├── options.lua           # 基本設定
    ├── keymaps.lua           # キーマップ
    └── plugins/
        └── init.lua          # プラグイン定義 (lazy.nvim)
```

## 前提

- Docker がインストールされていること
  - macOS / Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  - Linux (Ubuntu, CentOS など): [Docker CE](https://docs.docker.com/engine/install/)

> ホスト OS・アーキテクチャ（x86_64 / ARM64）を問わず動作します。
> Neovim をソースからビルドするため、コンテナ内でホスト CPU に合わせたバイナリが生成されます。

## セットアップ

### 1. ディレクトリを作成

```bash
mkdir -p config workspace
```

### 2. Neovim の設定を配置（任意）

`config/` 以下に `init.lua` などの設定ファイルを置きます。

```
config/
└── init.lua
```

### 3. ビルド

Neovim をソースからビルドするため、初回は時間がかかります（10〜20 分程度）。

```bash
docker compose build
```

## 起動

```bash
docker compose run --rm nvim
```

## バージョン変更

`docker-compose.yml` の `NVIM_VERSION` を変更して再ビルドします。

```yaml
args:
  NVIM_VERSION: v0.12.1  # ← ここを変更
```

```bash
docker compose build --no-cache
```

## プラグイン一覧

| プラグイン | 用途 |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | プラグインマネージャー |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | カラースキーム |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | ステータスライン |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | ファイルエクスプローラー |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | ファジーファインダー |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | シンタックスハイライト |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP クライアント |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP サーバーインストーラー |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 補完 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 差分表示 |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | キーバインドヘルプ |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | コメントトグル |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 括弧の自動補完 |

## キーマップ

`<leader>` は `Space` キーです。

| キー | 機能 |
|---|---|
| `<leader>e` | ファイルエクスプローラー開閉 |
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 文字列検索（grep） |
| `<leader>fb` | バッファ一覧 |
| `<leader>w` | ファイル保存 |
| `<leader>q` | 終了 |
| `<leader>ca` | コードアクション（LSP） |
| `<leader>rn` | リネーム（LSP） |
| `<leader>lf` | フォーマット（LSP） |
| `gd` | 定義へジャンプ（LSP） |
| `gr` | 参照一覧（LSP） |
| `K` | ホバードキュメント（LSP） |
| `<C-h/j/k/l>` | ウィンドウ移動 |
| `<S-h> / <S-l>` | バッファ切り替え |
| `gcc` | 行コメントトグル |

## 備考

- Ubuntu 20.04 の GLIBC (2.31) は Neovim v0.10 以降のバイナリ配布と非互換なため、ソースビルドを採用しています
- ソースビルドのため、ホスト OS・アーキテクチャ（macOS / Windows / Linux、x86_64 / ARM64）を問わず動作します
