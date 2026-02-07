local wezterm = require 'wezterm'
local act = wezterm.action

return {
  -- === 렌더링 ===
  front_end = "OpenGL",
  scrollback_lines = 100000,

  -- === 외형 ===
  -- font = wezterm.font('Menlo'),
  font_size = 13.0,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  -- color_scheme = 'Atom',
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  inactive_pane_hsb = { brightness = 0.7 },

  -- === 마우스 ===
  selection_word_boundary = ' \t\n{}[]()"\':;,.<>~!@#$%^&*|+=',
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'ClipboardAndPrimarySelection',
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
  },

  -- === 하이퍼링크 ===
  hyperlink_rules = {
    { -- URL
      regex = [[\b\w+://[\w.-]+\.[a-z]{2,15}\S*\b]],
      format = '$0',
    },
    { -- ~/path
      regex = [[~/([\w\-\./]+)]],
      format = 'vscode://file/' .. wezterm.home_dir .. '/$1',
    },
    { -- /absolute/path (파일)
      regex = [[(/[\w\-\./]+\.[\w]+)]],
      format = 'vscode://file/$1',
    },
    { -- /absolute/path (디렉토리)
      regex = [[(/(?:[\w\-]+/)+[\w\-]+/?)]],
      format = 'vscode://file/$1',
    },
  },

  -- === 키바인딩 ===
  keys = {
    { key = 'a', mods = 'CMD', action = act.SendString '\x01' },              -- tmux prefix
    { key = 'LeftArrow', mods = 'CMD', action = act.SendString '\x1b[1;9D' }, -- tmux pane 이동
    { key = 'RightArrow', mods = 'CMD', action = act.SendString '\x1b[1;9C' },
    { key = 'UpArrow', mods = 'CMD', action = act.SendString '\x1b[1;9A' },
    { key = 'DownArrow', mods = 'CMD', action = act.SendString '\x1b[1;9B' },
  },

  -- === Mux 서버 ===
  unix_domains = {
    { name = 'unix' },
  },
  default_gui_startup_args = { 'connect', 'unix' },
}
