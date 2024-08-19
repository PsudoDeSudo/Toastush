-- @module mcp_client
-- Implements a Mud Client Protocol (MCP) client.
-- Specifications are accurate to versions 2.1 
-- Implements mcp-negotiate package 2.0
-- Implements mcp-cord package 2.0
-- See 'https://www.moo.mud.org/mcp/mcp2.html`

-- Author: Erick Rosso

---------------------------------------------

local class = require("pl.class")

class.MCP()

MCP.packages = {
  ["mcp-negotiate"] = {min_version = 1.0, max_version = 2.0},
  ["mcp-cord"] = {min_version = 1.0, max_version = 2.0}
}

MCP.constants = {
  auth_key = "",
  min_version = 2.1,
  max_version = 2.1
}

function MCP:generate_auth_key()
  math.randomseed(os.time())
  local key = {}
  for _ = 1, math.random(10, 15) do
    table.insert(key, string.char(math.random(48, 122))) -- Generate random string.
  end
  self.constants.auth_key = table.concat(key)
end

function MCP:register()
  self:generate_auth_key()

  local messages = {
    string.format("#$#mcp authentication-key: %s version: %.1f to: %.1f", 
    self.constants.auth_key, self.constants.min_version, self.constants.max_version)
  }

  -- mcp-negotiate package specifications.
  for package_name, versions in pairs(self.packages) do
    table.insert(messages, string.format(
      "#$#mcp-negotiate-can %s package: %s min-version: %.1f max-version: %.1f", 
      self.constants.auth_key, package_name, versions.min_version, versions.max_version))
  end

  -- Conclude mcp-negotiate packages.
  table.insert(messages, string.format("#$#mcp-negotiate-end %s", self.constants.auth_key))

  for _, message in ipairs(messages) do
    Send(message)
  end

  return 0 -- ok
end

function MCP:handle_message(message)
  -- For now, simply print the incoming message
  -- print("MCP Message Received: ", message)
end


return MCP