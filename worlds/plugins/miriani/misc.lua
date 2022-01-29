
ImportXML([=[
<triggers>

  <trigger
   enabled="y"
   group="misc"
   script="register"
   match="\*{3} (?:Connected|Redirecting (?:old|new) connection to this port) \*{3}"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>stop()</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(You|(?:[A-Z]\w+ )+) (\w+) (?:in from the|into the|through the)? ?(?:north|south|east|west|up|down|ship|airlock|outside|out|hatch)(?:east|west)?\.$"
   regexp="y"
   omit_from_output="y"
   keep_evaluating="y"
   send_to="14"
   sequence="100"
  >
  <send>
   foundstep, style = false, string.gsub ("%2", "%a+",
    function (walk)
     return walkStyle[walk]
    end -- function replace walk
    ) -- string replacement

   for k,v in pairs (walkStyle) do
    if style == v then
     foundstep = true
    break
          end -- if
   end -- for loop
   if "%1" ~= "You" and foundstep then

    -- others move around you.
    foundstep = false
    print("%0")
    playstep (room, style)
   else
    -- Your movement will be picked up by soundpack hook

    gagline(name, "%0")
   end -- if movement
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\((\d+) seconds? roundtime\.\)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if config:get_option("roundtime").value == "yes" then
    DoAfterSpecial(tonumber("%1"), 'mplay("misc/roundtime")', sendto.script)
   end -- if round time
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(You can't go that way|That exit appears to be blocked|[A-Z][A-Za-z0-9\s,-]+ is closed)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
   <send>
   if environment then
    mplay ("wrongExit/"..environment["parent"])
   end -- if environment
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Z][A-Za-z0-9\s,;-]+ to the \w+ slides (open|closed) with a hiss\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/door%1")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^A keypad beeps negatively\. The door doesn't budge\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/deny")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^You press a few keys on a keypad\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/keyboard")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\[Type lines of input; use `\.' to end\.\]$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>play ("audio/paste")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(\[Type a line of input or `@abort' to abort the command\.\]|.+ (?:your|&quot;yes&quot; or) (?:selection|&quot;no&quot;).)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
 
   if (not inMenu) then
    play ("audio/prompt")
   inMenu = true
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(Invalid \w+.|>> Command Aborted <<|The \w+ is already moving\.|Those coordinates are occupied by this ship\.|Those coordinates are already locked\.)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>play ("audio/cancel")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   script="gagline"
   match="^(\(.+\)) (.+?)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
  sequence="100"
  >
  <send>
   mplay ("device/camera")
   if config:get_option("internal_camera").value == "no" then
    print("%2 %1")
   end -- if filtering camera
   channel ("camera", "%2 %1", {"camera"})
</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\[From Outside\] (.+?)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("device/camera")
   if config:get_option("external_camera").value == "no" then
    print ("%1 [Outside]")
   end -- if
   channel("camera", "%1 [Outside]", {"camera"})
  </send>
  </trigger>

<trigger
   enabled="y"
   group="misc"
   match="^A small handheld radio receiver beeps twice, indicating the detection of a radio transmission\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/radioDetect")</send>
  </trigger>
<trigger
   enabled="y"
   group="misc"
   match="^You plug a small handheld radio receiver into a console. It beeps in confirmation and begins recording\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/radioConnect")</send>
  </trigger>
<trigger
   enabled="y"
   group="misc"
   match="^A small handheld radio receiver gives a series of beeps and automatically unplugs from the console\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/radioDisconnect")</send>
  </trigger>
