-- Defines shared functions across Miriani plugins.


function latency(name, line, wildcard)
  local ms = tonumber(wildcard[1]) or 0
  InfoClear()
  InfoColour("green")
  Info(string.format ("Latency: %d Milliseconds", ms))

  -- Warn if lag spike.
  if (not warningFlag) and ms >= 250 and config:get_option("warn_lag") then
    warningFlag = true
    notify("info", string.format ("Warning: Client latency recorded at %d milliseconds.", ms), 1)
    play("audio/lag")
    DoAfterSpecial(180, 'warningFlag=false', sendto.script)
  end -- if high lag
end -- Latency

function help(name, line, wc)
  notify("info", string.format("%s", GetPluginInfo(GetPluginID(), 3)))
end-- help

function info(name, line, wc)
  local ID = GetPluginID()
  notify("info", string.format("%s  --  version %s  --  Scripting-language: %s  -- Script-time: %s seconds",
  GetPluginInfo(ID, 1),
  VERSION,
  GetPluginInfo(ID, 5),
  GetPluginInfo(ID, 24)))
end -- info
function configure(name, line, wc)
  smenu(wc[1] ~= "" and wc[1] or nil)
end -- configure

function channel(name, line, wc)

  -- Requires the channel history plugin.

  assert (IsPluginInstalled ("6000a4c6f0e71d31fecf523d"), "channel_history could not be found")

  -- add record table of channel arguments
   for k,v in ipairs(wc) do
    -- Add only if the buffer is active:
        buffer = config:get_option(string.format("%s_buffer", v))

    if buffer ~= nil and
    buffer.value == "yes" then
      Execute("history_add "..v.."="..line)
    end -- if
  end -- for loop
end -- channel

function OnLink(name, line, wc)
  channel("link", wc[1], {"link"})
  --Add the link to a recent link buffer.
  link =
  {
    url = wc[1],
    timestamp = os.clock()
 }

end -- OnLink

function open_link()

  if not link or os.clock() - link.timestamp > timeout then
    nvda.say("No recent link to open.")
  else
    local url = link.url
    nvda.say("Opening "..url)
    OpenBrowser(url)
  end -- if
end -- open_link

function mplay(file, group, interrupt)
  -- Miriani only play:
  filepath = string.format(SOUNDPATH.."%s", file)
  play(filepath, group, interrupt)
end -- mplay

function speech_interrupt(line)
  Execute("tts_interrupt "..line)
end -- speech_interrupt

function register()
  Send("#$#REGISTER_SOUNDPACK "..registry.." | "..VERSION.."\n")
end -- register

function playstep (room_name, step)
  room_name = room_name or "misc"
  step = step or "Unset"
  if environment then
  parent, location, extra = environment["parent"], environment["location"], environment["extra"]
  else
    return 0
  end -- if

  -- Stop here is step is fly
  if step == "fly" or step == "float" then
    mmplay ("steps/fly")
    return 1
  end -- if fly

  --Stop here if you're in the ducts!
  if string.find (room_name, "duct") then
    mplay ("steps/duct")
    return 1
  end -- if in ducts

  -- play sounds if environment is starship.
  if parent == "starship" then
    mplay ("steps/starship")
    return 1
  end -- if parent is starship

  -- play sound if environment is station 
  if parent == "station" then
    mplay ("steps/station")
    return 1
  end -- if parent is station

  -- handle sounds different if room or planet.
  -- look for keywords to redirect to directory
  -- If directory cannot be found, mplay misc folder

  -- Stop here if aquatic
  if extra == "marine" or string.find (room_name, "aquatic") then
    mplay ("steps/swim")
    return
  end -- if aquatic

  if string.find (room_name, "desert") or string.find (room_name, "beach") or string.find (room_name, "sand") or string.find (room_name, "shore") then
    room_name = "desert"
  end -- if desert

  if string.find (room_name, "forest") or string.find (room_name, "field") or string.find (room_name, "park") or string.find (room_name, "woods") or string.find (room_name, "grassy") then
    room_name = "forest"
  end -- if forest

  if string.find (room_name, "mud") or string.find (room_name, "river") or string.find (room_name, "lake") or string.find (room_name, "marsh") or string.find (room_name, "swamp") then
    room_name = "mud"
  end -- if mud

  -- play sound if environment is room or planet
  if parent == "room" or parent == "planet" then
    mplay ("steps/planet/"..location) 
    return 1
  end -- if parent is room or planet
end -- playstep

function playsocial(name, line, wc)
  -- Try to match social to file
  -- Game shortens the social text depending on what user typed.
  local socialtable = utils.readdir(config:get("SOUND_DIRECTORY")..SOUNDPATH.."social/"..wc[2].."/"..wc[1].."*"..config:get("EXTENTION")) 
  -- check that table exists
  if type(socialtable) ~= 'table' then
    --Use a recursive check to find file in nuter directory.
    if wc[2] ~= "neuter" then
      wc[2] = "neuter"

      return playsocial(name, line, wc)
    else
      return 0
    end -- recursive
  end -- if social exists

  local social = string.match (
  string.gsub (next(socialtable), "%d+", ""), "("..string.lower(wc[1]).."[%w%W]+)")
  social = string.gsub (social, config:get("EXTENTION"), "")

  mplay ("social/"..wc[2].."/"..social)
end -- playsocial

function gagline(name, line, wc)
  if config:get_option("spam").value == "no" then
    print(line)
  end -- if
  end -- gagline

