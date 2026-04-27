if Bridge.Detected.fuel ~= 'ps-fuel' then return end

Bridge.Fuel = Bridge.Fuel or {}

function Bridge.Fuel.Get(vehicle)
    return exports['ps-fuel']:GetFuel(vehicle)
end

function Bridge.Fuel.Set(vehicle, level)
    exports['ps-fuel']:SetFuel(vehicle, math.clamp(level, 0.0, 100.0))
end
