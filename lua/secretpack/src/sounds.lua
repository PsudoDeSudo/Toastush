-- @module sounds
-- Provides functions for audio manipulation.
-- Uses the BASS library lua binding at its core.

-- author: Erick Rosso
-- Last updated on 2022.01.21

---------------------------------------------

-- Offers a wrapper for audio:play
local streamtable = {}
function play(file, group, interrupt, rp)

  local mem = false -- All audio will be static.
  group = group or "other"
  if config:is_mute() then
    return -- Audio is muted.
  end -- if

  local search = utils.readdir(
  config:get("SOUND_DIRECTORY")..file.."*"..config:get("EXTENTION"))
  or utils.readdir(
  GetInfo(74)..file.."*"..config:get("EXTENTION")
  ) -- File search.

  if search then

    math.randomseed(os.time())

    local count = 0
    table.foreach(search,
    function()
      count = count + 1
    end ) -- anon

  local sfile = 
    count == 1
    and config:get("SOUND_DIRECTORY")..file..config:get("EXTENTION")
    or config:get("SOUND_DIRECTORY")..file..tostring(
    math.random(count)
    )..config:get("EXTENTION")

    if interrupt and streamtable[group] then
      audio:stop(streamtable[group])
    end -- if

    rp = 
    rp == true
    and (math.random(-100, 100) / 100.0) -- Stereo panning.
    or config:get_attribute(group, "pan")

      streamtable[group] = sfile

    local code = audio:play(
    mem, sfile,
    config:get_attribute(group, "vol"),
    rp, -- Possible random pan.
    config:get_attribute(group, "freq")
    )

    if code ~= audio.ERROR.ok then
      notify("important",
      string.format("Unable to play %s.", sfile)
      )

    end -- if

  end -- if
end -- play

function stop(group)

  if not group then
 
    table.foreach(streamtable,
    function(k,v)

      audio:stop(v)
    end ) -- anon

  else

    return streamtable[group] and audio:stop(streamtable[group])
   end -- if
end -- stop

function pause(group)

  if not group then
 
    table.foreach(streamtable,
    function(k,v)

      audio:pause(v)
    end ) -- anon

  else

    return streamtable[group] and audio:pause(streamtable[group])
   end -- if
end -- pause

function resume(group)

  if not group then
 
    table.foreach(streamtable,
    function(k,v)

      audio:resume(v)
    end ) -- anon

  else

    return streamtable[group] and audio:resume(streamtable[group])
   end -- if
end -- resume

local active_group = 1
function cycle_audio_groups()

  local groups = config:get_audio_groups()

  if active_group == table.getn(groups) then
    active_group = 0
  end -- if

  for k,v in pairs(groups) do

    if k > active_group then
      active_group = k
      play("audio/toggle", "other")
      notify("info",
      string.format("%s control - volume: %s%%",
      v, (config:get_attribute(groups[k], "vol") * 100.0)), 1
      )
      break
    end -- if
  end -- for
    end -- cycle_audio_groups

function decrease_attribute(attribute)

  local group = config:get_audio_groups()[active_group]

-- subtract five percent.
  local function subtract(val)
    val =
    val <= 0.06
    and 0.0
    or val - 0.05

    return val
  end -- subtract

    local val = subtract(config:get_attribute(group, attribute))

  if group ~= config:get("DEFAULT_AUDIO") then
  config:set_attribute(group, attribute, val)
    play("audio/decrease", "other")
    return notify("info", string.format("%s volume: %s%%", group,
    (val * 100.0)
    ), 1)
  end -- if

  for k,v in pairs(config:get_audio_groups()) do
    
    config:set_attribute(v, attribute,
    subtract(
    config:get_attribute(v, attribute))
    )
  end -- for

  play("audio/decrease", "other")
  return notify("info", string.format("%s volume: %s%%", group,
  (val  * 100.0)
  ), 1)
end -- decrease_attribute

function increase_attribute(attribute)

  local group = config:get_audio_groups()[active_group]

-- add five percent.
  local function add(val)
    val =
    val >= 0.95
    and 1.0
    or val + 0.05

    return val
  end -- add

    local val = add(config:get_attribute(group, attribute))

  if group ~= config:get("DEFAULT_AUDIO") then
  config:set_attribute(group, attribute, val)

    play("audio/increase", "other")
    return notify("info", string.format("%s volume: %s%%", group,
    (val * 100.0)
    ), 1)
  end -- if

  for k,v in pairs(config:get_audio_groups()) do
    
    config:set_attribute(v, attribute,
    add(
    config:get_attribute(v, attribute))
    )
  end -- for

  play("audio/decrease", "other")
  notify("info", string.format("%s volume: %s%%", group,
  (val  * 100.0)
  ), 1)
end -- increase_attribute

function toggle_mute()

  if not config:toggle_mute() then
    notify("info", "Sounds unmuted.", 1)
  else 
    notify("info", "Sounds muted.", 1)
  end -- if

  end -- toggle_mute
