local wezterm = require 'wezterm'
local act = wezterm.action

-- 하이퍼링크: 기본 규칙(URL 등) 유지 + 파일 경로 규칙 추가
local hyperlinks = wezterm.default_hyperlink_rules()
table.insert(hyperlinks, { -- ~/path → vscode
  regex = [[~/([\w.@\-+/]+)]],
  format = 'vscode://file/' .. wezterm.home_dir .. '/$1',
})
table.insert(hyperlinks, { -- /absolute/path → vscode (파일:라인 포함)
  regex = [[((?:/[\w.@\-+]+)+(?::\d+(?::\d+)?)?)]],
  format = 'vscode://file/$1',
})

return {
  -- === 렌더링 ===
  front_end = "OpenGL",
  scrollback_lines = 100000,

  -- === 외형 ===
  font = wezterm.font_with_fallback {
    'SF Mono',
    'SF Pro',
  },
  font_size = 13.0,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  color_scheme = 'Dracula+',
  window_background_opacity = 0.95,
  macos_window_background_blur = 20,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  inactive_pane_hsb = { brightness = 0.7 },
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  window_decorations = "RESIZE",

  -- === 마우스 ===
  bypass_mouse_reporting_modifiers = 'CMD',
  selection_word_boundary = ' \t\n{}[]()"\':;,.<>~!@#$%^&*|+=',
  mouse_bindings = {
    { -- 클릭: 선택 완료 + 링크 있으면 열기 (tmux 안에서 Cmd+Click도 여기 매칭)
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.Multiple {
        act.CompleteSelection 'ClipboardAndPrimarySelection',
        act.OpenLinkAtMouseCursor,
      },
    },
    { -- Cmd+Click → 하이퍼링크 열기 (tmux 밖)
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
  },

  -- === 하이퍼링크 ===
  hyperlink_rules = hyperlinks,

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
