# Shell Dotfiles

A modern, feature-rich ZSH configuration with automated setup for a powerful terminal experience.

## 🌟 Features

- **ZSH Shell** - Fast, customizable shell with extensive plugin support
- **Starship Prompt** - Blazingly fast, customizable prompt with rich information display
- **Antidote Plugin Manager** - Lightweight, fast plugin management for ZSH
- **Fish-like Features**:
  - Syntax highlighting
  - Autosuggestions
  - History substring search
- **JetBrains Mono Nerd Font** - Beautiful monospace font with icon support
- **Lazygit** - Terminal UI for git with Nerd Font icons
- **GNU Stow** - Symlink management for dotfiles
- **Pre-configured Aliases** - Useful shortcuts for common commands

## 📋 Prerequisites

- **Operating System**: Linux (Debian/Ubuntu-based distributions)
- **Permissions**: `sudo` access for package installations
- **Internet Connection**: Required for downloading tools and fonts

## 🚀 Installation

1. Clone this repository:
```bash
git clone https://github.com/TechieOllie/shell_dotfiles.git
cd shell_dotfiles
```

2. Run the setup script:
```bash
./setup.sh
```

The script will:
- ✅ Check if the git repository is up to date
- 🔤 Install JetBrains Mono Nerd Font
- 📦 Install ZSH and set it as the default shell
- 🚀 Install Starship prompt
- 🧪 Install Antidote plugin manager
- 📦 Install GNU Stow for dotfile management
- 🐙 Install Lazygit with Nerd Font configuration
- 🪄 Symlink configuration files using Stow
- 🔄 Automatically reload into ZSH

## 📦 What Gets Installed

### Tools
- **ZSH** - Your new default shell
- **Starship** - Cross-shell prompt
- **Antidote** - ZSH plugin manager
- **GNU Stow** - Symlink farm manager
- **Lazygit** - Terminal UI for git commands
- **Unzip** - Archive extraction utility

### Fonts
- **JetBrains Mono Nerd Font** - Installed to `~/.local/share/fonts/`

### ZSH Plugins (via Antidote)
- `mattmc3/ez-compinit` - Completion initialization
- `zsh-users/zsh-completions` - Additional completions
- `ohmyzsh/ohmyzsh` (lib and colored-man-pages) - Oh My Zsh utilities
- `zdharma-continuum/fast-syntax-highlighting` - Syntax highlighting
- `zsh-users/zsh-autosuggestions` - Command suggestions
- `zsh-users/zsh-history-substring-search` - History search

## ⚙️ Configuration

### ZSH Configuration (`.zshrc`)
Located in `zsh/.zshrc`, includes:
- Flutter path configuration
- SSH agent auto-start
- Antidote plugin loading
- Alias loading
- Starship initialization

### Aliases (`.zsh_aliases`)
Pre-configured aliases:
- `l` - List files
- `ll` - List files in long format
- `la` - List all files including hidden
- `lg` - Launch Lazygit

### Starship Prompt (`starship.toml`)
Custom prompt configuration with:
- Username display
- Current directory (truncated to 8 levels)
- Git branch information
- Custom format and colors
- WSL path substitution for `/mnt/c` → `󰍲`

## 🎨 Customization

### Adding ZSH Plugins
Edit `zsh/.zsh_plugins.txt` and add plugin names:
```
username/plugin-name
```
Then regenerate the plugin file:
```bash
rm ~/.zsh_plugins.zsh && source ~/.zshrc
```

### Modifying Aliases
Edit `zsh/.zsh_aliases` and reload:
```bash
source ~/.zsh_aliases
```

### Customizing Starship
Edit `starship/starship.toml` with your preferred configuration. See [Starship documentation](https://starship.rs/config/) for options.

## 📁 Project Structure

```
shell_dotfiles/
├── setup.sh              # Automated installation script
├── zsh/                  # ZSH configuration
│   ├── .zshrc           # Main ZSH configuration file
│   ├── .zsh_aliases     # Command aliases
│   └── .zsh_plugins.txt # Antidote plugin list
└── starship/            # Starship configuration
    └── starship.toml    # Starship prompt configuration
```

## 🔄 Updating

To update your dotfiles:

1. Pull the latest changes:
```bash
cd ~/path/to/shell_dotfiles
git pull
```

2. Re-run the setup script:
```bash
./setup.sh
```

## 🛠️ Troubleshooting

### Font not displaying correctly
- Ensure your terminal is configured to use "JetBrains Mono Nerd Font"
- Run `fc-cache -fv` to refresh the font cache

### ZSH not default shell
- Run: `chsh -s $(which zsh)`
- Log out and log back in

### Plugins not loading
- Delete `~/.zsh_plugins.zsh` and restart your shell
- Check that `~/.antidote` directory exists

## 📝 License

This project is open source and available for personal use.

## 🤝 Contributing

Feel free to fork this repository and customize it for your needs!
