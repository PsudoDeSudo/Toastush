
ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="gags"
   match="^[-]{3,}$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="gags"
   match="^You make a selection on a .+? Lore computer\.$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="gags"
   match="^You peer \w+ and see[.]{3}$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
enabled="y"
   group="gags"
   match="^The starship vibrates violently as it nears the wormhole's event horizon\.$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
enabled="y"
   group="gags"
   match="^LoreTech Personal Lore Computer - \[.+?\]$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
   group="gags"
   match="^A bright flash of blue light floods the room as the starship travels through the wormhole\.$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="gags"
   match="^The windows automatically dim as gate after gate becomes visible, each causing a brilliant flash of light as it redirects the wormhole\.$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="gags"
   match="^You are suddenly jarred as the ship begins rapid deceleration\.$"
   regexp="y"
   omit_from_output="y"
   sequence="100"
  >
  </trigger>

  <trigger
   enabled="y"
   group="gags"
   match="^The mild vibration of acceleration eases off (?:and|as) (?:is|the) (?:replaced|ship) (?:by|sets) (?:the|down) (?:firm|on) (?:pull|the) .+?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  </trigger>

</triggers>
]=])