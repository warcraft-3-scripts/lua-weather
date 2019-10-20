local utils = require("utils")

local m = {}

-- @type Map<string, weathereffect>
local weather = {}

-- @type Map<string, trigger>
local triggers = {}

local function sun()
  if utils.needLights(weather) then
    weather["sunLights"] = AddWeatherEffect(GetPlayableMapRect(), FourCC('LRaa'))
    EnableWeatherEffect(weather["sunLights"], true)
  end

  DisableTrigger(triggers["sun"])
end

local function moon()
  if utils.needLights(weather) then
    weather["moonLights"] = AddWeatherEffect(GetPlayableMapRect(), FourCC('LRma'))
    EnableWeatherEffect(weather["moonLights"], true)
  end

  DisableTrigger(triggers["moon"])
end

local function createWeatherEffect()
  local rand = GetRandomInt(1, 7);
  local weatherName = ""

  if rand == 1 then
    weatherName = "lightWildWind"
  elseif rand == 2 then
    weatherName = "strongWildWind"
  elseif rand == 3 then
    weatherName = "lightLorderonRain"
  elseif rand == 4 then
    weatherName = "strongLorderonRain"
  elseif rand == 5 then
    weatherName = "lightWhiteFog"
  elseif rand == 6 then
    weatherName = "strongWhiteFog"
  elseif rand == 7 then
    weatherName = "strongWhiteFog"
  end

  weather[weatherName] = AddWeatherEffect(GetPlayableMapRect(), utils.getWeatherId(weatherName))
  EnableWeatherEffect(weather[weatherName], true)

  -- @type timer
  TriggerSleepAction(GetRandomReal(800.00, 4000.00))

  EnableWeatherEffect(weather[weatherName], false)
  TriggerSleepAction(6.00)
  RemoveWeatherEffect(weather[weatherName])

  weather[weatherName] = nil

  return 0
end

local function effects()
  while true do
      TriggerSleepAction(GetRandomReal(160.00, 380.00))

      -- Enable random weather effect
      createWeatherEffect()

      TriggerSleepAction(GetRandomReal(500.00, 2000.00))
  end
end

local function none()
  if weather["sunLights"] ~= nil then
    EnableWeatherEffect(weather["sunLights"], false)
  end
  if weather["moonLights"] ~= nil then
    EnableWeatherEffect(weather["moonLights"], false)
  end

  TriggerSleepAction(10.00)

  if weather["sunLights"] ~= nil then
    RemoveWeatherEffect(weather["sunLights"])
  end
  if weather["moonLights"] ~= nil then
    RemoveWeatherEffect(weather["moonLights"])
  end

  weather["sunLights"] = nil
  weather["moonLights"] = nil
end


function m.init()
  triggers["none"] = CreateTrigger()
  triggers["moon"] = CreateTrigger()
  triggers["sun"] = CreateTrigger()
  triggers["effects"] = CreateTrigger()

  TriggerAddAction(triggers["none"], none)
  TriggerAddAction(triggers["moon"], moon)
  TriggerAddAction(triggers["sun"], sun)
  TriggerAddAction(triggers["effects"], effects)

  -- @type real
  local time = GetTimeOfDay()

  if time >= 7.00 and time <= 19.00 then
    TriggerRegisterTimerEventSingle(triggers["sun"], 0.01)
  elseif time > 19.00 or time < 7.00 then
    TriggerRegisterTimerEventSingle(triggers["moon"], 0.01)
  end

  TriggerRegisterTimerEventSingle(triggers["effects"], 0.01)
  TriggerRegisterGameStateEventTimeOfDay(triggers["none"], EQUAL, 1.45)
  TriggerRegisterGameStateEventTimeOfDay(triggers["none"], EQUAL, 17.45)
  TriggerRegisterGameStateEventTimeOfDay(triggers["sun"], EQUAL, 2.00)
  TriggerRegisterGameStateEventTimeOfDay(triggers["moon"], EQUAL, 22.00)
end

return m
