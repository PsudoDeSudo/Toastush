-- @module sounds
-- Provides functions for audio manipulation.
-- Uses the BASS library lua binding at its core.

-- author: Erick Rosso

---------------------------------------------

-- Offers a wrapper for audio:play
local streamtable = {}
local active_group = 1


function play(file, group, interrupt, pan, loop, slide, sec)

  local path = require("pl.path")
  local wait = require("wait")
  local mem = false -- All audio will be static.
  group = group or "other"
  sec = tonumber(sec) or 1 -- 1 second fadeout by default

  if config:is_mute() then
    return -- Audio is muted.
  end -- if
  local file, ext = path.splitext(file)

  local search = utils.readdir(
  config:get("SOUND_DIRECTORY")..file.."*"..ext)
  or utils.readdir(
  GetInfo(74)..file.."*"..ext
  ) -- File search.

  if search then
    
    local count = 0
    table.foreach(search,
    function()
      count = count + 1
    end ) -- anon

  local sfile = 
    count == 1
    and config:get("SOUND_DIRECTORY")..file..ext
    or config:get("SOUND_DIRECTORY")..file..tostring(
    math.random(count)
    )..ext

    if (pan ~= nil) then
      pan = math.random(-100, 100) / 100.0 -- Stereo panning.
    else
     pan = config:get_attribute(group, "pan")
    end -- if

    if (loop ~= nil) then
      loop = audio.const.sample.loop
    end -- if

    wait.make(
    function()

      if interrupt ~= nil
      and is_group_playing(group) == 1 then
        if slide == nil then
          -- Stop immediately.
          stop(group, 1)
        else -- fadeout
          slide_group(group, "volume", 0, sec)
          wait.time(sec)
          stop(group, 1)
      end -- if
      end-- if

        add_stream(group, sfile)

      local vol = config:get_attribute(group, "volume")
      local fq = config:get_attribute(group, "frequency")

      local e = 0
      if (slide ~= nil) then
        -- fade in

        e = audio:play(
          mem, sfile,
          0, pan, fq, loop)
        slide_group(group, "volume", vol, sec)
      else -- regular play
        e = audio:play(
          mem, sfile,
          vol, pan, fq, loop)
      end -- if

      if e ~= audio.ERROR.ok then
        notify("important",
        string.format("Unable to play %s.", sfile)
        )    
      end -- if

    end -- function
    ) -- coroutine

  end -- if

end -- play

