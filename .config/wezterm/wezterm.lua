local wezterm = require('wezterm')
local config = wezterm.config_builder()
local act = wezterm.action

-- ============================================
-- COLOR SCHEME - Gruvbox Dark
-- ============================================
config.colors = {
  -- Background/Foreground
  background = '#1d2021',
  foreground = '#ebdbb2',
  
  -- Cursor
  cursor_bg = '#fabd2f',
  cursor_fg = '#1d2021',
  cursor_border = '#fabd2f',
  
  -- Selection
  selection_bg = '#fabd2f',
  selection_fg = '#1d2021',
  
  -- Split/Border colors
  split = '#fabd2f',
  
  -- Tab bar
  tab_bar = {
    background = 'rgba(0, 0, 0, 0)',
    active_tab = {
      bg_color = 'rgba(0, 0, 0, 0)',
      fg_color = '#ebdbb2',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = 'rgba(0, 0, 0, 0)',
      fg_color = '#a89984',
    },
    new_tab = {
      bg_color = 'rgba(0, 0, 0, 0)',
      fg_color = '#a89984',
    },
  },
}

-- ============================================
-- APPEARANCE
-- ============================================
config.font = wezterm.font('JetBrains Mono')
config.font_size = 16.0
config.enable_tab_bar = true
config.use_fancy_tab_bar = true  -- Switch to fancy for better padding control
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.window_background_opacity = 1.0
config.window_decorations = 'RESIZE'

-- Tab bar styling (minimal like retro mode)
config.tab_max_width = 32

-- Add after the window_padding section
config.window_frame = {
  font = wezterm.font('JetBrains Mono', { weight = 'Bold' }),
  font_size = 14.0,
}

-- -- ============================================
-- -- WINDOW PADDING (add spacing around terminal)
-- -- ============================================
-- config.window_padding = {
--   left = '1.5cell',
--   right = '1cell',
--   top = '1cell',
--   bottom = '0.5cell',
-- }


-- ============================================
-- BEHAVIOR
-- ============================================
config.automatically_reload_config = true
config.enable_scroll_bar = false
config.scrollback_lines = 10000
config.enable_kitty_keyboard = true

-- Mouse bindings
config.mouse_bindings = {
  -- Paste on right click
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.PasteFrom('Clipboard'),
  },
}

-- ============================================
-- KEY BINDINGS (tmux-style with Ctrl+a leader)
-- ============================================
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Reload config (Ctrl+a r)
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ReloadConfiguration,
  },
  
  -- Split panes (Ctrl+a = horizontal, Ctrl+a - vertical)
  {
    key = '=',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  
  -- Navigate panes with hjkl (Ctrl+a h/j/k/l)
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Left'),
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Down'),
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Up'),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Right'),
  },
  
  -- Close pane (Ctrl+a x)
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },
  
  -- Create new tab (Ctrl+a c)
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab('CurrentPaneDomain'),
  },
  
  -- Navigate tabs (Ctrl+a 1-9)
  {
    key = '1',
    mods = 'LEADER',
    action = act.ActivateTab(0),
  },
  {
    key = '2',
    mods = 'LEADER',
    action = act.ActivateTab(1),
  },
  {
    key = '3',
    mods = 'LEADER',
    action = act.ActivateTab(2),
  },
  {
    key = '4',
    mods = 'LEADER',
    action = act.ActivateTab(3),
  },
  {
    key = '5',
    mods = 'LEADER',
    action = act.ActivateTab(4),
  },
  {
    key = '6',
    mods = 'LEADER',
    action = act.ActivateTab(5),
  },
  {
    key = '7',
    mods = 'LEADER',
    action = act.ActivateTab(6),
  },
  {
    key = '8',
    mods = 'LEADER',
    action = act.ActivateTab(7),
  },
  {
    key = '9',
    mods = 'LEADER',
    action = act.ActivateTab(8),
  },
  
  -- Copy mode (Ctrl+a [)
  {
    key = '[',
    mods = 'LEADER',
    action = act.ActivateCopyMode,
  },
  
  -- Paste (Ctrl+a ])
  {
    key = ']',
    mods = 'LEADER',
    action = act.PasteFrom('Clipboard'),
  },
  
  -- Zoom pane (Ctrl+a z)
  {
    key = 'z',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },

  -- Rename tab (Ctrl+a ,) — tmux-style
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },

  -- Option+Arrow keys for word movement
  {
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action.SendString '\x1bb',
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action.SendString '\x1bf',
  },
}