<trigger
   enabled="y"
   group="misc"
   match="^From your droid's camera, you see[.]{3}$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   cameraFeed = true
   mplay ("device/camera")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(I don't understand that|You should stand up first)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/command")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   script="gagline"
   match="^The door opens and allows [\w\s]+ to pass\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay ("misc/bioDoor")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Z][a-z]+?\s?[A-Za-z\s]*? (stand|sit|pull)s? (?:[A-Z]?[a-zA-Z\s]*? to \w+ feet|up|feet|down(?: (?:on|at) .+?)?)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   local fName = "%1"
   if string.find (fName, "pull") then
    fName = "stand"
   end -- if

   mplay ("misc/"..fName)
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^Via the TransLink network, the LoreTech device &quot;(.+?)&quot; reports current location pinpointed (.+?)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("device/lore/track")
   print("%1 %2")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^A (?:.+?) Lore computer beeps (quietly|twice in rapid succession), indicating that its TransLink tracking functionality has been activated(?:.+?)?\."
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if "%1" == "quietly" then
    mplay ("device/lore/beep")
   else
    mplay ("device/lore/unauthTrack")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^Tracking authorization refused from LoreTech device &quot;.+?\.&quot;$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/lore/deny")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^A small console nearby flashes for your attention\. .+$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/mail")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\[Tradesman Market\] ([A-Z][a-z]+? [A-Z][a-z]+?) has commenced a sale\. [SsHhe]{2,3} is selling (\w+?) tradesman item (certificates?) for ([0-9,]+[.0-9]{3}) credits\s?(a piece)?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("misc/tradesmanSale")
   print ("[Tradesman Market] New Sale by %1: %2 %3 for %4 credits.")
   channel ("[Tradesman Market] New Sale by %1: %2 %3 for %4 credits.")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\[Tradesman Market\] ([A-Z][a-z]+ [A-Z][a-z]+?) has (lowered|raised) the price of ([ehisr]{3}) sale from ([0-9,]+[.0-9]{3}) credits to ([0-9,]+[.0-9]{3}) credits per certificate\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("misc/tradesmanPrice")
   local diff, v1, v2 = 0, string.gsub ("%4",",",""), string.gsub ("%5",",","")
   if "%2" == "lowered" then
    diff = assert (tonumber (v1 - v2)) -- close assertion 
   else
    diff = assert (tonumber (v2 - v1)) -- close assertion
   end -- if

   print ("[Tradesman Market] %1 %2 %3 sale by "..diff.." credits. Price: %5")
   channel ("[Tradesman Market] %1 %2 %3 sale by "..diff.." credits. Price: %5")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\[Tradesman Market\] [A-Z][a-z]+ [A-Z][a-z]+'?s? (?:has canceled \w+ sale|sale has completed)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   channel("market", "%0", {"market"})
   mplay ("misc/tradesmanComplete")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\[Tradesman Market\] [A-Z][a-z]+ [A-Z][a-z]+ has bought (\w+?) tradesman certificate from [A-Z][a-z]+ [A-Z][a-z]+\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   channel("market", "%0", {"market"})
   mplay ("misc/tradesmanBid")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(?:[A-Z][a-z ]*)+ (coalesces into being nearby|suddenly steps from the background)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/hosts/arrive")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(?:[A-Z][a-z ]*)+ (dissolves into billions of constituent particles and disperses into a hitherto unnoticed breeze|suddenly seems to disappear into the background)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/hosts/leave")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^Digging through your belongings reveals no such thing\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/notFound")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Za-z\s-]+? suddenly (flickers into existence|vanishes)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if "%1" == "vanishes" then
    mplay ("device/simulator/end")
   else
    mplay ("device/simulator/start")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^You (?:find yourself )?disconnect[ed]{0,2} from (?:your avatar|the simulator as the simulated starship is destroyed)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/simulator/end")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\*{3} You have entered a starship simulator\. To exit, please type END\. \*{3}$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/simulator/start")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Z][A-Za-z\s]+? crumples? .+? and throws? it away\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("misc/crumble")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Z][a-z]+?[A-Za-z\s]*? (?:push[es]{0,2}|pulls?|flips?) a (?:heavy|small) (?:switch,|lever) (?:away from .+?,|towards? .+?,)?.+?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("ship/misc/lever")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Z][a-z]+?\s?[A-Za-z\s]*? press[es]{0,2} a (?:large (?:red|green|purple|yellow) (?:reset)?\s?button|button, calling up the damage report|large button embossed with the stylized image of a mailbox|button to cancel the current autopilot program|button to scan for recent wormhole activity|button on an? &quot;.+?&quot; key|large button marked CYCLE|button to deploy the starship's asteroid anchor).*?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/keyPress")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^Game Change: .+?$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/change")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Z][a-z]+\s?[A-Za-z\s]* (gestures? (?:towards?|for) .+?, (?:who|which) (?:you)?\s?promptly (?:joins \w+ group|do)|takes? control of .+? group|joins? [A-Za-z\s'-]+ group|begins? following [A-Za-z\s'-]+)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/joins")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^[A-Z][a-z]+?\s?[A-Za-z\s]*? (?:indicate|inform|leave)s?.+(?:group|that \w+ no longer wish[es]{0,2} (?:\w+|for \w+?) to follow \w+)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/disband")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^You (?:receive|earn) a?\s?[0-9,.]+?[0-9]{2} credits? .+?\."
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/cash")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(?:\w+ the droid|An internal stun turret) suddenly (?:slumps|begins) (?:over|to) (?:as \w+ mechanical systems begin to shut|power) down\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("device/shutdown")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(?:\w+ the droid|An internal stun turret) suddenly powers back up\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("device/powerUp")</send>
  </trigger>

  <trigger
   name="interruptFollow"
   group="misc"
   match="^You follow [A-Z][a-z]+[\s\w]+ (north|south|east|west|up|down|into|out|through)(.*)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   print("%0")
  if config:get_option("follow_interrupt").value == "yes" then
    speech_interrupt("%1%2")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^You remove (?:part of)?\s?your .+? (?:from a .+? storage bag)?\s?and (.+?)\."
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if "%1" == "put it on" then
    return mplay("device/suitOn")
   else
    return mplay("device/suitOff")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^You access a \w+ portable point unit and note you have .+?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("device/pointUnit")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^Please do not enter so many commands at once\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/spam", "alarm")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^(?:[A-Z][a-z\s]+)+ (?:has just)?\s?given? (?:you)?\s?\d+ tradesman certificates?\s?(?:to .+?)?\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/certificate")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^.+ turns? .+ pages?[ .].+\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/page")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^.+ press(?:es)? a button on the wall to summon the lift\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/lift")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^.+ suddenly loses? \w+ footing and falls? to the ground\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/ftlFall")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\*{3} .+ has arrived to answer your plea for help\. \*{3}$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/hosts/assist")</send>
  </trigger>

  <trigger
   enabled="y"
   group="misc"
   match="^\w+ the droid punches .+ in the face\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("misc/droidHit")</send>
  </trigger>

