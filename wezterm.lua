local wezterm = require 'wezterm'
local act = wezterm.action

return {
  -- 성능: OpenGL (WebGPU는 메모리 누수 이슈 있음)
  front_end = "OpenGL",
  scrollback_lines = 100000,

  -- Mux 서버 설정 (원격 접속용)
  unix_domains = {
    { name = 'unix' },
  },
  default_gui_startup_args = { 'connect', 'unix' },

  -- 폰트
  -- font = wezterm.font('Menlo'),
  font_size = 13.0,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  -- 테마
  -- color_scheme = 'Atom',

  -- 탭바
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,

  -- 패널 구분
  inactive_pane_hsb = { brightness = 0.7 },

  -- 드래그 선택 시 자동 복사
  selection_word_boundary = ' \t\n{}[]()"\':;,.<>~!@#$%^&*|+=',
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'ClipboardAndPrimarySelection',
    },
    -- Cmd+Click으로 hyperlink 열기 (macOS)
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
  },

  hyperlink_rules = {
    -- URL
    {
      regex = [[\b\w+://[\w.-]+\.[a-z]{2,15}\S*\b]],
      format = '$0',
    },
    -- ~/path → vscode://file//Users/jd/path (홈디렉토리 확장)
    {
      regex = [[~/([\w\-\./]+)]],
      format = 'vscode://file/' .. wezterm.home_dir .. '/$1',
    },
    -- /absolute/path (파일 - 확장자 있음)
    {
      regex = [[(/[\w\-\./]+\.[\w]+)]],
      format = 'vscode://file/$1',
    },
    -- /absolute/path (디렉토리 - 2단계 이상 경로)
    {
      regex = [[(/(?:[\w\-]+/)+[\w\-]+/?)]],
      format = 'vscode://file/$1',
    },
  },

  keys = {
    -- Shift+Enter: 줄바꿈 (Claude Code 등에서 사용)
    { key = 'Enter', mods = 'SHIFT', action = act.SendString '\x1b[13;2u' },

    -- Cmd+방향키: tmux pane 이동 (Meta modifier=9 시퀀스 전송)
    { key = 'LeftArrow', mods = 'CMD', action = act.SendString '\x1b[1;9D' },
    { key = 'RightArrow', mods = 'CMD', action = act.SendString '\x1b[1;9C' },
    { key = 'UpArrow', mods = 'CMD', action = act.SendString '\x1b[1;9A' },
    { key = 'DownArrow', mods = 'CMD', action = act.SendString '\x1b[1;9B' },
  },
}
