local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font("Delugia", { weight = "Regular" })
config.font_size = 17.0

-- Window configuration
config.initial_cols = 121
config.initial_rows = 35
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.window_decorations = "RESIZE"

-- Scrollback
config.scrollback_lines = 10000

-- Color scheme (One Dark theme)
config.colors = {
	foreground = "#abb2bf",
	background = "#282c34",
	cursor_bg = "#abb2bf",
	cursor_fg = "#282c34",
	cursor_border = "#abb2bf",
	selection_bg = "#61afef", -- Bright blue selection background
	selection_fg = "#282c34", -- Dark foreground for contrast
	ansi = {
		"#282c34", -- black
		"#e06c75", -- red
		"#98c379", -- green
		"#d19a66", -- yellow
		"#61afef", -- blue
		"#c678dd", -- magenta
		"#56b6c2", -- cyan
		"#abb2bf", -- white
	},
	brights = {
		"#5c6370", -- bright black
		"#e06c75", -- bright red
		"#98c379", -- bright green
		"#d19a66", -- bright yellow
		"#61afef", -- bright blue
		"#c678dd", -- bright magenta
		"#56b6c2", -- bright cyan
		"#ffffff", -- bright white
	},
}

-- Tab bar styling (similar to tmux status bar)
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.colors.tab_bar = {
	background = "#234",
	active_tab = {
		bg_color = "#238",
		fg_color = "#81f",
		intensity = "Bold",
	},
	inactive_tab = {
		bg_color = "#235",
		fg_color = "#8a8",
	},
	inactive_tab_hover = {
		bg_color = "#236",
		fg_color = "#8a8",
	},
}

-- Mouse support (matching tmux mouse mode)
-- Auto-copy on selection and clear highlight (like tmux)
config.mouse_bindings = {
	-- Copy to clipboard on selection and clear highlight (mouse drag release)
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.Multiple({
			wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection"),
			wezterm.action.ClearSelection,
		}),
	},
	-- Extend selection on shift+click
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SHIFT",
		action = wezterm.action.Multiple({
			wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection"),
			wezterm.action.ClearSelection,
		}),
	},
}

-- Key bindings
config.leader = { key = "`", mods = "", timeout_milliseconds = 1000 }

config.keys = {
	-- Alt+Left/Right for word navigation
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action.SendString("\x1bb") },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendString("\x1bf") },

	-- Split panes (matching tmux h/v bindings)
	{ key = "h", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Pane navigation with Alt+Arrow (matching tmux)
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },

	-- Reload config (matching tmux)
	{ key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },

	-- Create/navigate tabs (replacing tmux windows)
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Tab selection with leader + number (1-9)
	{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },

	-- Copy mode (similar to tmux)
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

	-- Zoom pane (similar to tmux zoom)
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
}

-- Tab title formatting (show index starting from 1, like tmux)
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = string.format(" %d: %s ", tab.tab_index + 1, tab.active_pane.title)
	return {
		{ Text = title },
	}
end)

-- Shell configuration
config.default_prog = { "/bin/zsh", "-l" }

-- Automatically save and restore sessions (replaces tmux-resurrect/continuum)
config.automatically_reload_config = true

-- Window close confirmation (prevent accidental closes)
config.window_close_confirmation = "NeverPrompt"

-- Performance
config.enable_scroll_bar = false
config.front_end = "WebGpu"

return config
