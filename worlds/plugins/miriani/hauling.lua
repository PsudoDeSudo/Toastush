ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="hauling"
   match="^You feel a mild vibration as the starship's asteroid anchor buries itself into the asteroid's surface\.$"
   regexp="y"
   send_to="12"
 >
  <send>mplay("activity/hauling/shipAnchor")</send>
  </trigger>

  <trigger
   enabled="y"
   group="hauling"
   match="^Upon finding a suitable location, you press a small button on the side of an asteroid anchor, which forcefully buries itself into the ground\.$"
   regexp="y"
   send_to="12"
 >
  <send>mplay("activity/hauling/singleAnchor")</send>
  </trigger>

  <trigger
   enabled="y"
   group="hauling"
   match="^You begin to painstakingly tie a coil of sturdy line to an asteroid anchor\.$"
   regexp="y"
   send_to="12"
 >
  <send>mplay("activity/hauling/connectWire")</send>
  </trigger>

  <trigger
   enabled="y"
   group="hauling"
   match="^The whine of strained components echos throughout the area as the starship struggles to haul the asteroid\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
 >
  <send>mplay("activity/hauling/haulRoid")</send>
  </trigger>

  <trigger
   enabled="y"
   group="hauling"
   match="^A light envelops the room and quickly sucks your asteroid hauling supplies into an asteroid hauling kit\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
 >
  <send>mplay("activity/hauling/kitRetrieve")</send>
  </trigger>

</triggers>
]=])