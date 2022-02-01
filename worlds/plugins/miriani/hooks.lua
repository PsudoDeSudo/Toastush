
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
   name="starship"
   group="hooks"
   script="set_environment"
   match="^#\$#soundpack environment starship (space|landed) \| (powered|unpowered) \| (hostile|safe) \| (light|dark) \| (indoors|outdoors) \| (.+?)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
   </trigger>

  <trigger
   enabled="y"
   name="planet"
   group="hooks"
   script="set_environment"
   match="^#\$#soundpack environment planet (.+?) \| (hostile|safe) \| (light|dark) \| (indoors|outdoors) \| (.+?)$$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
   </trigger>

  <trigger
   enabled="y"
   name="space"
   group="hooks"
   script="set_environment"
   match="^#\$#soundpack environment space \| (hostile) \| (light|dark) \| (outdoors)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
   </trigger>

  <trigger
   enabled="y"
   name="station"
   group="hooks"
   script="set_environment"
   match="^#\$#soundpack environment station \| (hostile|safe) \| (light|dark) \| (indoors|outdoors) \| (.+?)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
   </trigger>


  <trigger
   enabled="y"
   name="vehicle"
   group="hooks"
   script="set_environment"
   match="^#\$#soundpack environment vehicle (landed|atmosphere) \| (.+?)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
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
   script="playsocial"
   match="^#\$#soundpack social \| (\w+) \| (male|female|newter)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="hooks"
   match="^#\$#soundpack lore \| (.+?)$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>lore = string.lower("%1")</send>
  </trigger>

  <trigger
   enabled="y"
   group="hooks"
   match="^#\$#soundpack video_feed$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("device/camera")</send>
  </trigger>




</triggers>
]=])

