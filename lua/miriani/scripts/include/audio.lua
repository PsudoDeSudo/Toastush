-- @module audio
-- Provides a class for creating and manipulating audio streams.

-- Author: Erick Rosso
-- Last updated 2022.01.21

---------------------------------------------

local class = require("pl.class")
local path = require("pl.path")
local bass = require("miriani.lib.audio.bass")


class.Audio(bass)

Audio.const = require("miriani.lib.audio.bass.constants")

Audio.const["streams"] = {}
Audio.const["stopped"] = 0
Audio.const["playing"] = 1
Audio.const["paused"] = 3

Audio.ERROR = {
  ok = 0,
  invalid_file = 1,
  unknown = -1
}

function Audio:_init()
  self.Init()
  return self.ERROR.ok
end -- _init

function Audio:play(mem, file, vol, pan, fq, flag)

  if not path.isfile(file) then
    return self.ERROR.invalid_file
  end -- if

  local stream = bass:StreamCreateFile(mem, file, 0, 0, flag)

  if type(stream) ~= 'table' then
    return self.ERROR.unknown
  end -- if

  bass:SetAttribute(stream, "volume", tonumber(vol))
  bass:SetAttribute(stream, "pan", tonumber(pan))
  --bass:SetAttribute(stream, "frequency", tonumber(fq))

  -- Push onto the streams.
  self.const.streams[file] = stream

  local handle = stream:Play()
  -- clean up
  for key, media in pairs(self.const.streams) do
    if media:IsActive() == self.const.stopped then
      self.const.streams[key] = nil
    end -- if
  end -- for

  return handle
end -- play

function Audio:stop(file)

  if (self.const.streams[file] ~= nil) then
    self.const.streams[file]:Stop()
    self.const.streams[file] = nil

    return 1
  end -- if
end -- stop

function Audio:slide(name, attribute, val, time)

  local attr = self.const.attribute[string.lower(attribute)]
  if (self.const.streams[name] ~= nil)
  and attr ~= nil then
    self.const.streams[name]:SlideAttribute(attr, val, time)
  end -- if

end -- Audio:slide

function Audio:is_active(name)

  if (self.const.streams[name] ~= nil) then

    return (self.const.streams[name]:IsActive() == self.const.playing)
  end -- if

  return 0
end -- Audio:is_active

function Audio:pause(file)

  if (self.const.streams[file] ~= nil) then
    self.const.streams[file]:Pause()
    return 1
  end -- if
end -- pause

function Audio:resume(file)

  if (self.const.streams[file] ~= nil)
  and (self.const.streams[file]:IsActive() == self.const.paused) then
    self.const.streams[file]:Play()
    return 1
  end -- if
end -- resume

return Audio