if Bridge.Detected.fuel ~= 'cdn-fuel' then return end

Bridge.Fuel = Bridge.Fuel or {}

function Bridge.Fuel.Get(vehicle)
    return exports['cdn-fuel']:GetFuel(vehicle)
end

function Bridge.Fuel.Set(vehicle, level)
    exports['cdn-fuel']:SetFuel(vehicle, math.clamp(level, 0.0, 100.0))
end
