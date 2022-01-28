-- @module init
-- Instantiates the secretpack soundpack namespace.
-- Imports all dependencies.

-- Author: Erick Rosso
-- Last updated 2022.01.21

---------------------------------------------

local path = require("pl.path")

local src = "/lua/secretpack/src"

-- Dependencies:
config = require(src.."/include/config")
audio = require(src.."/include/audio")
notify = require(src.."/include/notify")

-- Table of dependencies.
local namespace = {
  "SMenu", -- Menu-driven interface for config.
  "sounds", -- secretpack specific audio functions.
} -- namespace


fullpath = "lua/secretpack/src"
table.foreach(namespace,
function (i, mod)
  if path.isfile(string.format("%s/%s.lua", fullpath, mod)) then
    require(string.format("%s/%s", src, mod))
  else
    notify("critical", string.format("Failed to locate secretpack module %s/%s.lua.", src, mod))
  end -- if
end )
 
-- initialize
  -- initialize speech interrupt
    assert(package.loadlib("MushReader.dll", "luaopen_audio"))()

assert(audio:_init() == 0)

