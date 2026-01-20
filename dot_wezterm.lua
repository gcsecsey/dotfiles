local wezterm = require 'wezterm'

return {
  font = wezterm.font('JetBrains Mono'),
  font_size = 14.0,
  window_close_confirmation = "NeverPrompt",
  bold_brightens_ansi_colors = "BrightAndBold",
  use_fancy_tab_bar = true,
}