</triggers>
]=])

-------------------------
-- Global table of walkstyle:
walkStyle = {
  ["ambles"] = "amble",
  ["boogies"] = "boogie",
  ["bounces"] = "bounce",
  ["canters"] = "canter",
  ["clomps"] = "clomp",
  ["crawls"] = "crawl",
  ["creeps"] = "creep",
  ["dances"] = "dance",
  ["darts"] = "dart",
  ["dashes"] = "dash",
  ["drags"] = "drag",
  ["flies"] = "fly",
  ["floats"] = "float",
  ["glides"] = "glide",
  ["hastens"] = "hasten",
  ["hobble"] = "hobble",
  ["hops"] = "hop",
  ["hurries"] = "hurry",
  ["jogs"] = "jog",
  ["leeps"] = "leap",
  ["limps"] = "limp",
  ["lumbers"] = "lumber",
  ["marches"] = "march",
  ["meanders"] = "meander",
  ["moonwalks"] = "moonwalk",
  ["moseys"] = "mosey",
  ["plods"] = "plod",
  ["parades"] = "parade",
  ["perambulates"] = "perambulate",
  ["prances"] = "prance",
  ["races"] = "race",
  ["runs"] = "run",
  ["rushes"] = "rush",
  ["sashays"] = "sashay",
  ["saunters"] = "saunter",
  ["scampers"] = "scamper",
  ["scrambles"] = "scramble",
  ["scurries"] = "scurry",
  ["scuttles"] = "scuttle",
  ["shuffles"] = "shuffle",
  ["skates"] = "skate",
  ["skips"] = "skip",
  ["slinks"] = "slink",
  ["slouches"] = "slouch",
  ["sprints"] = "sprint",
  ["staggers"] = "stagger",
  ["stalks"] = "stalk",
  ["stomps"] = "stomp",
  ["storms"] = "storm",
  ["strides"] = "stride",
  ["strolls"] = "stroll",
  ["struts"] = "strut",
  ["stumbles"] = "stumble",
  ["swaggers"] = "swagger",
  ["swims"] = "swim",
  ["tiptoes"] = "tiptoe",
  ["traipses"] = "traipse",
  ["tramps"] = "tramp",
  ["trots"] = "trot",
  ["trudges"] = "trudge",
  ["twirls"] = "twirl",
  ["waddles"] = "waddle",
  ["walks"] = "walk"

} -- table of walk-styles