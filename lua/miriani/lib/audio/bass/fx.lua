local class = require("pl.class")
local const = require("miriani.lib.audio.bass.constants")
local ffi = require("ffi")

class.FX()

function FX:_init(handle, channel, fx)

  self.bass = require("miriani.lib.audio.bindings.bass")
  self.id = handle
  self.channel = channel

  if self._parameters[fx] == nil then
    error("no parameter type found for fx "..tostring(fx))
  end

  self.Parameters = self._parameters[fx]()
  self:GetParameters()

end

function FX:GetParameters()

  self.bass.BASS_FXGetParameters(self.id, self.Parameters:GetPointer())

  return self.bass.BASS_ErrorGetCode()

end

function FX:Remove()

  self.bass.BASS_ChannelRemoveFX(self.channel, self.id)

  return self.bass.BASS_ErrorGetCode()

end

function FX:Reset()

  self.bass.BASS_FXReset(self.id)

  return self.bass.BASS_ErrorGetCode()

end

function FX:SetParameters(parameters)

  self.bass.BASS_FXSetParameters(self.id, parameters:GetPointer())

  return self.bass.BASS_ErrorGetCode()

end

-- some convenience

function FX:Update()

  -- we will try to set the current parameters

  local success = self:SetParameters(self.Parameters)

  -- if we succeeded, we will just return it
  -- otherwise, we will grab the last valid parameters from within bass
  -- that way, our parameters class will always up-to-date after updating

  if success ~= const.error.ok then
    local get_success = self:GetParameters(self.Parameters)

    if get_success ~= const.error.ok then
      error("getting parameters within update failed. this shouldn't happen. please contact the developer.")
    end

  end

  return success

end

FX._parameters = {
  [const.fx.dx8_chorus] = require("miriani.lib.audio.bass.fxparameters.dx8_chorus"),
  [const.fx.dx8_compressor] = require("miriani.lib.audio.bass.fxparameters.dx8_compressor"),
  [const.fx.dx8_distortion] = require("miriani.lib.audio.bass.fxparameters.dx8_distortion"),
  [const.fx.dx8_echo] = require("miriani.lib.audio.bass.fxparameters.dx8_echo"),
  [const.fx.dx8_flanger] = require("miriani.lib.audio.bass.fxparameters.dx8_flanger"),
  [const.fx.dx8_gargle] = require("miriani.lib.audio.bass.fxparameters.dx8_gargle"),
  [const.fx.dx8_i3dl2reverb] = require("miriani.lib.audio.bass.fxparameters.dx8_i3dl2reverb"),
  [const.fx.dx8_parameq] = require("miriani.lib.audio.bass.fxparameters.dx8_parameq"),
  [const.fx.dx8_reverb] = require("miriani.lib.audio.bass.fxparameters.dx8_reverb")
}

return FX