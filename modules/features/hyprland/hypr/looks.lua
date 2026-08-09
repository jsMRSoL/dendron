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

  group = {
    col      = {
      border_active   = "rgba(cba6f7ff)",
      border_inactive = "rgba(595959aa)",
    },
    groupbar = {
      enabled = true,
      gradients = false,
      height = 1,
      text_offset = -13,
      indicator_height = 25,
      font_size = 11,
      font_weight_active = "bold",
      font_weight_inactive = "normal",

      render_titles = true,
      text_color = "rgba(cdd6f4ff)",

      col = {
        active = "rgba(1e1e2eff)",
        inactive = "rgba(313244ff)",
      },
    },
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo   = true,
    key_press_enables_dpms  = true,
    mouse_move_enables_dpms = true,
  },
})

hl.animation({ leaf = "fadeSwitch", enabled = false })
hl.animation({ leaf = "fadeIn", enabled = false })
hl.animation({ leaf = "windowsIn", enabled = false })
