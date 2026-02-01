#!/usr/bin/env bash

set -e

echo "🔍 Starting Shell Dotfiles Setup..."

# ---- GIT REPO UP-TO-DATE CHECK ----
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "❌ This directory is not a git repository."
  exit 1
fi

echo "🔄 Checking if git repo is up to date..."

git fetch --quiet

LOCAL="$(git rev-parse @)"
REMOTE="$(git rev-parse @{u})"
BASE="$(git merge-base @ @{u})"

if [[ "$LOCAL" != "$REMOTE" && "$LOCAL" = "$BASE" ]]; then
  echo "❌ Your branch is behind the remote."
  echo "   Please run: git pull"
  exit 1
fi

echo "✅ Git repo is up to date"

# ---- NERD FONT (JETBRAINS MONO) ----
FONT_DIR="$HOME/.local/share/fonts"
FONT_CHECK="$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf"

if ! command -v unzip >/dev/null 2>&1; then
  echo "📦 Installing unzip..."
  sudo apt update
  sudo apt install -y unzip
else
  echo "✅ unzip already installed"
fi

if [[ ! -f "$FONT_CHECK" ]]; then
  echo "🔤 Installing JetBrains Mono Nerd Font..."

  mkdir -p "$FONT_DIR"

  (
    cd /tmp

    curl -Los JetBrainsMono.zip \
      https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

    unzip -o JetBrainsMono.zip -d JetBrainsMonoNF
    cp JetBrainsMonoNF/*.ttf "$FONT_DIR"

    rm -rf JetBrainsMono.zip JetBrainsMonoNF
  )

  fc-cache -f
else
  echo "✅ JetBrains Mono Nerd Font already installed"
fi

# ---- DOTFILES ROOT CHECK ----
if [[ ! -d "zsh" || ! -d "starship" ]]; then
  echo "❌ Not in dotfiles repo root."
  echo "   Expected: ./zsh and ./starship directories"
  exit 1
fi

echo "✅ Dotfiles repo root confirmed"

# ---- ZSH ----
if ! command -v zsh >/dev/null 2>&1; then
  echo "📦 Installing zsh..."
  sudo apt update
  sudo apt install -y zsh
else
  echo "✅ zsh already installed"
fi

# ---- SET DEFAULT SHELL ----
ZSH_PATH="$(which zsh)"
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  echo "🔁 Setting zsh as default shell..."
  chsh -s "$ZSH_PATH"
else
  echo "✅ zsh already default shell"
fi

# ---- STARSHIP ----
if ! command -v starship >/dev/null 2>&1; then
  echo "🚀 Installing starship (auto-accept)..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "✅ starship already installed"
fi

# ---- ANTIDOTE ----
ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"
if [[ ! -d "$ANTIDOTE_DIR" ]]; then
  echo "🧪 Installing antidote..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
else
  echo "✅ antidote already installed"
fi

# ---- STOW ----
if ! command -v stow >/dev/null 2>&1; then
  echo "📦 Installing stow..."
  sudo apt install -y stow
else
  echo "✅ stow already installed"
fi

# ---- LAZYGIT ----
if ! command -v lazygit >/dev/null 2>&1; then
  echo "🐙 Installing lazygit..."

  LAZYGIT_VERSION=$(
    curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" |
    grep -Po '"tag_name": *"v\K[^"]*'
  )

  (
    cd /tmp

    curl -Lo lazygit.tar.gz \
      "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/

    rm -f lazygit lazygit.tar.gz
  )
else
  echo "✅ lazygit already installed"
fi

# ---- LAZYGIT CONFIG (ALWAYS OVERRIDE) ----
LAZYGIT_CONFIG="$HOME/.config/lazygit/config.yml"

if command -v lazygit >/dev/null 2>&1; then
  echo "📝 Writing lazygit config (overriding existing file)..."

  mkdir -p "$(dirname "$LAZYGIT_CONFIG")"
  cat << 'EOF' > "$LAZYGIT_CONFIG"
gui:
  nerdFontsVersion: "3"

notARepository: "skip"
EOF
fi

# ---- RUN STOW ----
echo "🪄 Running stow..."

stow --target="$HOME" zsh
stow --target="$HOME/.config" starship

echo "✨ Bootstrap complete!"

# ---- AUTO RELOAD SHELL ----
echo "🔄 Reloading into zsh..."
exec zsh
