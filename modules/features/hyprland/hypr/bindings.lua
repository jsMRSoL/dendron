---- KEYBINDINGS ----
local mainMod = "SUPER"
local terminal  = "foot"
local menu      = "wofi --insensitive --show drun"
local menu_term = "foot -e wofi --insensitive --show run"

local bind_launcher = function(keybind, action)
  hl.bind(keybind, hl.dsp.exec_cmd(action))
end

local launch_bindings = {
  { mainMod .. " + Delete",         "systemctl suspend" },
  { mainMod .. " + SHIFT + Delete", "systemctl poweroff" },
  { mainMod .. " + SHIFT + Q",      "wlogout -s" },
  { mainMod .. " + SHIFT + S",      "waylock" },
  { mainMod .. " + B",              "pkill waybar || waybar &" },
  { mainMod .. " + SHIFT + RETURN", terminal },
  { mainMod .. " + P",              menu },
  { mainMod .. " + SHIFT + P",      menu_term },
  { "CTRL + ALT + P",               "mypassmenu" },
  { mainMod .. " + INSERT",         "clipman pick -t wofi" },
  { mainMod .. " + F1",             "foot -e tmux-sessionizer.sh home &" },
  { mainMod .. " + F8",             "emacs &" },
  { "SHIFT + F10",                  "hyprshot -m window" },
  { "SHIFT + ALT + F10",            "hyprshot -m region" },
}

for _, binding in ipairs(launch_bindings) do
  bind_launcher(binding[1], binding[2])
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

---  Binds for layouts and orientation
local layout_bindings = {
  { mainMod .. " + SHIFT + C", hl.dsp.window.close() },
  { mainMod .. " + H",         hl.dsp.focus({ direction = "left" }) },
  { mainMod .. " + J",         hl.dsp.layout("cyclenext") },
  { mainMod .. " + SHIFT + J", hl.dsp.layout("swapnext") },
  { mainMod .. " + K",         hl.dsp.layout("cycleprev") },
  { mainMod .. " + SHIFT + K", hl.dsp.layout("swapprev") },
  { mainMod .. " + L",         hl.dsp.focus({ direction = "right" }) },
  { mainMod .. " + RETURN", function()
    hl.dispatch(hl.dsp.layout("swapwithmaster master"))
  end },
  { mainMod .. " + I", function()
    hl.dispatch(hl.dsp.layout("addmaster"))
  end },
  { mainMod .. " + D", function()
    hl.dispatch(hl.dsp.layout("removemaster"))
  end },
  { mainMod .. " + SHIFT + T", hl.dsp.group.toggle() },
  { mainMod .. " + N",         hl.dsp.group.next() },
  { mainMod .. " + SHIFT + N", hl.dsp.group.prev() },
  { mainMod .. " + F",         hl.dsp.window.float({ action = "toggle" }) },
  { mainMod .. " + M",         hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }) },
  { mainMod .. " + SHIFT + M", function()
    hl.config({
      general = {
        layout = "monocle"
      }
    })
  end },
  { mainMod .. " + T", function()
    hl.config({
      general = {
        layout = "master",
      }
    })
    hl.dispatch(hl.dsp.layout("orientationleft"))
  end },
  { mainMod .. " + U", function()
    hl.config({
      general = {
        layout = "master",
      }
    })
    hl.dispatch(hl.dsp.layout("orientationtop"))
  end },
  { mainMod .. " + SPACE", function()
    hl.config({
      general = {
        layout = "master",
      }
    })
    hl.dispatch(hl.dsp.layout("orientationnext"))
  end },
}

for _, binding in ipairs(layout_bindings) do
  hl.bind(binding[1], binding[2])
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

---  SUBMAPS  ---
hl.bind(mainMod .. " + ESCAPE", hl.dsp.submap("passthru"))

-- Start a submap called "passthru".
hl.define_submap("passthru", function()
  -- Set binds e.g.
  -- hl.bind("down", hl.resize({ x = 10, y = -10, relative = true}), { repeating = true })

  -- Use `reset` to go back to the global submap
  hl.bind("escape", hl.dsp.submap("reset"))
end)
