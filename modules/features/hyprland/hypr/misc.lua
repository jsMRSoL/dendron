---- ENVIRONMENT VARIABLES ----
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GTK_THEME", "catppuccin-gtk")

---  Switches  ---
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("swaylock && systemctl suspend"))
