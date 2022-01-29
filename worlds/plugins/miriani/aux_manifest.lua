local path = require("pl.path")
local scripts = utils.readdir(relpath.."*")
local sounds = utils.readdir(GetInfo(74)..SOUNDPATH.."*")
local secretpack = utils.readdir("lua/secretpack/*")

local manifest = {}

local function recursive_build(filesystem, dir, dest, ex)

  -- build the list
  table.foreach(dir,
  function(k, v)
    if v.directory and (not string.find(k, "%.")) then

      -- Recursive index into filesystems.
      local sub_dir = utils.readdir(dest..k.."/*")
      recursive_build(filesystem.."/"..k, sub_dir, dest..k.."/", ex)
    end -- if

    if path.extension(dest..k) == ex then
      manifest[#manifest + 1] = string.format("https://erosso.net/projects/files/toastush/%s/%s,MUSH/%s", filesystem, k, path.relpath(dest))
    end -- if
  end ) -- foreach

end --recursive_build

recursive_build("miriani", scripts, relpath, ".lua")
recursive_build("secretpack", secretpack, "lua/secretpack/", ".lua")
recursive_build("sounds/miriani", sounds, GetInfo(74)..SOUNDPATH, ".ogg")



return manifest