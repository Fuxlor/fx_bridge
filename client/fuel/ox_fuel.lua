if Bridge.Detected.fuel ~= 'ox_fuel' then return end

Bridge.Fuel = Bridge.Fuel or {}

function Bridge.Fuel.Get(vehicle)
    return exports.ox_fuel:GetFuel(vehicle)
end

function Bridge.Fuel.Set(vehicle, level)
    exports.ox_fuel:SetFuel(vehicle, math.clamp(level, 0.0, 100.0))
end
