# nvim-setting

Docker を使って Ubuntu 20.04 上に Neovim 開発環境を構築するリポジトリです。

## 構成

| ファイル | 役割 |
|---|---|
| `Dockerfile` | Ubuntu 20.04 + Neovim をソースビルドするイメージ定義 |
| `docker-compose.yml` | コンテナの起動設定 |
| `config/` | Neovim の設定ファイル置き場（`~/.config/nvim/` にマウント） |
| `workspace/` | 作業ディレクトリ（コンテナ内 `~/workspace/` にマウント） |

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

## 備考

- Ubuntu 20.04 の GLIBC (2.31) は Neovim v0.10 以降のバイナリ配布と非互換なため、ソースビルドを採用しています
- ソースビルドのため、ホスト OS・アーキテクチャ（macOS / Windows / Linux、x86_64 / ARM64）を問わず動作します
