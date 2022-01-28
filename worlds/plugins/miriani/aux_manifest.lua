
local dir = utils.readdir(GetInfo(60).."miriani/*.lua")
local manifest = {}

-- build the list
table.foreach(dir,
function(k, v)
  manifest[#manifest + 1] = string.format("https://erosso.net/projects/files/toastush/miriani/%s", k)
end )

return manifest