
ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^You hear (?:a|the) gentle hum (?:begin to fade)?\s?as the weapons power (up|down)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("ship/combat/weaponPower%1", "combat")</send>
</trigger>
  <trigger
   enabled="y"
   group="combat"
   match="^This starship has been hit by (.+?)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("ship/combat/hit/youHit", "combat")
   print("Hit by %1")
   channel("combat", "Hit by %1", {"combat"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^The (?:star)?ship (?:rocks|shakes|shudders) (?:violently|slightly) as (?:it['s]{0,2}|a)?\s?(hit by an automated laser turret|comes into contact with a space mine|projectile strikes the hull|solar material impacts the hull)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/combat/hit/youHit", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^([A-Za-z0-9\s-'&quot;]+?) has fired at (.+?)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   if  probeHistory then
    return
   end -- if
   channel("combat", "%0", {"combat"})
   if config:get_option("friendly_combat").value == "no" then
    print("%0")
    mplay ("ship/combat/hit/sectorHit", "combat")
   else -- display only if its Praelor on alliance.
    if string.find ("%1", "Praelor") or (not string.find ("%2", "Praelor")) then
     print("%0")
     mplay ("ship/combat/hit/sectorHit", "combat")
    end -- if praelor hits other
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^You hear a mechanical whine as the laser reflectors reorient themselves\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/combat/reflector", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^An internal stun turret orients towards [A-Za-z\s]+? and fires!$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   weapon = "internal"
   mplay ("ship/combat/internal", "combat")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^The ship jerks slightly as its turrets are fired\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("ship/combat/laser", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^You hear a thunk as a chunk of charged weapons-grade bardenium is fired from the ship's cannons\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/combat/cannon", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^([A-Za-z0-9\s'-]+?) has a lock on this starship\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   if config:get_option("secondary_lock").value == "yes" and focusTarget and focusTarget ~= "%1" then
    return mplay("ship/combat/secondaryLock", "combat")
   else -- main or unset target.
    mplay ("ship/combat/enemyLock", "combat")
   print ("Locked by %1")

   end -- if

   channel("combat", "Locked by %1", {"combat"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^[A-Z][a-z]+?[A-Za-z\s]*? deftly (draw|insert)s? an? .+? (?:from|into) a .+?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("combat/%1", "combat")</send>
  </trigger>
  <trigger
  enabled="y"
   group="combat"
   match="^[A-Z][a-z]+?\s?\w* slides? an oddly\-shaped EM pulse emitter (out|into) (?:of)?\s?a pulse emitter clip,?\s?(?:where it settles into place with a small click)?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if "%1" == "out" then
    return mplay("combat/pDraw", "combat")
   else
    return mplay("combat/pHolster", "combat")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^[A-Z][a-z]+?\s?\w* aims? an oddly\-shaped EM pulse emitter at .+? and activates? it\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
   <send>mplay("combat/pFire", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^A distant whirring noise can be heard as the \w+'s laser aligns itself, followed by a faint pulse as it fires\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/combat/planetaryLaser", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^([A-Z][a-z]+?[A-Za-z\s]*?) points? (.+?) at .+? and fires?!$|^[A-Z][\w\s]* carefully takes? aim .+?\.{3}$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if string.find ("%2", "blaster") then
    weapon = "blaster"
   elseif string.find ("%2", "hollow") then
    weapon = "hollow"
   elseif string.find ("%2", "rifle") then
    weapon = "rifle"
   elseif string.find ("%2", "pistol") then
    weapon = "pistol"
   elseif string.find ("%2", "revolver") then
    weapon = "revolver"
   elseif string.find ("%2", "shotgun") then
    weapon = "shotgun"
    elseif string.find ("%2", "stun turret") then
    weapon = "turret"
   else
    weapon = "defaultGun"
   end -- weapon type 

  if string.match ("%0", "(carefully %w+ aim at)") then
    return mplay("combat/aim", "combat")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^(The shot misses!|The shot hits .+?\.|[A-Z][\w\s]* suddenly seems? unable to move\.|[A-Z][\w\s]* clicks oddly. It must be out of ammo\.|[A-Z][\w\s]* skillfully dodges the shot\.|The shot blows a hole in an? .+? insectoid creature's exoskeleton, sending a spray of acid outward\.|The shot dissolves into a cloud of dust and floats harmlessly away\.|The shot seems to have little effect\.)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
  if string.match ("%1", "(clicks oddly%. It must be out of ammo%.)") then
    return mplay("combat/empty", "combat")
   end -- if
  if (not weapon) then
    weapon = "defaultGun"
   end -- if
   if weapon ~= "internal" then
    mplay("combat/guns/"..weapon, "combat")
   end -- if

   if string.match("%1", "(The shot blows a hole in an? .+ insectoid creature's exoskeleton, sending a spray of acid outward%.)") then
    return mplay("combat/praelor/hit", "combat")
   end -- if praelor hit

   if string.match ("%1", "(The shot hits .+%.)") or string.match("%1", "(suddenly %w+ unable to move%.)") then
    return mplay("combat/hit", "combat")
   end -- if
  </send>
  </trigger>
  <trigger
   enabled="y"
   group="combat"
   match="^Wait \d+ seconds?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/stunTime", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^A loud clicking is followed by the clatter of an empty cartridge to the floor\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("combat/eject", "combat")</send>
  </trigger>


  <trigger
   enabled="y"
   group="combat"
   match="^[A-Z][a-z]+?\s?[A-Za-z\s]*? hastily slams? .+? into the open ammo slot of .+?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("combat/loadGun", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^(A high-pitched, wobbling alarm sounds as the hull begins breaking up around you|You hear several rumbling sounds as the starship explodes around you)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/combat/destroy/youDestroy", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^You depress the cartridge release lever on .+?, causing the loaded cartridge to slide out of the weapon and into your hand\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("combat/unloadGun", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^[A-Z][a-z]+?\s?[A-Za-z\s]*? (load|unload)s? .+? (?:from|into) .+? ammunition container\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("combat/ammunition", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^You take a quick glance at .+?, noting that the effective stun power is (\d+)\.? (It appears to be unloaded|and that it is loaded with (.+?) and has (\d+) (\w+) left)\.$"
   omit_from_output="y"
   regexp="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("combat/checkGun", "combat")
   if "%2" == "It appears to be unloaded" then
    print ("Unloaded")
   else
     print ("Power %1%%: %3 %4 %5 left.")
   end -- check
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^The room is filled with a .+? light as the laser turrets? (?:are|is) fired\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
      sequence="100"
  >
  <send>mplay ("ship/combat/laser", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^You hear several scraping sounds as bardenium is transferred from the ship's storage to the cannons\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("ship/combat/reload", "combat")
   if config:get_option("count_cannon").value == "yes" and fullBarde and numberOfCannons then
    cannonShots = fullBarde / numberOfCannons
   end -- if cannonCount

</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^(.+?): (\d{1,2}, \d{1,2}, \d{1,2})$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   if "%1" == "Locked onto coordinates" then
    print ("%0")
    mplay("ship/combat/aim", "combat")
   elseif "%1" == "Current coordinates" then
    return print("%2")
   elseif "%1" == "Coordinates" then
    return print("%0")
   else -- do if focus
   if config:get_option("focus_interrupt").value == "yes" then
    Execute("tts_stop")()
   end -- if focus interrupts
    if focusCoordinates and focusCoordinates == "%2" then
     return print("Unchanged: %2 (%1)")
    end -- if
    focusCoordinates = "%2"
    focusTarget = "%1"
    print("%2 (%1)")
    mplay("ship/combat/focus", "combat")
   end -- if

  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^Target: (.+?)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/combat/targetLocked", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^(Those coordinates are too far away to establish a lock|The locked coordinates are out of range of the available weapons)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/combat/notRanged", "combat")</send>
  </trigger>

  <trigger
   name="cannonCount"
    enabled="y"
   group="combat"
   lines_to_match="7"
   match="\A^Available Cannons: (\d+)\s?(\(Salvo of (\d+)\))?\n(?s).+?\n^(No available weapons\-grade bardenium\.|Available weapons\-grade bardenium:)$\n^(\s*[A-Za-z\s-]+ Bardenium: (\d+))?.*$\Z"
   multi_line="y"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   fullBarde = tonumber("%1") * 10

   if "%3" ~= "" then
    numberOfCannons = tonumber("%3")
   else
    numberOfCannons = tonumber("%1")
   end -- total cannons

   if "%4" == "No available weapons-grade bardenium." then
    cannonShots = 0
   else
    cannonShots = (tonumber("%6") / numberOfCannons)
   end -- if
print ("Shots Remaining: "..cannonShots)

  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^[A-Za-z\s]+ conjures? up some mighty force and slams? .+? into .+?[.!].*$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("combat/stunBaton", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^An? .+? insectoid creature suddenly explodes violently, showering the area with pieces of exoskeleton, guts and a strange bubbling substance\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("combat/praelor/explodeHere", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^(An? .+? insectoid creature) crouches low to the ground and hisses, expelling a large quantity of an acidic compound at (.+?)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
   >
  <send>
   if config:get_option("praelor_interrupt").value == "yes" then
    Execute("tts_stop")()
   end -- if praelor interrupt
   mplay("combat/praelor/attack", "combat")
   if "%2" ~= "you" then
    channel("combat", "%2 is attacked by %1", {"combat"})
    if config:get_option("spam").value == "yes" then
     return print("%2 is attacked by %1")
    end -- if spam
   else -- if target is you.
    if config:get_option("spam") == 1 then
     return print("You are attacked by %1")
    end -- if spam
   end -- if
   print("%0")

  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^You are suddenly struck by a .+?!$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("combat/praelor/limb", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^(An? .+? insectoid creature) starts shrieking loudly, the pitch ramping up as it succumbs to the effects of the alkalines\. Sections of its exoskeleton begin to swell, tiny bumps forming on the swelling sections\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   channel("combat", "%1 is dying.", {"combat"})
   mplay("combat/praelor/shriekHere", "combat")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^You hear a strange shrieking sound from the .+?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("combat/praelor/shriekNearby", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   script="gagline"
   match="^You hear a worryingly wet sounding explosion from the \w+\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("combat/praelor/explodeNearby", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^An? .+? insectoid creature collapses on the ground, a bubbling substance leaking out from around its eyes and from its mandibles. It begins thrashing violently, its wings flapping uselessly\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("combat/praelor/death", "combat")</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^An? .+? insectoid creature scurries in\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
  if config:get_option("praelor_interrupt").value == "yes" then
    Execute("tts_stop")()
   end -- if

   channel("combat", "%0", {"combat"})
   mplay("combat/praelor/enter", "combat")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^You see (.+)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   local count, creature, output = 0, "", "%1"

   if string.find(output, "[A-Za-z] .+ insectoid creatures?") then
    mplay("combat/praelor/detected", "combat")

   if config:get_option("count_praelor").value == "yes" then

    -- Add all praelor.
     for words in string.gmatch(output, "insectoid creature") do
      count = count + 1
     end -- for loop

    -- Figure out if its plural
    if count &gt; 1 then
    creature = "creatures"
   else
    creature = "creature"
   end -- if plural

    -- Interrupt if true.
    if config:get_option("praelor_interrupt").value == 1 then
     Execute("tts_stop")()
    end -- if interrupt speech

     channel("combat", count.." insectoid "..creature, {"combat"})

    print(string.format("%d insectoid %s.", count, creature))
    end -- if praelor count

   end -- if praelor detected
   print("You see "..output)
</send>
  </trigger>

  <trigger
   enabled="y"
   group="combat"
   match="^[A-Z][a-z\s,'-]+ aims? (?:his|her|its|their) (?:counter\-?)?stun turret attachments? at [A-Za-z\s'-]+ and fires?!$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("combat/droidShot", "combat")</send>
  </trigger>

</triggers>
]=])
