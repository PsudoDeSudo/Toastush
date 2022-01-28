
ImportXML([=[
<triggers>

  <trigger
   enabled="y"
   group="archaeology"
   script="gagline"
   match="^You press a small button on the side of (a level \w+ archaeological dig site scanner) and begin directing it toward several likely locations\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
  >
  <send>
   mplay("activity/archaeology/search")

   if config:get_option("spam").value == "yes" then
     print("You activate %1.")
   end -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="archaeology"
   script="gagline"
   match="^A level \w+ archaeological dig site scanner (?:indicates|reports) that (?:you should move to|there is an object) (.+)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
  >
  <send>
   mplay("activity/archaeology/detect")

   if config:get_option("spam").value == "yes" then
     print("Artifact detected %1")
   end  -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="archaeology"
   script="gagline"
   match="^A level \w+ archaeological dig site scanner indicates that there is an artifact buried approximately (\d+\.\d+) feet beneath the surface\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
  >
  <send>
   mplay("activity/archaeology/artifact")

   if config:get_option("spam").value == "yes" then
     print("%1 feet")
   end  -- if
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="archaeology"
   match="^[A-Z].+ thrusts? a small shovel into the ground and begins? methodically removing large chunks of dirt\.$"
   regexp="y"
   send_to="12"
  >
  <send>mplay("activity/archaeology/shovel")</send>
  </trigger>

  <trigger
   enabled="y"
   group="archaeology"
   match="^Your digging reveals (.+).+\.$"
   regexp="y"
   send_to="12"
  >
  <send>mplay("activity/archaeology/find")</send>
  </trigger>

  <trigger
   enabled="y"
   group="archaeology"
   match="^You notice some debris littering the area and realize that you shattered the artifact\.$"
   regexp="y"
   send_to="12"
  >
  <send>mplay("activity/archaeology/shatter")</send>
  </trigger>

  <trigger
   enabled="y"
   group="archaeology"
   match="^You firmly wedge a sleek metallic digging apparatus into the ground and press a trigger on the handle\. The attached shovel immediately goes to work, sending debris| (?:flying into the air around it|floating away into the surrounding water)\.$"
   regexp="y"
   send_to="12"
  >
  <send>mplay("activity/archaeology/apparatus")</send>
  </trigger>

  <trigger
   enabled="y"
   group="archaeology"
   match="^An eighteen-legged insect that greatly resembles an orange stone sidles along the walls of the hole before eventually falling back to the bottom\.$"
   regexp="y"
   send_to="12"
  >
  <send>mplay("activity/archaeology/insect")</send>
  </trigger>

</triggers>
]=])
