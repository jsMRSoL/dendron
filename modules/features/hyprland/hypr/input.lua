---- INPUT ----
hl.config({
  input = {
    kb_layout    = "us,gr,gb",
    kb_variant   = ",polytonic,",
    kb_options   = "ctrl:nocaps",
    follow_mouse = 1,
    touchpad     = {
      natural_scroll = false,
      disable_while_typing = true,
    },
    sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Example per-device config
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })

---  Keyboard layout switching  ---
-- hl.bind("SHIFT + F2", function()
--   hl.dispatch(hl.dsp.exec_cmd("hyprctl switchxkblayout at-translated-set-2-keyboard next"))
--   hl.dispatch(hl.dsp.exec_cmd("hyprctl switchxkblayout usb-hid-keyboard next"))
-- end)
hl.bind("SHIFT + F2", function()
  hl.dispatch(hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))
end)
