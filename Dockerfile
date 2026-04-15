FROM ubuntu:20.04

ARG NVIM_VERSION=v0.12.1
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# 基本パッケージのインストール
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    tar \
    ca-certificates \
    locales \
    tzdata \
    # nvim の依存 / 開発作業用ツール
    build-essential \
    python3 \
    python3-pip \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    # Neovim ビルド用依存
    cmake \
    ninja-build \
    gettext \
    && rm -rf /var/lib/apt/lists/*

# ロケール設定
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Neovim をソースからビルド
RUN git clone --depth 1 --branch ${NVIM_VERSION} https://github.com/neovim/neovim.git /tmp/neovim \
    && cd /tmp/neovim \
    && make CMAKE_BUILD_TYPE=Release \
    && make install \
    && rm -rf /tmp/neovim

# 作業ユーザー作成 (root 以外で動かしたい場合)
ARG USERNAME=nvimuser
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && apt-get update && apt-get install -y sudo \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && rm -rf /var/lib/apt/lists/*

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# nvim の設定ディレクトリを作成
RUN mkdir -p /home/${USERNAME}/.config/nvim

CMD ["nvim"]
