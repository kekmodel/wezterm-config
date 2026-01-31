local wezterm = require 'wezterm'
local act = wezterm.action

return {
  -- 성능: GPU 가속
  front_end = "WebGpu",
  scrollback_lines = 100000,

  -- 폰트 (Menlo + 한글 폴백)
  font = wezterm.font_with_fallback({
    'Menlo',
    'Apple SD Gothic Neo',
  }),
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

    -- 패널 이동: h j k l
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

    -- Alt+방향키: 패널 이동 (바로)
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
