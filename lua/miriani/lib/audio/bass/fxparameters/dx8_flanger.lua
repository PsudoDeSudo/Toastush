local class = require("pl.class")
local fxparameters = require("miriani.lib.audio.bass.fxparameters")

class.DX8_FLANGER(fxparameters)

function DX8_FLANGER:_init()

  self:LinkParameter('fWetDryMix', 'wet_dry_mix')
  self:LinkParameter('fDepth', 'depth')
  self:LinkParameter('fFeedback', 'feedback')
  self:LinkParameter('fFrequency', 'frequency')
  self:LinkParameter('lWaveform', 'waveform')
  self:LinkParameter('fDelay', 'delay')
  self:LinkParameter('lPhase', 'phase')

  self:super('BASS_DX8_FLANGER')

end

return DX8_FLANGER