local fried = require("__PKGNAME__.fried")
local Times = fried:get_table("API.Times")
local API = fried:get_table("API")
local PromptCounters = fried:get_table("PromptCounters")

function API:feature(name)
  return fried:feature(name)
end

function API:feature_names()
  local a = {}
  for feature in pairs(fried:get_table("Features")) do
    table.insert(a, feature)
  end
  table.sort(a)
  return a
end

local function compact_featuredb()
  local names = API:feature_names()
  db:delete(fried.db.settings_db.Toggles, db:not_in(fried.db.settings_db.Toggles.name, names))
  echo("[ FRIED ] - Feature DB Compaction Complete.\n")
end

registerAnonymousEventHandler("sysExitEvent", compact_featuredb)


function API:iThinkWeFighting()
  -- If we have two prompts with not fight messages its safe to say fighting is over
  PromptCounters.fighting = 2
end

function API:is_connected()
  return Toggles.firstprompt == true
end

function Times:last(name)
  return getStopWatchTime(name)
end

function Times:reset(name)
  resetStopWatch(name)
end

-- Quality Of Life functions
function math.round(x, n)
  return tonumber(string.format("%." .. n .. "f", x))
end

function math.format(i)
  return tostring(i):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

function table.sample_keys(tb)
  local keys = {}
  for k, v in pairs(tb) do
    table.insert(keys, k)
  end
  return keys[math.random(#keys)]
end

function table.sample_items(tl)
  local pos = math.floor(math.random() * #tl) + 1
  return tl[pos]
end

function table.extend(list, items)
  for _, item in ipairs(items) do
    list[#list + 1] = item
  end
end