-- ============================================
-- COPY MODE (vi-like bindings)
-- ============================================
config.key_tables = {
  copy_mode = {
    { key = 'Escape', action = act.CopyMode('Close') },
    { key = 'q', mods = 'NONE', action = act.CopyMode('Close') },
    
    -- Movement (vi-style)
    { key = 'h', mods = 'NONE', action = act.CopyMode('MoveLeft') },
    { key = 'j', mods = 'NONE', action = act.CopyMode('MoveDown') },
    { key = 'k', mods = 'NONE', action = act.CopyMode('MoveUp') },
    { key = 'l', mods = 'NONE', action = act.CopyMode('MoveRight') },
    
    -- Word movement
    { key = 'w', mods = 'NONE', action = act.CopyMode('MoveForwardWord') },
    { key = 'b', mods = 'NONE', action = act.CopyMode('MoveBackwardWord') },
    { key = 'e', mods = 'NONE', action = act.CopyMode('MoveForwardWordEnd') },
    
    -- Line movement
    { key = '0', mods = 'NONE', action = act.CopyMode('MoveToStartOfLine') },
    { key = '$', mods = 'NONE', action = act.CopyMode('MoveToEndOfLineContent') },
    { key = '^', mods = 'NONE', action = act.CopyMode('MoveToStartOfLineContent') },
    
    -- Page movement
    { key = 'g', mods = 'NONE', action = act.CopyMode('MoveToScrollbackTop') },
    { key = 'G', mods = 'NONE', action = act.CopyMode('MoveToScrollbackBottom') },
    { key = 'u', mods = 'CTRL', action = act.CopyMode('PageUp') },
    { key = 'd', mods = 'CTRL', action = act.CopyMode('PageDown') },
    
    -- Selection
    { key = 'v', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Cell' }) },
    { key = 'V', mods = 'NONE', action = act.CopyMode({ SetSelectionMode = 'Line' }) },
    { key = 'v', mods = 'CTRL', action = act.CopyMode({ SetSelectionMode = 'Block' }) },
    
    -- Copy (y yanks to clipboard)
    {
      key = 'y',
      mods = 'NONE',
      action = act.Multiple({
        { CopyTo = 'ClipboardAndPrimarySelection' },
        { CopyMode = 'Close' },
      }),
    },
  },
}

-- ============================================
-- TAB BAR FORMATTING (shows: 🦅 1:bash 2:nmap 3:rustc)
-- ============================================
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.tab_title
  -- Use custom title if set, otherwise fall back to process name
  if not title or #title == 0 then
    title = tab.active_pane.title
  end
  title = tab.tab_index + 1 .. ':' .. title

  -- Bold for active tab
  if tab.is_active then
    return {
      { Text = ' ' .. title .. ' ' },
    }
  end

  return ' ' .. title .. ' '
end)

wezterm.on('update-status', function(window, pane)
  -- Left status: emoji with padding using wezterm.format
  window:set_left_status(wezterm.format({
    { Background = { Color = 'rgba(0, 0, 0, 0)' } },
    { Foreground = { Color = '#ebdbb2' } },
    { Text = '  🦅  ' },  -- Added spaces around emoji for breathing room
  }))
  
  -- Right status: empty
  window:set_right_status('')
end)

-- ============================================
-- TERMINAL SETTINGS
-- ============================================
config.term = 'wezterm'
config.enable_wayland = false  -- Better compatibility on Linux

return config

