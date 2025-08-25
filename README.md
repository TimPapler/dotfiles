# Dotfiles

Personal development environment configuration for macOS.

## What's Included

### 🎨 Terminal & Editor
- **Neovim** - Modern Neovim setup with LSP, debugging, and Snacks.nvim ecosystem
- **Kitty** - GPU-accelerated terminal with Kanagawa theme

### 🐚 Shell
- **Zsh** - Oh-My-Zsh configuration with custom paths and aliases
- **Zprofile** - Homebrew and development tool paths

### 🤖 AI Assistant
- **Claude** - Programming philosophy and agent rules

### 🍺 Package Management
- **Brewfile** - Complete list of development tools, languages, and utilities

## Quick Start

### Prerequisites
1. macOS (Apple Silicon or Intel)
2. Git
3. Command Line Tools: `xcode-select --install`

### Installation

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH (Apple Silicon)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Clone this repository
git clone https://github.com/TimPapler/dotfiles.git ~/.config

# Install all packages
cd ~/.config && brew bundle

# Create symlinks for shell configs
ln -sf ~/.config/zshrc ~/.zshrc
ln -sf ~/.config/zprofile ~/.zprofile

# Reload shell
source ~/.zshrc
```

## Key Features

### Neovim Configuration
- **LSP Support** - Go, TypeScript, Python, Swift, Lua, YAML, CSS, Helm
- **Debugging** - Integrated DAP for Swift/iOS, JavaScript, Go, Python
- **Completion** - nvim-cmp with LuaSnip snippets
- **UI/UX** - Snacks.nvim for modern development experience
- **Performance** - Optimized lazy loading for fast startup

### Development Tools
- **Languages** - Go, Node.js, Python, Ruby, Lua, Swift
- **Version Control** - Git, GitHub CLI, Jujutsu
- **iOS/Swift** - Xcode build server, SwiftFormat, SwiftLint
- **Infrastructure** - Kubernetes, Helm, Ansible, Azure CLI
- **Keyboard Firmware** - QMK with AVR/ARM toolchains

### Shell Enhancements
- **Fuzzy Finding** - fzf integration
- **Fast Search** - ripgrep for code searching
- **Modern Tools** - fd, jq, yq, just, watchexec

## Customization

### Adding New Homebrew Packages
1. Install the package: `brew install <package>`
2. Update Brewfile: `brew bundle dump --file=~/.config/Brewfile --force`
3. Commit changes

### Modifying Neovim Config
Configuration files are in `~/.config/nvim/`:
- `lua/tim/plugins/` - Individual plugin configurations
- `lua/tim/set.lua` - Editor settings
- `lua/tim/remap.lua` - Key mappings

### Updating AI Assistant Rules
Edit `~/.config/ai/claude.md` for programming philosophy and guidelines.

## Keyboard Shortcuts

### Neovim (Leader = Space)
- `<leader>sf` - Find files
- `<leader>sg` - Grep search
- `<leader>pv` - File explorer (Oil)
- `<C-p>` - Quick file finder
- `<leader>z` - Zen mode
- `<leader>tg` - LazyGit

### Kitty
- `Cmd+T` - New tab
- `Cmd+W` - Close tab
- `Cmd+,` - Settings
- `Ctrl+Shift+Z` - Toggle layout

## License

MIT - Feel free to use and modify as needed.