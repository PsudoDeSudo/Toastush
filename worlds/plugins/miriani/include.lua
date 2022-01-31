
-- import namespace

require ("secretpack.src")

local src = GetInfo(60).."miriani"

local dependencies = {
  "constants", -- Global constants
  "functions", -- global functions
  "options", -- global options
  "indexer", -- file indexer
  "hooks", -- Miriani soundpack hooks:
  "misc", -- misc triggers without any specific categorization
  "market", -- tradesman market procedures
  "gags", -- text throttle
  "ship", -- starship-related procedures
  "computer", -- Starship computer
  "combat", -- combat procedures
  "starmap_scan", -- starmap and scan routines
  "communication", -- Communication
  "vehicles", -- vehicles
  "archaeology", -- archaeology
  "hauling", -- asteroid hauling

} -- dependencies

table.foreach(dependencies,
function (i, mod)
  require(string.format("%s/%s", src, mod))
end )


