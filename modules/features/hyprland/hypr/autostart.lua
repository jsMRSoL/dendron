local pasting = "wl-paste -t text --watch clipman store --no-persist"

---- AUTOSTART ----
hl.on("hyprland.start", function()
  -- hl.exec_cmd("waybar")
  hl.exec_cmd("noctalia")
  hl.exec_cmd("dunst")
  hl.exec_cmd(pasting)
end)
