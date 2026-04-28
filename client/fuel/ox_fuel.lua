if Bridge.Detected.fuel ~= 'ox_fuel' then return end

Bridge.Fuel = Bridge.Fuel or {}

function Bridge.Fuel.Get(vehicle)
    return Entity(vehicle).state.fuel
end

function Bridge.Fuel.Set(vehicle, level)
    Entity(vehicle).state.fuel = math.clamp(level, 0.0, 100.0)
end
