ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="vehicle"
   match="^You open the hatch of an? .+? (?:called &quot;.+?&quot;)?\s?and climb inside\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("vehicle/enter", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="vehicle"
   match="^([A-Z][a-z\s]+)+ climbs? out of (?:the|an?) .+?.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("vehicle/exit", "other")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="vehicle"
   match="^You carefully pilot the vehicle into a small chamber above the docking bay\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("vehicle/drive", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="vehicle"
   match="^You are suddenly pressed against your seat as the vehicle is catapulted out of the docking bay\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("vehicle/launch", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="vehicle"
   match="^The ship comes to a halt in the planet's atmosphere\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>mplay("vehicle/halt", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="vehicle"
   script="gagline"
   match="^You feel the pull of acceleration as the (?:craft|ship) (?:navigates|begins) (?:[dea]{1,2}scending)?\s?through the (?:planet's)?\s?atmosphere\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("vehicle/moveStart", "other")</send>
  </trigger>

  <trigger
   enabled="y"
   group="vehicle"
   script="gagline"
   match="^The pull of acceleration eases off as the (?:craft|ship) (?:completes|ceases) its (?:maneuvering|[dea]{1,2}scent)\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>mplay("vehicle/moveStop", "other")</send>
  </trigger>


</triggers>
]=])