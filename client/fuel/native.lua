if Bridge.Detected.fuel ~= 'none' then return end

Bridge.Fuel = Bridge.Fuel or {}

-- Native GTA fuel level: GetVehicleFuelLevel returns 0–100 already.
function Bridge.Fuel.Get(vehicle)
    return GetVehicleFuelLevel(vehicle)
end

function Bridge.Fuel.Set(vehicle, level)
    SetVehicleFuelLevel(vehicle, math.clamp(level, 0.0, 100.0))
end
