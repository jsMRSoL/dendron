---- AUTOSTART ----
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
  hl.exec_cmd("wl-paste -t text --watch clipman store --no-persist")
end)
