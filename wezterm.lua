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
  font = wezterm.font('Menlo'),
  font_size = 13.0,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  -- 테마
  color_scheme = 'Atom',

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

  -- Leader: Ctrl+A (tmux)
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },

  keys = {
    -- 분할: | -
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

    -- 탭: c x z n p
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

    -- Alt+방향키: 패널 이동
    { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

    -- Shift+방향키: 탭 이동 (바로)
    { key = 'LeftArrow', mods = 'SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'RightArrow', mods = 'SHIFT', action = act.ActivateTabRelative(1) },

    -- 복사 모드
    { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

    -- 탭 번호 1-5
    { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
    { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
    { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
    { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
    { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
  },
}
