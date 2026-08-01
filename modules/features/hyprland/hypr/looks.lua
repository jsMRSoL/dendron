---- LOOK AND FEEL ----
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in          = 1,
    gaps_out         = 2,
    border_size      = 2,
    col              = {
      active_border   = "rgba(cba6f7ff)",
      inactive_border = "rgba(595959aa)",
    },
    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,
    allow_tearing    = false,
    layout           = "master",
  },

  decoration = {
    rounding         = 0,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  cursor = {
    hide_on_key_press = true,
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo   = true,
    key_press_enables_dpms  = true,
    mouse_move_enables_dpms = true,
  },
})
