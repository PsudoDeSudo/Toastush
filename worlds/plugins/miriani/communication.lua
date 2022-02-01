
ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="comm"
   match="^\[Frequency ([0-9]{1,3}\.[0-9]{1,2})\s?\|?\s?(\w+)?\] (.+)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/metaf", "communication")
   if "%2" ~= "" then
    print("[%2] %3")
    channel("metaf", "[%2] %3", {"metaf", "communication"})
   else
    print("%0")
    channel("metaf", "%0", {"metaf", "communication"})
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^(?:A|From).* flight control scanner \w+, &quot;(.+?)&quot;$"
   regexp="y"
  omit_from_output="y"
   send_to="14"
   sequence="100"
    >
  <send>
   print("%1")
   channel("flight", "%1", {"flight"})
   if string.find ("%1", "we detect.+Ontanka") then
    return mplay ("comm/praelorInbound", "communication")
   end -- if praelor activity
   mplay ("comm/flight", "communication")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"	
   match="^\[Private \| [\w\s]+\] .*$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay ("comm/private", "communication")
   channel("private", "%0", {"private", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^\[(Newbie|Chatter|General|Short|Admin|OOC)(?:-range)? ?(?:Communication|Message)?\]:? .+$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay("comm/"..string.lower("%1"), "communication")
   channel("%1", "%0", {"communication", string.lower("%1")})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
  match="^([A-Z][a-z]* ?)+ (say|ask|exclaim)s?,? ?(?:.+)?&quot;.+&quot;$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay("comm/say", "communication")
   channel("say", "%0", {"say", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^\[ ([\w\s]+) shatters? immersion (\w+-wide)?\s?and &quot;?(.+)&quot;? \]$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/rooc", "communication")
   if "%2" == "ship-wide" or "%2" == "structure-wide" then
    print("[SOOC] %1 %3")
    channel("sooc", "[SOOC] %1 %3", {"ooc", "communication"})
   else
    print("[ROOC] %1 %3")
   channel("rooc", "[ROOC] %1 %3", {"ooc", "communication"})
   end -- if ship wide
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^You (?:press a small button mounted on the wall|patch your suit radio through the public address system) and (.+)$"
   regexp="y"
   send_to="14"
   omit_from_output="y"
   omit_from_log="y"
   sequence="100"
  >
  <send>
   mplay("comm/paYou", "communication")
   local msg = "[PA] You %1"
   channel("pa", msg, {"pa", "communication"})
       print(msg)
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^(.+)'s voice comes over the intercom, (.+), (&quot;.+&quot;)$"
   regexp="y"
   send_to="14"
   omit_from_output="y"
   omit_from_log="y"
   sequence="100"
  >
  <send>
   mplay("comm/paOther", "communication")
   if environment and config:get_option("pa_interrupt").value == "yes" and environment["parent"] == "starship" then
    Execute("tts_stop")()
   end -- if
   local verb = string.gsub("%2", "ing", "s")
   local msg = "[PA] %1 "..verb..", %3"
   channel("pa", msg, {"pa", "communication"})
   print(msg)
  </send>
  </trigger>
  <trigger
   enabled="y"
   group="comm"
   match="^(.+) (\w+) over the intercom\.$"
   regexp="y"
   send_to="14"
   omit_from_output="y"
   omit_from_log="y"
   sequence="100"
  >
  <send>
   mplay("comm/paOther", "communication")
local msg = "[PA] %1 %2."
   channel("pa", msg, {"pa", "communication"})
print(msg)
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^(.+) into a small microphone mounted on the wall\.$"
   regexp="y"
   send_to="14"
   omit_from_output="y"
   omit_from_log="y"
   sequence="100"
  >
  <send>
   mplay("comm/paOther", "communication")
   local msg = "[PA] %1"
   channel("pa", msg, {"pa", "communication"})
   print(msg)
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^([\w\s]+) (?:hear)?\s?(shout|yell)s?, (&quot;.+?&quot;)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/shout", "communication")
   print("%1 %2, %3")
   channel("shout", "%1 %2, %3", {"say", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^You (.+?) into a small microphone and listen as (?:it is|it's) played through the ship's external PA\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/paYou", "communication")
   print("[External PA] You %1")
   channel("pa", "[External PA] You %1", {"pa", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^A (.+) from ([\w\s]+) is piped through the ship's intercom from the external PA\.(?: You hear (.+))$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/paOther", "communication")
   if "%1" ~= "message" then
   print("[External PA] You hear %2 %1")
    channel("pa", "[External PA] You hear %2 %1", {"pa", "communication"})
   else
    print("[External PA] You hear %2 %3")
    channel("pa", "[External PA] You hear %2 %3", {"pa", "communication"})
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^From a large speaker on ([\w\s]+), (you hear .+)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/paOther", "communication")
   print("[From %1] %2")
   channel("pa", "[From %1] %2", {"pa", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^This (?:ship|planet|station|moon) (transmits|demands|broadcasts),? &quot;?.+&quot;?$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay ("comm/ship", "communication")
   channel("ship", "%0", {"ship", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^[\w\s]+ the droid says in an? \w+ voice, &quot;.+?&quot;$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("comm/droid", "communication")</send>
  </trigger>


  <trigger
   enabled="y"
   group="comm"
   match="^Via general sector communication, (.+?)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/sector", "communication")
   print("[Gen] %1")
   channel("ship", "[Gen] %1", {"ship", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^Via long-range communication, (.+?) broadcasts: (&quot;.+?&quot;)$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("comm/broadcast", "communication")
   print("%1 broadcasts: %2")
   channel("ship", "%1 broadcasts: %2", {"ship", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^\[(?:AIE|Commonwealth|Hale) \| .+?\] .+$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay ("comm/alliance", "communication")
   channel("alliance", "%0", {"alliance", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^\[Starship \| [\w\s]+ transmits, &quot;.+&quot;$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay ("comm/relay", "communication")
   channel("ship", "%0", {"ship", "communication"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^A message board reader beeps quietly, indicating to you that there is a new message in (.+?)\. It was posted by (.+?) with the subject (.+?)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("device/newPost")
   print("New board post in %1. Posted by %2: Subject: %3")
   channel("board", "New board post in %1. Posted by %2: Subject: %3", {"board"})
  </send>
  </trigger>
  <trigger
   enabled="y"
   group="comm"
   match="^You turn a .+? (on|off)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("comm/%1", "communication")</send>
  </trigger>

<trigger
   enabled="y"
   group="comm"
   match="^You add frequency [0-9]{1,3}\.[0-9]{1,2}\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("comm/tune", "communication")</send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^You (?:re)?(activate|deactivate) .+?$"
regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay ("device/%1", "communication")</send>
  </trigger>

  <trigger
   enabled="y"
   group="comm"
   match="^[\w\s]+ transmits?(?: in an? \w+ voice)?, &quot;.+?&quot;$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   mplay ("comm/transmit", "communication")
   channel ("transmit", "%0", {"communication", "say"})
  </send>
  </trigger>
  
  <trigger
   enabled="y"
   group="comm"
   match="^\[([\w' ]+)\] .+ transmits, .+"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   local sound = string.find("%1", " ") and "courier" or "organization"
   mplay("comm/"..sound, "communication")
   channel("generic_chan", "%0", {"communication"})
  </send>
  </trigger>

</triggers>
]=])