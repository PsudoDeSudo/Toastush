
ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The bright light vanishes as the starship emerges at the other side of the wormhole\.$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="gags"
   match="^You feel the sudden pull of acceleration as the starship's relativity drive kicks in, hurling you through the gate's event horizon\.$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>
  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You notice a faint hum begin to emanate from nowhere in particular as the starship's systems begin to power up\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("ship/move/enablePower", "other", 0, 1)
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You suddenly become aware of a decrease in noise as the ship's systems shut down, leaving you in complete silence\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/disablePower", "other", 0, 1)</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^A chime (?:sounds|is piped through a nearby speaker), indicating that somebody has entered the airlock\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("ship/misc/chime", "other")
   print("Airlock Chime")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The hatch acknowledges your key and unlocks, allowing you to .+? through\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/misc/enter", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^[A-Z][a-z]+?[A-Za-z\s]*? through the (broken|unlocked)?\s?hatch of.+?(?:&quot;.+?&quot;)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/enter", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^([A-Z][a-z]+?\s?[A-Za-z\s]*?) [a-z]+( \w+ feet)? out of the.+?(?:&quot;.+?&quot;|ship\.|\w+-person .+?|Highguard)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/exit", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^[A-Z][a-z]+?[A-Za-z\s]*? begin[ing]{0,3} the \w+ sequence\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/move/sequence", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^[A-Z][a-z]+?[A-Za-z\s]*? input.+? (?:a |some )?\w+ (?:of commands )?into .+\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/keyboard")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The sound of the relativity drive echoes through the room as it propels the ship towards space\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/launch", "other")</send>
  </trigger>


  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You feel mild acceleration as the ship (?:descends|moves) toward .+?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/land", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You hear a (?:gentle pulsing sound as the starship begins an|low rumbling sound as the wormhole drive opens a|deep hum as the starship begins an|sharp whine as the starship begins an)\s?(?:intrasector)? (wavewarp|wormhole|subwarp|slip)\.$"
  regexp="y"
  omit_from_output="y"
  send_to="14"
  sequence="100"
  >
  <send>mplay ("ship/move/%1", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The sounds of the relativity drive calm as the starship completes its final maneuver into space\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
  if config:get_option("spam").value == "yes" then
print("Launch complete.")
  else
    print ("%0")
  end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The deck beneath you vibrates slightly as the relativity drive begins accelerating the starship through space\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/relStart", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The sounds of the relativity drive slowly cease as the starship comes to a halt\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/relStop", "other")</send>
</trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The experience abruptly ends as the starship exits from the companion jumpgate and the relativity drive takes over to slow the ship to a stop\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/relStop", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You feel a mild vibration as the ship nears the active jumpgate\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/jump", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^[A-Z][A-Za-z\s]+? instructs? the computer to begin scanning for debris\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/keyPress", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You hear a thunk as a salvaging line is deployed into space\. You watch as the line slowly winds its way to a piece of debris, projects an energy net around it and begins to slowly make its way back to the ship\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/misc/salvageLine", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^A mechanical groan permeates the room as a heavy blast door (?:suddenly |)begins to (slide|move) .+?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
  if string.find ("%1", "slide") then
    mplay ("ship/misc/blastClosing", "other")
    print("Door Closing")
  else
    mplay ("ship/misc/blastOpen", "other")
    print("Door Opening")
  end
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^A mechanical groan gradually subsides as the blast door(?:'s)? (locking|disappears) (?:mechanisms|from) (?:click|view,) .+? exit (\w+?)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("ship/misc/blastSettle", "other")
   if "%1" == "disappears" then
    print("%2 unlocked")
   else
    print("%2 locked")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^Starship (?:Damage|Status|Security Status):$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/display")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You notify flight control of your desire to (undock|dock|launch|land)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/radio", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You notice a bright flash of light (?:above|in the distance); a starship must be coming in (?:for a landing|to dock)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/move/otherLanding", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The [a-z-\s]+person .+? touches down smoothly on the (?:ground|docking bay floor)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/move/otherTouchDown", "other")</send>
  </trigger>

   <trigger
   enabled="y"
   group="ship"
   match="^[A-Za-z0-9\s-'&quot;]+? rises smoothly off the ground and hovers for a brief moment before rapidly accelerating towards space\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/move/otherLaunching", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The starship (?:begins)?\s?(?:vibrating|shudders) (?:violently|beneath) (?:as|your) (?:the|feet).? (?:hum|It|as) (?:picks|feels|it) (?:up|like|continues) (?:in|the|propelling) (?:intensity|hull is breaking apart around you|itself forward)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/misc/creak")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^With a sharp lurch, the starship completes its intrasector (?:slip|wavewarp)\.?\s?(?:The pulsing sound stops as the wavewarp drive powers down)?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/misc/creak")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The vibration diminishes as the starship completes its subwarp\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/move/orbit", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You hear (?:several clinking|a deafening booming|a buzzing|a shrill screeching|an electrical zapping) sound.+?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/misc/repair", "other")</send>
  </trigger>
  <trigger
   enabled="y"
   group="ship"
   match="^HULL: ([0-9]{1,2})%$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if tonumber("%1") > 79 then
    mplay ("ship/alarm/criticalHull", "alarm")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^(?:The|Praelor) .+? has (left|entered|jumped into|exited from) (?:the|to)?.*?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if probeHistory then
    return 0
   end -- if video probe

   if "%1" == "left" or string.find  ("%0", "entered Jumpgate") or string.find ("%0", "Mission") then
    mplay ("ship/move/sectorExit", "other")
   else
    mplay ("ship/move/sectorEnter", "other")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You detect a faint rumbling as the starship begins to orient toward another ship\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/dockBegin", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^(The starship rocks gently as the docking ring comes into contact with another starship|You hear a soft clang as another ship's docking ring comes into contact with the hull)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/dockComplete", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^Video probe history:$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay ("ship/misc/probeHistory", "other")
   probeHistory = true
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^End of history\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>probeHistory = false</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You hear a satisfying click as the (?:docked)?\s?ship's docking ring is (?:retracted|released)\s?(?:from the docked ship's hull)?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/undockBegin", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^(Scanning is made much more difficult by the lack of sensors|That object was not found|There is nothing here to scan|There are no ships here|Nothing was detected at those coordinates)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/computer/noScan", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^That space is occupied\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/move/sameSpace", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^[A-Za-z0-9\s-'&quot;]+? has initiated an intrasector (?:subwarp|slip|wavewarp)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if (not probeHistory) then
    mplay ("ship/move/drive", "other")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You hear a deep rumbling as the docking bay door (open|close)s\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/dock%1", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You hear a?\s?(?:several)?\s?(?:thunk|thud)s? as a?n?\s?(blockade|blockades|interdictor|proximity weapon) (?:is|are) launched\s?(into space)?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if "%1" == "blockade" then
    mplay ("ship/combat/prox/singleBlockade", "other")
   elseif "%1" == "blockades" then
    mplay ("ship/combat/prox/multiBlockade", "other")
   else
    mplay ("ship/combat/prox/proxLaunch", "other")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The [a-z-]+person .+? has launched a?n?\s?\w+?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if (not probeHistory) then
    mplay ("ship/combat/prox/otherProx")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^A security drone (?:suddenly)?\s?appears (?:and|to) (?:drags|escort) you off the ship\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/exit", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The \w+-person .+? &quot;.+?&quot; is hauled out of the \w+-person .+? &quot;.+?&quot; by a number of drones\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/misc/expeled", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You hear several loud thuds as cargo is transferred from the ship\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
  sequence="100"
  >
  <send>mplay("ship/misc/startTransfer", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The noises coming from the storage room gradually cease until they can be heard no more\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
  sequence="100"
  >
  <send>mplay("ship/misc/endTransfer", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^(You hear the bustle of activity from the ship's cargo hold|A haunting screech drifts in from the storage room as something heavy is dragged across the floor|A loud whirring sound comes from the ship's storage room as motorized lifts haul cargo away|A loud bang emanates from the storage room as workers haul cargo out|A series of drones lift canisters of atmospheric debris and cart them off|You hear scrapes and scratching coming from the storage compartment as debris is transferred)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("ship/misc/transfer", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The ship cannot leave this sector\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/interdiction", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^An interdiction field prevents the ship from communicating with the navigational beacons\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/interdiction", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You (?:hear somebody)?\s?((?:impatiently)?\s?knock[ing]{0,3}|kick[ing]{0,3} furiously) on the .+?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if "%1" == "knocking" or "%1" == "knock" then
    mplay ("ship/misc/knock", "other")
   elseif "%1" == "impatiently knocking" or "%1" == "impatiently knock" then
    mplay ("ship/misc/impatientKnock", "other")
   else
    mplay ("ship/misc/kickKnock", "other")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You hear a loud clang as robotic arms seize the ship and transport it to the .+?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("ship/misc/clang", "other")</send>
  </trigger>

 <trigger
   enabled="y"
   group="ship"
   match="^[A-Z][a-z]+? [A-Za-z]*?\s?(?:is|are) turned away by the locked hatch of .+?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/lockedHatch", "alarm")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^A loud klaxon sounds as (red|blue) lights (continue to )?flash overhead\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>

   if "%1" == "red" and "%2" == "" then
    mplay ("ship/alarm/redStart", "alarm", 0, 1)
   elseif "%1" == "red" and "%2" == "continue to " and config:get_option ("spam").value == "no" then
    mplay ("ship/alarm/redContinue", "alarm", 0, 1)
   elseif "%1" == "blue" then
    mplay ("ship/alarm/blue", "alarm", 0, 1)
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The lights overhead suddenly flicker as they change from \w+ to (\w+)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>

   mplay ("ship/alarm/%1", "alarm", 0, 1)</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^A destination appears on the ship's navigation controls: (.+?)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay("ship/move/course", "other")
   if config:get_option("spam").value == "yes" then
    print ("Destination: %1")
   else
    print("%0")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You instruct the computer to calculate the distance between your current galactic coordinates and the last known location of the standard navigational beacons\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("ship/misc/beacon", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You lift a small panel and crawl through\.?\s?(the resulting opening, emerging in the starship's network of ducts. Being the \w+ that you are, you replace the panel behind you\.)?$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   if "%1" ~= "" then
    return mplay("ship/misc/ductEnter", "other")
   else
    return mplay("ship/misc/ductExit", "other")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^[A-Z][a-z]+?\s?\w* (lifts a small panel and)?\s?crawls \w*\s?through (?:it|a small panel)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
  if "%1" ~= "" then
    return mplay("ship/misc/ductEnter", "other")
   else
    return mplay("ship/misc/ductExit", "other")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^A small light on the airlock control panel turns from red to yellow\. The faint hiss of air can be heard (exiting|entering) the airlock\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("ship/misc/airlock/airStart", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^The hiss of air slowly fades away into nothingness, and the yellow light becomes green\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("ship/misc/airlock/airStop", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The computer flashes a message next to the airlock cycle button saying, &quot;(Beginning cycling|Cycling complete)\.&quot;$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if "%1" == "Beginning cycling" then
    return mplay("ship/misc/airlock/close", "other")
   else
    return mplay("ship/misc/airlock/open", "other")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You hear the airlock (begin|finish) cycling\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/misc/airlock/hear%1", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^(Name\s+#\s+Units|Weapon Status:|Charge Readout:|Starship Weapon Information)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/misc/screen", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You hear \w+ thunks? as salvage lines? are simultaneously deployed into space\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("ship/misc/bulkSalvage", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^The overhead lights dim for a moment before returning to normal\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/misc/fuzzyDamage", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You hear the sounds of somebody attempting to enter the airlock, but they're turned away by the locked hatch\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/misc/lockedHatch", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^You feel a mighty shaking as something seemingly large impacts the hull\.$"   regexp="y"
   send_to="14"
   omit_from_output="y"
   omit_from_log="y"
   sequence="100"
  >
  <send>
   mplay("ship/misc/debrisHit", "other")
   if (config:get_option("spam")).value == "no" then
    print("%0")
   end -- spam
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   match="^.+ (?:press(?:es)?|slides) (?:a button|out of) (?:and quickly retrieves?|a nearby printer) .+\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("ship/misc/print", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="ship"
   script="gagline"
   match="^You hear a mechanical whine as (the ship's solar panels orient themselves toward a star|the ship's solar panels return to their previous positions along the hull)\.$"
   regexp="y"
   send_to="14"
   omit_from_output="y"
   sequence="100"
  >
  <send>mplay("ship/misc/solarPanels"..("%1" == "the ship's solar panels return to their previous positions along the hull" and "Off" or "On"), "other")</send>
  </trigger>


</triggers>
]=])
