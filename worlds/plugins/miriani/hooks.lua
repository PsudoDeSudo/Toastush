
ImportXML([=[

<triggers>
  <trigger
   enabled="y"
   group="hooks"
   match="^#\$#soundpack .+$"
   regexp="y"
   omit_from_output="y"
   omit_from_log="y"
   keep_evaluating="y"
   sequence="50"
  >
  </trigger>

  <trigger
   enabled="y"
   group="hooks"
   match="^#\$#soundpack_pong$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>Send("#$#SOUNDPACK_PING_REPLY ms\n")</send>
  </trigger>

  <trigger
   enabled="y"
   group="hooks"
   script="latency"
   match="^#\$#soundpack_lag (\d+)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="hooks"
   match="^#\$#soundpack environment (planet|starship|room|station|vehicle|space) (\w+?\s?\w*)?\s?\|?\s?(powered|unpowered|landed|atmosphere)?\s?\|?\s?(safe|hostile|starship|asteroid)?\s?\|?\s?(light|dark)?\s?\|?\s?(outdoors|indoors)?.*$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   if cameraFeed then
    cameraFeed = false
    return 0
   end -- if camera view

   environment = {
   parent = "%1",
   extra = "%2",
   power = "%3",
   lifeSupport = "%4",
   lighting = "%5",
   location = "%6"
   } -- Set the environment
   if foundstep then
    playstep (room, style)
    foundstep = false
   end -- if moving
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="hooks"
   script="playsocial"
   match="^#\$#soundpack social \| (\w+) \| (male|female|newter)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  </trigger>

</triggers>
]=])

