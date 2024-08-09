local class = require("pl.class")
local const = require("miriani.lib.audio.bass.constants")
local ffi = require("ffi")
local stream = require("miriani.lib.audio.bass.stream")

class.Bass()

  local bind = require("miriani.lib.audio.bindings.bass")

function Bass:Init(device, frequency, flags)

  device = device or -1

  frequency = frequency or 44100

  flags = flags or 0

  bind.BASS_Init(device, frequency, flags, nil, nil)

  return bind.BASS_ErrorGetCode()
end

function Bass:Free()

  bind.BASS_Free()

  return bind.BASS_ErrorGetCode()

end

function Bass:GetConfig(option)

  return bind.BASS_GetConfig(option)

end

function Bass:GetVersion()

  local version = bind.BASS_GetVersion()

  return version

end

function Bass:SetConfig(option, value)

  bind.BASS_SetConfig(option, value)

  return bind.BASS_ErrorGetCode()

end

function Bass:StreamCreate(freq, chans, flags)

  local handle = bind.BASS_StreamCreate(freq, chans, flags, -1, nil)

  if bind.BASS_ErrorGetCode() ~= const.error.ok then
    return bind.BASS_ErrorGetCode()
  else
    return stream(handle)
  end
end

function Bass:StreamCreateFile(mem, file, offset, length, flags)

  mem = mem or false
  offset = offset or 0
  length = length or 0
  flags = flags or const.stream.auto_free

  local sfile = ffi.new("char[?]", #file+1)
  ffi.copy(sfile, file)

  local handle = bind.BASS_StreamCreateFile(mem, sfile, offset, length, flags)

  if handle == 0 then
    return bind.BASS_ErrorGetCode()
  else
    return stream(handle)
  end

end


function Bass:SetAttribute(stream, attribute, value)
  return stream:SetAttribute(const.attribute[attribute], value)
end -- SetAttribute



return Bass