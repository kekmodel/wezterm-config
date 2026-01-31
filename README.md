# WezTerm Config

Minimal WezTerm configuration for macOS with tmux-like keybindings.

## Features

- **GPU Accelerated**: WebGpu frontend
- **Font**: Menlo + Apple SD Gothic Neo (Korean fallback)
- **Theme**: Atom
- **Leader Key**: `Ctrl+A` (tmux style)
- **Copy on Select**: Drag to copy to clipboard

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+A` `\|` | Split vertical |
| `Ctrl+A` `-` | Split horizontal |
| `Ctrl+A` `c` | New tab |
| `Ctrl+A` `x` | Close pane |
| `Ctrl+A` `z` | Zoom pane |
| `Ctrl+A` `h/j/k/l` | Navigate panes (vim) |
| `Ctrl+A` `n/p` | Next/prev tab |
| `Ctrl+A` `1-5` | Go to tab |
| `Alt+Arrow` | Navigate panes |
| `Shift+Left/Right` | Navigate tabs |
| `Ctrl+A` `[` | Copy mode |

## Install

```bash
# Clone
git clone https://github.com/kekmodel/wezterm-config.git ~/wezterm-config

# Symlink
ln -sf ~/wezterm-config/wezterm.lua ~/.wezterm.lua
```

## Requirements

- [WezTerm](https://wezterm.org/)
- macOS (uses system fonts)
