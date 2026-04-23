local json = require("hs.json")

hs.autoLaunch(true)


local chooser -- keep reference so it doesn't get GC'd

local function aerospaceBindings(mode, cb)
  local cmd = string.format("aerospace config --get 'mode.%s.binding' --json", mode)

  hs.task.new("/bin/bash", function(exitCode, stdout, stderr)
    if exitCode ~= 0 then
      cb(nil, stderr)
      return
    end

    local t = json.decode(stdout) or {}
    local choices = {}

    for k, v in pairs(t) do
      local action
      if type(v) == "table" then
        -- arrays in JSON become Lua tables; join for display
        action = table.concat(v, " ; ")
      else
        action = tostring(v)
      end

      table.insert(choices, {
        text = k,
        subText = action,
      })
    end

    table.sort(choices, function(a, b) return a.text < b.text end)
    cb(choices, nil)
  end, { "-lc", cmd }):start()
end

local function toggleAeroKeys(mode)
  mode = mode or "main"

  if chooser and chooser:isVisible() then
    chooser:hide()
    return
  end

  chooser = hs.chooser.new(function(choice)
    if not choice then return end
    -- copy "key -> action" to clipboard
    hs.pasteboard.setContents(choice.text .. " -> " .. (choice.subText or ""))
  end)

  chooser:searchSubText(true)
  chooser:placeholderText("AeroSpace keybindings (" .. mode .. ") — Enter copies to clipboard")

  aerospaceBindings(mode, function(choices, err)
    if not choices then
      hs.alert.show("AeroSpace error: " .. (err or "unknown"))
      return
    end
    chooser:choices(choices)
    chooser:show()
  end)
end

-- Hotkeys (change as you like; pick something not used by AeroSpace)
hs.hotkey.bind({ "alt" }, "o", function() toggleAeroKeys("main") end)
-- hs.hotkey.bind({ "alt", "shift" }, "/", function() toggleAeroKeys("service") end)

local function reload_sketchybar()
  -- Use whichever is more reliable for you:
  -- hs.execute("sketchybar --reload")      -- if your setup supports it
  hs.execute("pkill sketchybar; open -ga SketchyBar") -- robust “hard restart”
end

screenWatcher = hs.screen.watcher.new(function()
  hs.timer.doAfter(0.5, reload_sketchybar) -- small delay helps after hotplug
end)
screenWatcher:start()
