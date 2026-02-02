# WezTerm Config

Minimal WezTerm configuration for macOS with tmux-like keybindings.

## Features

- **GPU Accelerated**: OpenGL frontend (WebGPU has memory leak issues)
- **Font**: Menlo
- **Theme**: Atom
- **Leader Key**: `Ctrl+A` (tmux style)
- **Copy on Select**: Drag to copy to clipboard
- **Hyperlink**: Cmd+Click to open file paths in VS Code
- **Session Restore**: Auto-connect to Mux server on app launch (close window, reopen = session restored)

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+A` `\|` | Split vertical |
| `Ctrl+A` `-` | Split horizontal |
| `Ctrl+A` `c` | New tab |
| `Ctrl+A` `x` | Close pane |
| `Ctrl+A` `z` | Zoom pane |
| `Ctrl+A` `n/p` | Next/prev tab |
| `Ctrl+A` `1-5` | Go to tab |
| `Alt+Arrow` | Navigate panes |
| `Shift+Left/Right` | Navigate tabs |
| `Ctrl+A` `[` | Copy mode |
| `Cmd+Click` | Open file path in VS Code |

## Hyperlink Rules

터미널 출력에서 파일 경로를 `Cmd+Click`으로 클릭하면 VS Code에서 열립니다.

| Path Type | Example | Supported |
|-----------|---------|-----------|
| Home path | `~/Documents/file.txt` | O |
| Absolute file | `/Users/name/file.txt` | O |
| Absolute directory | `/Users/name/project/src` | O |
| Relative path | `./src/main.rs` | X |

> Note: 상대경로(`./`, `../`)는 URL에서 현재 작업 디렉토리를 알 수 없어 지원되지 않습니다.
> 디렉토리 경로는 2단계 이상(`/a/b`)일 때만 인식됩니다 (오탐지 방지).

## Install

```bash
# Clone
git clone https://github.com/kekmodel/wezterm-config.git ~/wezterm-config

# Symlink
ln -sf ~/wezterm-config/wezterm.lua ~/.wezterm.lua
```

## Requirements

- [WezTerm](https://wezterm.org/)
- [VS Code](https://code.visualstudio.com/) (for hyperlink feature)
- macOS (uses system fonts)
