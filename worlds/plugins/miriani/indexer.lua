
function get_hash(filename)
  local path = require("pl.path")
  local f, s

  f = io.open(path.relpath(filename), "rb")

  if (f) then
    s = f:read("*all")

    f:close()
  end -- if

  local hash
  if (s) then
    hash = utils.tohex(utils.md5(string.gsub(
s, "\r", "\n")))
  end -- if

  return hash
end -- get_hash

function write_file(filename, manifest)

  local f = io.open(filename, "w")

  if (f) then
    f:write(manifest)
    f:close()
  return 1
  end -- if
end -- write_file

function gen_index(name, line, wc)
  notify("info", "Generating index...")
  local path = require("pl.path")
  local json = require("json.encode")
  -- create an index for the updater.
  -- Users won't have to call this unless they are maintaining their own package.

  local filename = wc[1]
  local scripts = utils.readdir(relpath.."*")
  local sounds = utils.readdir(GetInfo(74)..SOUNDPATH.."*")
  local secretpack = utils.readdir("lua/secretpack/*")

  local manifest = {}

  local function recursive_index(dir, ph, ex)

    table.foreach(dir,
    function (k, v)
      if v.directory and (not string.find(k, "%.")) then

        -- Recursive index into filesystems.
        local sub_dir = utils.readdir(ph..k.."/*")
        recursive_index(sub_dir, ph..k.."/", ex)
      end -- if

      if path.extension(ph..k) == ex then


        local dest = string.gsub(path.relpath(ph..k), "\\", "/")
        manifest[dest] = {
        name = k,
        hash = get_hash(dest),
        url = string.format("https://erosso.net/projects/files/toastush/%s", dest)
        } -- manifest
      end -- if
    end ) -- foreach
  end -- recursive_index

  recursive_index(scripts, relpath, ".xml")
  recursive_index(scripts, relpath, ".lua")
  recursive_index(sounds, GetInfo(74)..SOUNDPATH, ".ogg")
  recursive_index(secretpack, "lua/secretpack/", ".lua")

  local serialized = json.encode(manifest)

  local e = write_file(filename, serialized)
  if (e) then
    notify("info", "Index file successfully generated.")
  else
    notify("info", "Failed to generate the index file.")
  end -- if
end -- gen_index
