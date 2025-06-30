# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a personal Neovim configuration using the modern Lazy.nvim plugin manager and Neovim's built-in LSP client.

### Configuration Structure
- `init.lua` - Entry point that loads the main configuration module
- `lua/tim/` - Main configuration namespace
  - `init.lua` - Loads core modules (remap, set, lazy)
  - `set.lua` - Neovim options and settings
  - `remap.lua` - Key mappings and leader key setup
  - `lazy.lua` - Plugin manager setup and plugin definitions
  - `plugins/` - Individual plugin configurations (imported by lazy.lua)

### Plugin Management
Uses Lazy.nvim with plugin configurations split into separate files under `lua/tim/plugins/`. Key plugins include:
- LSP: nvim-lspconfig with modern `vim.lsp.config()` API (Neovim 0.11+)
- Completion: blink.cmp (newer alternative to nvim-cmp)
- Fuzzy finding: Telescope with fzf-native
- File explorer: Oil.nvim
- Git integration: vim-fugitive
- Status line: lualine.nvim
- Colorscheme: kanagawa.nvim

### LSP Configuration
Located in `lua/tim/plugins/lspconfig.lua`. **Fully migrated to modern Neovim 0.11+ API**:
- Uses `vim.lsp.config()` and `vim.lsp.enable()` instead of legacy `lspconfig.setup()`
- Uses `LspAttach` autocommand for keymaps instead of `on_attach` functions
- Servers configured: cssls, gopls, helm_ls, sourcekit, pyright, lua_ls, ts_ls, yamlls, javascript
- Complex configurations preserved (gopls settings, yamlls schemas, sourcekit custom cmd)
- Still depends on nvim-lspconfig plugin for server configuration data

### Key Mappings
Leader key is set to space. Key mappings are centralized in `remap.lua` with additional LSP-specific mappings in the lspconfig plugin file.

## Development Commands

### Plugin Management
```bash
# Install/update plugins (automatic on startup)
nvim
```

### LSP Management (Modern API)
```bash
# Add new LSP server
vim.lsp.config('server_name', { capabilities = capabilities })
vim.lsp.enable('server_name')

# Configure server with settings
vim.lsp.config('server_name', {
  capabilities = capabilities,
  settings = { server_specific_settings = {} }
})
```

### Testing Configuration
```bash
# Start Neovim to test configuration
nvim

# Check plugin status
:Lazy

# Check LSP status
:LspInfo

# Check health
:checkhealth
```

### Troubleshooting
```bash
# Enable LSP debug logging (add to set.lua)
vim.lsp.set_log_level("debug")

# View LSP logs
:LspLog
```

## File Types and Language Servers
Custom filetype detection for `.metal` files is configured in `set.lua`. Language servers are configured per-language in the lspconfig plugin.

## Key Directories
- `after/plugin/` - Plugin-specific configurations that load after plugins
- `ftdetect/` - Filetype detection rules
- `lazy-lock.json` - Locked plugin versions (similar to package-lock.json)