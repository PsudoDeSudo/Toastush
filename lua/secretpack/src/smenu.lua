-- @module menu
-- Provides a menu-driven for manipulating Toastush constants.

-- Author: Erick Rosso
-- Last updated on 2022.01.21

---------------------------------------------


function smenu(option)
  local main_menu = config:render_menu_list(option)
  local title, choice = string.format("%s Manager - version %s", GetPluginName(), config:get_version())

  local function sound_effect(name)
    play(
      string.format("audio/%s", name))
  end -- sound_effect

  if type(main_menu) ~= 'table' then
  notify("info", string.format("Unable to locate menu group '%s`.", option))
  return 0
  else
    table.sort(main_menu)
    -- Display main list.
    sound_effect("prompt")
    choice = utils.listbox("Select Setting", title, main_menu, 1)
  end -- if

  -- provide interface for secondary menu.
  if choice then
    local secondary_menu, group = {}
    repeat -- Display menu until escaped.
      if (not option) then
        secondary_menu = config:render_menu_list(group or main_menu[choice])
        -- Display nested options.
        sound_effect("prompt")
        choice = utils.listbox("Select Setting", title, secondary_menu)
      end -- if

      -- Step our user through a sequence to determine the value type.
      if config:is_option(choice) then
        -- Interface for boolean value.
        local yes_no = utils.msgbox("Select an option.", title, "yesnocancel", "?")
        config:set_option(choice, yes_no ~= nil and yes_no ~= "cancel" and yes_no or config:get_option(choice))
        option, group = nil, config:get_option(choice).group
      end -- if
    until not choice
    assert(config:save() == 0)
  end -- if
  sound_effect("close")
end -- smenu
