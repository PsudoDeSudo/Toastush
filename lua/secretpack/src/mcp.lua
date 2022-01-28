-- @module mcp-client
-- Implements a Mud Client Protocol (MCP) client.
-- Specifications are accurate to versions 2.1 
-- Implements mcp-negotiate package 2.0
-- Implements mcp-cord package 2.0
-- See 'https://www.moo.mud.org/mcp/mcp2.html`

-- Author: Erick Rosso
-- Last updated 2022.16.21

---------------------------------------------

local class = require("pl.class")

class.Mcp()

Mcp.packages = {
  ["mcp-negotiate"] = {min=1.0, max=2.0},
  ["mcp-cord"] = {min=1.0, max=2.0}
}

Mcp.const = {
  authkey = "",
  min_version = 2.1,
  max_version = 2.1
}

function Mcp:register()

  math.randomseed(os.time())
  for i=1, math.random(10, 15) do
    self.const.authkey = self.const.authkey..string.char(math.random(48, 122)) -- Generate random string.
  end -- for

  local send_world = {string.format("#$#mcp authentication-key: %s version: %s to: %s", self.const.authkey, self.const.min_version, self.const.max_version)}

  -- mcp-negotiate package specifications.
  for k,v in pairs(self.packages) do
    send_world[#(send_world)+1] = string.format("#$#mcp-negotiate-can %s package: %s min-version: %s max-version: %s", self.const.authkey, k, v.min, v.max)
  end -- for

  -- Conclude mcp-negotiate packages.
  send_world[#(send_world)+1] = string.format("#$#mcp-negotiate-end %s", self.const.authkey)

  table.foreach(send_world, function(k,v) Send(v) end)

  return 0 -- ok
end -- register

return Mcp