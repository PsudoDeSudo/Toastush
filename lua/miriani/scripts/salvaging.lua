
ImportXML([=[
<triggers>

  <trigger
   enabled="y"
   group="salvaging"
   script="gagline"
   match="^You hear the sounds of the atmospheric scoop activating\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
  >
  <send>mplay("activity/salvaging/scoop")</send>
  </trigger>



</triggers>
]=])