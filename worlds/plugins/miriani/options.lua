
local options = {
  computer_voice = {descr="Use computerized voice files.", value="no", group="general"},
  count_cannon = {descr="Count remaining cannon shots: Use the command WEAPON in a weapon's room to initialize.", value="no", group="combat"},
  count_praelor = {descr="Count the number of insectoids detected in a room.", value="no", group="combat"},
  external_camera = {descr="Gag external camera output.", value="no", group="gags"},
  internal_camera = {descr="Gag internal camera output.", value="no", group="gags"},
  focus_interrupt = {descr="Interrupt speech on focus.", value="no", group="speech"},
  follow_interrupt = {descr="Interrupt speech when following.", value="no", group="speech"},
  friendly_combat = {descr="Gag friendly (non praelor) sector combat messages.", value="no", group="gags"},
  mute = {descr="Master Mute toggle:", value="no", group="general"},
  pa_interrupt = {descr="Interrupt speech for public address (PA) messages.", value="no", group="speech"},
  praelor_interrupt = {descr="Interrupt speech when detecting insectoid activity.", value="no", group="speech"},
  warn_lag = {descr="Warn when detecting large lag spikes.", value="no", group="general"},
  roundtime = {descr="Play a sound when roundtime is up.", value="no", group="general"},
  secondary_lock = {descr="Play a sound instead for secondary locks (unfocus starships).", value="no", group="combat"},
  spam = {descr="Cutback on spam by gagging flavored text.", value="no", group="gags"},


  -- Channel buffers:

  -- default:
  communication_buffer = {descr="Communication: (all channels)", value="yes", group="buffers"},
  private_buffer = {descr="Private Communication", value="yes", group="buffers"},
  combat_buffer = {descr="Combat (Praelor, ship-locks)", value="yes", group="buffers"},
  general_buffer = {descr="General Communication", value="yes", group="buffers"},
  link_buffer = {descr="Web Browser Links", value="yes", group="buffers"},

  -- extended:
  camera_buffer = {descr="Camera Feeds(droids, internals, external)", value="no", group="buffers"},
  market_buffer = {descr="Tradesman Market", value="no", group="buffers"},
  metaf_buffer = {descr="Metafrequency", value="no", group="buffers"},
  flight_buffer = {descr="Flight Control", value="no", group="buffers"},
  say_buffer = {descr="Say Communication", value="no", group="buffers"},
  ooc_buffer = {descr="OOC Communication (ROOC, SOOC, OOC channel)", value="no", group="buffers"},
  ship_buffer = {descr="Ship-to-ship Communication", value="no", group="buffers"},
  pa_buffer = {descr="Public Address speaker (PA)", value="no", group="buffers"},
  alliance_buffer = {descr="Alliance Communication", value="no", group="buffers"},
  board_buffer = {descr="Message Board", value="no", group="buffers"},
  chatter_buffer = {descr="Chatter Communication", value="no", group="buffers"},
  computer_buffer = {descr="Starship Computer Messages", value="no", group="buffers"},

} -- options

return options