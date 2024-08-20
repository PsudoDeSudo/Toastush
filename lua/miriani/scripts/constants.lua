-- Defines shared constants across Miriani plugins.

VERSION = "3.1.4"
EXTENSION = ".ogg"
ALT_EXTENSION = ".ogg"
SOUNDPATH = "miriani/"
ALTPATH = "alternate/"
TOASTUSH_ID = "843d2f53cb3685465bda7d4a"
UPDATE_ID = "508bd88f4d441f81466bf471"
INDEX = "index-v5.manifest"
DISCORD = "https://discord.gg/rpqbjd8bTt"
PROXIANI = "https://github.com/dwog/proxiani"
UPDATE_URL = "https://raw.githubusercontent.com/PsudoDeSudo/Toastush/main"
IDLE_CUTOFF = 1200







-- sound groups to disable:

  minimal_groups = {"ship", "combat", "vehicle", "computer", "salvaging", "misc", "market", "hauling", "asteroid", "archaeology"}


-- room types:
rooms = {
  starship = {
    cr = "cr",
    eng = "eng",
    storage = "storage",
    weapons = "weapon",
    repair = "eng",
    bay = "bay",
    corridor = "corridor",
    stateroom = "stateroom",
    medical = "starship_medical",
    airlock = "airlock",
    pool = "pool",
    observation = "observation",
    brig = "brig",
    unknown = "starship_unknown",
  }, -- starship

  planet = {
    garage = "garage",
    pool = "pool",
    hottub = "pool",
    observation = "observation",
    unknown = "planet_unknown",
    security = "security",
    lp = "landingpad",

  }, -- station

  station = {
    garage = "garage",
    pool = "pool",
    hottub = "pool",
    observation = "observation",
    unknown = "station_unknown",
    security = "security",
    lp = "landingpad",

  }, -- planet

  room = {

  } -- room
} -- rooms


-- Global table of walkstyle:
walkStyle = {
  ["ambles"] = "amble",
  ["boogies"] = "boogie",
  ["bounces"] = "bounce",
  ["canters"] = "canter",
  ["clomps"] = "clomp",
  ["crawls"] = "crawl",
  ["creeps"] = "creep",
  ["dances"] = "dance",
  ["darts"] = "dart",
  ["dashes"] = "dash",
  ["drags"] = "drag",
  ["flies"] = "fly",
  ["floats"] = "float",
  ["glides"] = "glide",
  ["hastens"] = "hasten",
  ["hobble"] = "hobble",
  ["hops"] = "hop",
  ["hurries"] = "hurry",
  ["jogs"] = "jog",
  ["leeps"] = "leap",
  ["limps"] = "limp",
  ["lumbers"] = "lumber",
  ["marches"] = "march",
  ["meanders"] = "meander",
  ["moonwalks"] = "moonwalk",
  ["moseys"] = "mosey",
  ["plods"] = "plod",
  ["parades"] = "parade",
  ["perambulates"] = "perambulate",
  ["prances"] = "prance",
  ["races"] = "race",
  ["rides"] = "ride",
  ["runs"] = "run",
  ["rushes"] = "rush",
  ["sashays"] = "sashay",
  ["saunters"] = "saunter",
  ["scampers"] = "scamper",
  ["scrambles"] = "scramble",
  ["scurries"] = "scurry",
  ["scuttles"] = "scuttle",
  ["shuffles"] = "shuffle",
  ["skates"] = "skate",
  ["skips"] = "skip",
  ["slinks"] = "slink",
  ["slouches"] = "slouch",
  ["sprints"] = "sprint",
  ["staggers"] = "stagger",
  ["stalks"] = "stalk",
  ["stomps"] = "stomp",
  ["storms"] = "storm",
  ["strides"] = "stride",
  ["strolls"] = "stroll",
  ["struts"] = "strut",
  ["stumbles"] = "stumble",
  ["swaggers"] = "swagger",
  ["swims"] = "swim",
  ["tiptoes"] = "tiptoe",
  ["traipses"] = "traipse",
  ["tramps"] = "tramp",
  ["trots"] = "trot",
  ["trudges"] = "trudge",
  ["twirls"] = "twirl",
  ["waddles"] = "waddle",
  ["walks"] = "walk"
} -- table of walk-styles
