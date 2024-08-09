-- @module ansi_message
-- Defines soundpack message formatting.
-- If editing the color's table,
-- Preserve syntax:
-- <level> = <foreground>, <background>

-- author: Erick Rosso
-- Last updated 2022.01.21

---------------------------------------------

local colortable = {
  info = {"blue","black"},
  important = {"green","black"},
  critical = {"red","black"}
}

function notify(level, msg, brief)
  local color = colortable[level]

  if not brief then  
    ColourNote(color[1], color[2], msg)
  else
        nvda.say(msg)
  end -- if
end -- notify

return notify