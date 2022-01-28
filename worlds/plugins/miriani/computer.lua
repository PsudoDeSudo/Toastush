
ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="computer"
   match="^(?:The computer|.+? flickers into existence and) (announces|reports).?(?:that)? &quot;?(.+?)&quot;?$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>

   -- build output string depending on config option
local str
   if config:get_option ("spam").value == "yes" then
    str = "%2"
   else
    str = "%0"
   end -- if

   -- add to history
   channel("computer", str, {"computer"})

   -- mplay sound for default computer

   if string.match ("%2", "(Control room reports: .+)") then
    mplay ("ship/computer/control", "other")
  elseif string.match ("%2", "(Warning, .+)") then
    mplay ("ship/computer/warning", "other")
   else
    mplay ("ship/computer/announce", "other")
   end -- if
   -- place all the computer voice matches here
   -- place before the regular non-voice matches
  if config:get_option("computer_voice").value == "yes" then
   if "%2" == "Autopilot engaged." then
    return mplay("ship/computer/voice/auto", "other", 0, 1)
   end -- if auto

   if "%2" == "Autopilot disengaged." then
    return mplay("ship/computer/voice/manual", "other", 0, 1)
   end -- if manual

   if "%2" == "Self-destruct sequence initiated. Destruction in sixty seconds." then
    return mplay("ship/computer/voice/selfdestruct", "other", 0, 1)
   end -- if self-destruct

   if "%2" == "Self-destruct sequence has been aborted." then
    return mplay("ship/computer/voice/terminate", "other", 0, 1)
  end -- if self-destruct terminates
   end -- computer voice
   print(str) 
   -- list of possible matches.
   -- If it contains computer voice file, place above.

   if string.match ("%2", "(artifact[s]?[,]? .+ been detected in the sector%.)") then
    mplay ("ship/computer/artifact", "other")
   end -- if artifact

   if string.match ("%2", "(planet[s]?[,]? .+ been detected in the sector%.)") then
    mplay ("ship/computer/planet", "other")
  end -- if planet

   if string.match ("%2", "(space station[s]?[,]? .+ been detected in the sector%.)") then
    mplay ("ship/computer/station", "other")
   end -- if station

   if string.match ("%2", "(starship[s]?[,]? .+ been detected in the sector%.)") then
    mplay ("ship/computer/starship", "other")
   end -- if starship

   if "%2" == "NAVI was unable to continue due to sensor interference." then
    mplay ("ship/computer/anomaly", "other")
   end -- if anomaly


   if "%2" == "no nearby debris." then
    return mplay ("ship/misc/noDebris", "other")
   end -- if no debris

  if string.match ("%2", "(I am beginning the repair of [a-z]+ [a-z0-9%s]*%. Estimated time to completion: .+)") then
    return mplay ("ship/computer/repStart", "other")
   end -- if repair starts

   if string.match ("%2", "(I have completed the repair of [a-z0-9%s.])") then
    return mplay ("ship/computer/repStop", "other")
   end -- if repairs finish

   if "%2" == "This starship has triggered a push pulse device. Brace for impact." then
    return mplay ("ship/computer/pushPulse", "other")
   end -- if push pulse

   if string.match ("%2", "(.+ has been destroyed%.)") then
    return mplay ("ship/computer/otherDestroy", "other")
   end -- if other is destroyed

  if "%2" == "Target destroyed." then
    return mplay ("ship/combat/destroy/targetDestroyed", "combat")
   end -- if target destroyed

   if string.match ("%2", "(.+ locking onto empty space%.)") or "%2" == "There is no target at those coordinates. Aborting." then
    return mplay ("ship/combat/noLock", "combat")
   elseif string.match ("%2", "(Turret.+ locking on.+%.)") or string.match ("%2", "(Bardenium Cannon.+ locked on.+%.)") or string.match ("%2", "(Long%-Range.+ locking on.+%.)") then

    -- count shots if cannonCount is active
    if string.find("%2", "Bardenium Cannon") and config:get_option("count_cannon").value == "yes" and cannonShots then
     cannonShots = cannonShots - 1

     -- play a sound for 0 shots left.
     if cannonShots == 0 then
      mplay("ship/combat/noBarde", "combat")
     end -- no shots

    notify("info", "Shots Remaining: "..cannonShots)
     end -- if cannonCount

    return mplay ("ship/combat/weaponFire", "combat")
   end -- if lock

   if "%2" == "There is insufficient weapons-grade bardenium available for firing." then
    return mplay ("ship/combat/noBarde", "combat")
   end -- if no barde


   if "%2" == "Firing on empty space complete." or "%2" == "The target has moved from the locked coordinates." then
    return mplay ("ship/combat/noTarget", "combat")
   end -- if missed shot

   if string.match ("%2", "(Hit on .+)") then
    return mplay ("ship/combat/hit/otherHit", "combat")
   elseif string.match ("%2", "(Partial hit on .+)") then
    return mplay ("ship/combat/hit/partialHit", "combat")
   end -- if hit on other

   if string.match ("%2", "(.+ is one unit away from this ship%.)") then
    return mplay ("ship/computer/inRange", "other")
   end -- if in range

  if string.match("%2", "(lifeform)") then
     mplay("ship/computer/lifeform", "other")
   end -- if lifeform

  if string.match ("%2", "(Docking has failed%.)") then
    return mplay("ship/computer/dockingFailed", "other")
  end -- if docking failed

  if string.match("%2", "(That destination is beyond the range of the wormhole drive%.)") then
    return mplay("ship/computer/failFtl", "other")
   end -- if no ftl

  if string.match("%2", "(Scans reveal the debris to be .+%.)") then
    return mplay("ship/misc/debrisSalvage", "other")
   end -- if salvage

  if string.match("%2", "(Mission objective has been completed in approximately .+%. Return to base%.)") then
    return mplay("ship/misc/mission/", "combat")
   end -- if mission complete


  </send>
  </trigger>

  <trigger
   enabled="y"
   group="computer"
   match="^Invalid coordinates\. Range: \(1, 1, 1\) to \(20, 20, 20\)\.(?: You may also specify a destination name\.)?$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>   if config:get_option("computer_voice").value == "yes" then
mplay("ship/computer/voice/unclear", "other", 0, 1)
   else
   print("%0")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="computer"
   script="gagline"
   match="^Objects\s+Direction\s+Lightyears\s+Coordinates\s+$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("ship/computer/lrscan", "other")
  </send>
  </trigger>

</triggers>
]=])