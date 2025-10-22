-- Hammerspoon config for listen-live
-- True Push-to-Talk: Hold Cmd+\ to record

local isRecording = false

-- Event tap to catch key press and release
eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(e)
  local flags = e:getFlags()
  local keyCode = e:getKeyCode()
  
  -- Backslash is keyCode 42
  if keyCode == 42 and flags.cmd and not flags.shift and not flags.alt and not flags.ctrl then
    if e:getType() == hs.eventtap.event.types.keyDown then
      -- Key pressed - start recording
      if not isRecording then
        isRecording = true
        os.execute("touch /tmp/listen_ptt_start")
        hs.notify.new({title="Listen PTT", informativeText="🔴 Recording..."}):send()
      end
      return true -- consume the event
    elseif e:getType() == hs.eventtap.event.types.keyUp then
      -- Key released - stop recording
      if isRecording then
        isRecording = false
        os.execute("touch /tmp/listen_ptt_stop")
        hs.notify.new({title="Listen PTT", informativeText="✅ Stopped"}):send()
      end
      return true -- consume the event
    end
  end
  
  return false -- pass through other events
end)

eventtap:start()

hs.alert.show("Hammerspoon PTT loaded - Hold Cmd+\\ to record!")
