-- @module config
-- Defines methods for manipulating global constants.
-- Uses mush variables to serialize across sessions.

-- Author: Erick Rosso
-- Last updated on 2022.01.21

---------------------------------------------

local class = require("pl.class")

local vars = {
  consts = require("secretpack.src.include.vars.consts"),
  audio = require("secretpack.src.include.vars.audio")
} -- vars

class.Config()

function Config:init_options(options)


  vars.options = options or {}
  local serial_config = GetVariable(vars.consts.pack.MUSH_VAR)

  local function initialize(v)
    self.options = v.options
    self.audio = v.audio
    self.consts = v.consts

    if self.options and self.audio and self.consts then
      return self.consts.error.OK
    else
      return self.consts.error.NO_INIT
    end -- if
  end -- Initialize

  local error = vars.consts.error.UNKNOWN

  if serial_config then
    do -- Incapcilate namespace.

      loadstring(serial_config)()
        error = initialize(mush_var)
    end -- do

    local current_options = vars.options
    local current_audio = vars.audio

    -- Update keys.
    table.foreach(current_options,
      function(k, v)
        if (not self.options[k]) or
        (self.options[k].descr ~= current_options[k].descr) or
        (self.options[k].group ~= current_options[k].group) or
        (type(self.options[k].value) ~= type(current_options[k].value)) then

          self.options[k] = v
        end -- if
      end ) -- anon 

    table.foreach(self.options,
      function(k)
        -- Remove missing keys.
        if (not current_options[k]) then
          self.options[k] = nil
      end -- if
    end ) -- anon

    table.foreach(current_audio,
      function(k, v)
        if (not self.audio[k]) then
          self.audio[k] = v
        end -- if
      end ) -- anon 

    table.foreach(self.audio,
      function(k)
        if (not current_audio[k]) then
          self.audio[k] = nil
      end -- if
    end ) -- anon

  else -- new settings
    error= initialize(vars)
  end -- if

  return error
end -- _init

function Config:get_option(key)
  return self.options[key] or {}
end -- get_option

function Config:get_attribute(group, attr)
  if self.audio[group] and self.audio[group][attr] then
    return self.audio[group][attr]
  end -- if

  return self.consts.error.INVALID_ARG
end -- get_attribute

function Config:set_option(key, val)
  if not self.options[key] then
    return self.consts.error.INVALID_ARG
  end -- if

  self.options[key].value = val
  return self.consts.error.OK
end -- set_option

function Config:set_attribute(group, attr, val)
  if not self.audio[group] or not self.audio[group][attr] then
    return self.consts.error.INVALID_ARG
  end -- if

  if type(val) ~= type(self.audio[group][attr]) then
    return self.consts.error.INVALID_TYPE
  end -- if

  self.audio[group][attr] = val
  return self.consts.error.OK
end -- set_attribute

function Config:save()

  mush_var = {
    options = self.options,
    audio = self.audio,
    consts = self.consts,
  }

  local serialize = require("serialize")
  local serial_config, error = serialize.save("mush_var")

  if type(serial_config) ~= 'string' then
    return error or self.consts.error.UNKNOWN
  end -- if

  local errcode = SetVariable(self.consts.pack.MUSH_VAR, serial_config)

  if errcode ~= 0 then
    return self.consts.error.NO_SAVE
  end -- if

  return self.consts.error.OK
end -- save

function Config:get(var)

  if self.consts.pack[var] == nil then
    return self.consts.error.INVALID_ARG
  end -- if

  return self.consts.pack[var]
end -- get

function Config:render_menu_list(option)
  local menu, seen_previously = {}, {}

  for k,v in pairs(self.options) do
    if option and string.find(v.group, option) then
      menu[k] = v.descr.." Currently: "..tostring(v.value)
    elseif (not option) and (not seen_previously[v.group]) then
      menu[#menu + 1] = tostring(v.group)
      seen_previously[v.group] = true
    end -- if
  end -- for

  if not next(menu) then
    return self.consts.error.INVALID_ARG
  end -- if

  return menu
end -- render_menu_list

function Config:is_option(key)

  if not self.options[key] then
    return false
  end -- if

  return true
end -- is_option

function Config:option_type(key)

  if not self.options[key] then
    return self.consts.error.INVALID_ARG
  end -- if

  return type(self.options[key].value) or self.consts.error.unknown
end -- option_type

function Config:is_mute()

  if self.options.mute.value ~= 'yes' then
  return false
  else
    return true
  end -- if
end -- is_mute

function Config:toggle_mute()
  self.options.mute.value = self.options.mute.value == 'no' and 'yes' or 'no'

  return self.options.mute.value == 'yes' and true or false
end -- toggle_mute

function Config:get_version()
  return self.consts.pack.VERSION or self.consts.error.UNKNOWN
end -- get_version

function Config:get_audio_groups()

  local groups = {}
  for k in pairs(self.audio) do

    groups[#(groups)+1] = k
  end -- for

  return not next(groups)
  and self.consts.error.UNKNOWN
  or groups
end -- get_audio_groups

return Config