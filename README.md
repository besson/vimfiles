# vimfiles

My personal Vim configuration.

This repo is meant to be cloned directly to `~/.vim` (so `~/.vim` *is* the repo).
Plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug) and are
**not** committed — they auto-install on first launch.

## Installation (new machine)

**Prerequisites:** `git`, `curl`, `vim` (8+), and `pipx`.

```bash
# 1. Clone the repo into ~/.vim and link the vimrc
git clone git@github.com:besson/vimfiles.git ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
mkdir -p ~/.vim/undo          # for persistent undo

# 2. Open Vim — vim-plug and all plugins install automatically on first launch.
#    Wait for it to finish, then restart Vim.
vim

# 3. Install the external tools used for Python linting/completion
pipx install flake8
pipx install python-lsp-server
```

That's it. Steps 1 and 3 are the only manual commands; the plugin manager and all
plugins bootstrap themselves the first time you open Vim.

## What's inside

### Plugins (via vim-plug)
| Plugin | Purpose |
|--------|---------|
| `preservim/nerdtree` | File explorer (`<C-n>` toggles) |
| `dense-analysis/ale` | Async linting + LSP completion |
| `tmhedberg/SimpylFold` | Python-aware folding |
| `junegunn/fzf` + `fzf.vim` | Fuzzy finder |
| `vim-airline/vim-airline` (+ themes) | Statusline |
| `jlanzarotta/bufexplorer` | Buffer browser |
| `preservim/nerdcommenter` | Commenting |
| `altercation/vim-colors-solarized`, `NLKNguyen/papercolor-theme` | Colorschemes |

### External tools
- **flake8** — Python linting (via ALE)
- **python-lsp-server** (`pylsp`) — completion + go-to-definition

### Handy mappings
Leader key is `,`.

| Mapping | Action |
|---------|--------|
| `<C-n>` | Toggle NERDTree |
| `<C-p>` | fzf file search |
| `<leader>b` | fzf buffers |
| `<leader>f` | fzf ripgrep search |
| `<leader>g` | Go to definition (ALE/LSP) |
| `<leader>r` | Find references |
| `K` | Hover docs |
| `<space>` | Toggle fold |
| `<leader>n` | Rename current file |
| `<leader><leader>` | BufExplorer |
| `<Right>` / `<Left>` | Next / previous buffer |

## Maintenance

```vim
:PlugInstall    " install newly added plugins
:PlugUpdate     " update all plugins
:PlugClean      " remove unused plugins
```