function stop(group, option, slide, sec)
  local wait = require("wait")
  sec = tonumber(sec) or 1 -- 1 second fade out

  if (not streamtable) then
    return 0
  end -- if

 local function unpack(save, tbl)
    for _, file in ipairs(tbl) do
      save[#save + 1] = file
    end -- for
  end -- unpack

  local streams = {}
  if (not group) then
    for g, files in pairs(streamtable) do
      unpack(streams, files)
      streamtable[g] = nil
    end -- for
  else -- group given:
    if streamtable[group] ~= nil then
      unpack(streams, streamtable[group])
    end -- if
  end -- if

  wait.make(
  function()

    if (option == 1) 
    and streamtable[group] ~= nil then

      if (slide ~= nil) then
        audio:slide(streams[#streams], "volume", 0, sec * 1000)
        wait.time(sec)
      end -- if

      audio:stop(streams[#streams])

    else -- remove all from group.

      if (slide ~= nil) then

        for _, name in ipairs(streams) do
          audio:slide(name, "volume", 0, sec * 1000)
        end -- for

        wait.time(sec)
      end -- if

      for _, name in ipairs(streams) do
        audio:stop(name)
      end -- for 
    end -- if

    return 1
  end -- function
  ) -- coroutine

end -- stop

function add_stream(group, file)

  if (not streamtable[group]) then
    streamtable[group] = {file}
  else
    streamtable[group][#streamtable[group] + 1] = file


    -- we cap at 10 
    -- for any given group.

    if table.getn(streamtable[group]) >= 10 then
      table.remove(streamtable[group], 1)
    end -- if

  end -- if

  return 1
end -- add_stream


function forward_cycle_audio_groups()

  local groups = config:get_audio_groups()

  if active_group == table.getn(groups) then
    active_group = 0
  end -- if

  for k,v in pairs(groups) do

    if k > active_group then
      active_group = k
      notify("info",
      string.format("%s control - volume: %s%%",
      v, (config:get_attribute(groups[k], "volume") * 100.0)), 1
      )
      break
    end -- if
  end -- for

    end -- forward_cycle_audio_groups

function previous_cycle_audio_groups()
  local groups = config:get_audio_groups()

  if active_group <= 1 then
    active_group = table.getn(groups) + 1
  end -- if

  for k,v in pairs(groups) do

    if k == active_group - 1 then
      active_group = k
      notify("info",
      string.format("%s control - volume: %s%%",
      v, (config:get_attribute(groups[k], "volume") * 100.0)), 1
      )
      break
    end -- if
  end -- for

    end -- previous_cycle_audio_groups


function decrease_attribute(attribute)

  local group = config:get_audio_groups()[active_group]

-- subtract five percent.
  local function subtract(val)
    local val =
    val <= 0.06
    and 0.0
    or val - 0.05

    return val
  end -- subtract

    local val = subtract(config:get_attribute(group, attribute))

  if group ~= config:get("DEFAULT_AUDIO") then
    config:set_attribute(group, attribute, val)
    slide_group(group, attribute, val)

    return notify("info", string.format("%s %s: %s%%", group, attribute,
    (val * 100.0)
    ), 1)
  end -- if

  for k,v in pairs(config:get_audio_groups()) do
    local val = subtract(config:get_attribute(v, attribute))
    config:set_attribute(v, attribute, val)
    slide_group(v, attribute, val)
  end -- for

  return notify("info", string.format("%s %s: %s%%", group, attribute,
  (val  * 100.0)
  ), 1)
end -- decrease_attribute

function increase_attribute(attribute)

  local group = config:get_audio_groups()[active_group]

-- add five percent.
  local function add(val)
    local val =
    val >= 0.95
    and 1.0
    or val + 0.05

    return val
  end -- add

    local val = add(config:get_attribute(group, attribute))

  if group ~= config:get("DEFAULT_AUDIO") then
    config:set_attribute(group, attribute, val)
    slide_group(group, attribute, val)
    return notify("info", string.format("%s %s: %s%%", group, attribute,
    (val * 100.0)
    ), 1)
  end -- if

  for k,v in pairs(config:get_audio_groups()) do
    local val = add(config:get_attribute(v, attribute))
    config:set_attribute(v, attribute, val)
    slide_group(v, attribute, val)

  end -- for

  notify("info", string.format("%s %s: %s%%", group, attribute,
  (val  * 100.0)
  ), 1)
end -- increase_attribute

function toggle_mute()

  if config:toggle_mute() then
    notify("info", "Sounds unmuted.", 1)
  else 
    stop()
    notify("info", "Sounds muted.", 1)
  end -- if

  end -- toggle_mute

function slide_group(group, attribute, val, seconds)
  -- Gradually nudge active strream.

  if (not streamtable[group]) then
    return 0 -- Nothing to do
  end -- if

  seconds = tonumber(seconds) or 1 -- seconds to fade
  for _, name in ipairs(streamtable[group]) do
    -- seconds in milliseconds:
    audio:slide(name, attribute, val, seconds * 1000)
  end -- for

  return 1
end -- slide_group

function is_group_playing(group)
  -- Return 1 if any file in the group is playing.
  if (not streamtable[group]) then
    return 0 -- Nothing to do
  end -- if

  for _, name in ipairs(streamtable[group]) do

    if (audio:is_active(name) == true) then
      return 1
    end -- if
  end -- for

  return 0
end -- is_group_playing


function pause_group(group)

  if (not streamtable[group])
  or is_group_playing(group) == 0 then
    return 0
  end -- if

  for _, name in ipairs(streamtable[group]) do
    audio:pause(name)
  end -- for

  return 1
end -- pause_group

function resume_group(group)

  if (not streamtable[group]) then
    return 0
  end -- if

  for _, name in ipairs(streamtable[group]) do
    audio:resume(name)
  end -- for

  return 1
end -- resume_group

