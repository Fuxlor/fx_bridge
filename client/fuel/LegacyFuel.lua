if Bridge.Detected.fuel ~= 'LegacyFuel' then return end

Bridge.Fuel = Bridge.Fuel or {}

function Bridge.Fuel.Get(vehicle)
    return exports['LegacyFuel']:GetFuel(vehicle)
end

function Bridge.Fuel.Set(vehicle, level)
    exports['LegacyFuel']:SetFuel(vehicle, math.clamp(level, 0.0, 100.0))
end
