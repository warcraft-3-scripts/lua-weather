local m = {}

function m.getTableLenght(table)
  local lenght = 0

  for key, value in pairs(table) do
    lenght = lenght + 1
  end

  return lenght
end

function m.removeByValue(table, value)
  if value == nil then
    print("removeByKey error, value is nil")
  end

  for k, v in pairs(table) do
    if (value == v) then
      table[k] = nil
    end
  end
end

function m.findByValue(table, value)
  if value == nil then
    print("removeByKey error, value is nil")
  end

  for k, v in pairs(table) do
    if (value == v) then
      return k
    end
  end
end

function m.needLights(table)
  if table == nil then
    print("print error, table is nil")
    return table
  end

  local rand = GetRandomInt(1, 3)

  if
    rand == 2 and
    table["strongWildWind"] == nil and
    table["strongLorderonRain"] == nil and
    table["lightLorderonRain"] == nil then
      return true
  end

  return false
end

function m.getWeatherId(name)
  if name == nil then
    print("print error, table is nil")
    return 0
  end

  if name == "lightWildWind" then
    return FourCC('WOlw');
  elseif name == "strongWildWind" then
    return FourCC('WOcw');
  elseif name == "lightLorderonRain" then
    return FourCC('RLlr');
  elseif name == "strongLorderonRain" then
    return FourCC('RLhr');
  elseif name == "lightWhiteFog" then
    return FourCC('FDwl');
  elseif name == "strongWhiteFog" then
    return FourCC('FDwh');
  end
end

return m