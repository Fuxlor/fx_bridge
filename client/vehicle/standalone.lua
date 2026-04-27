Bridge.Vehicle = {}

-- ─── Props serialisation ─────────────────────────────────────────────────────

---Capture the full state of a vehicle into a serialisable table.
---@param vehicle integer
---@return table
function Bridge.Vehicle.GetProps(vehicle)
    local mods = {}
    for i = 0, 49 do
        mods[i] = GetVehicleMod(vehicle, i)
    end

    return {
        model          = GetEntityModel(vehicle),
        plate          = GetVehicleNumberPlateText(vehicle),
        plateIndex     = GetVehicleNumberPlateTextIndex(vehicle),
        bodyHealth     = math.floor(GetVehicleBodyHealth(vehicle) + 0.5),
        engineHealth   = math.floor(GetVehicleEngineHealth(vehicle) + 0.5),
        tankHealth     = math.floor(GetVehiclePetrolTankHealth(vehicle) + 0.5),
        fuelLevel      = Bridge.Fuel.Get(vehicle),
        dirtLevel      = GetVehicleDirtLevel(vehicle),
        color1         = { GetVehicleColour(vehicle) },  -- primary
        color2         = select(2, GetVehicleColour(vehicle)), -- not the right way, corrected below
        pearlescentColor = GetVehicleExtraColours(vehicle),
        wheelColor     = select(2, GetVehicleExtraColours(vehicle)),
        wheels         = GetVehicleWheelType(vehicle),
        windowTint     = GetVehicleWindowTint(vehicle),
        neonEnabled    = {
            IsVehicleNeonLightEnabled(vehicle, 0),
            IsVehicleNeonLightEnabled(vehicle, 1),
            IsVehicleNeonLightEnabled(vehicle, 2),
            IsVehicleNeonLightEnabled(vehicle, 3),
        },
        neonColor      = { GetVehicleNeonLightsColour(vehicle) },
        xenon          = IsToggleModOn(vehicle, 22),
        mods           = mods,
        extras         = (function()
            local t = {}
            for i = 0, 14 do
                t[i] = DoesExtraExist(vehicle, i) and IsVehicleExtraTurnedOn(vehicle, i) or nil
            end
            return t
        end)(),
    }
end

-- Correct the two-return GetVehicleColour by capturing separately:
local _origGetProps = Bridge.Vehicle.GetProps
function Bridge.Vehicle.GetProps(vehicle)
    local props = _origGetProps(vehicle)
    local p, s  = GetVehicleColour(vehicle)
    props.color1 = p
    props.color2 = s
    local pearl, wheel = GetVehicleExtraColours(vehicle)
    props.pearlescentColor = pearl
    props.wheelColor       = wheel
    return props
end

---Apply a props table previously captured with GetProps.
---@param vehicle integer
---@param props table
function Bridge.Vehicle.SetProps(vehicle, props)
    if not props then return end

    if props.plate          then SetVehicleNumberPlateText(vehicle, props.plate) end
    if props.plateIndex     then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
    if props.bodyHealth     then SetVehicleBodyHealth(vehicle, props.bodyHealth) end
    if props.engineHealth   then SetVehicleEngineHealth(vehicle, props.engineHealth) end
    if props.tankHealth     then SetVehiclePetrolTankHealth(vehicle, props.tankHealth) end
    if props.fuelLevel      then Bridge.Fuel.Set(vehicle, props.fuelLevel) end
    if props.dirtLevel      then SetVehicleDirtLevel(vehicle, props.dirtLevel) end

    if props.color1 ~= nil and props.color2 ~= nil then
        SetVehicleColour(vehicle, props.color1, props.color2)
    end
    if props.pearlescentColor ~= nil and props.wheelColor ~= nil then
        SetVehicleExtraColours(vehicle, props.pearlescentColor, props.wheelColor)
    end
    if props.wheels         then SetVehicleWheelType(vehicle, props.wheels) end
    if props.windowTint     then SetVehicleWindowTint(vehicle, props.windowTint) end
    if props.xenon          then ToggleVehicleMod(vehicle, 22, props.xenon) end

    if props.neonEnabled then
        for i, v in ipairs(props.neonEnabled) do
            SetVehicleNeonLightEnabled(vehicle, i - 1, v)
        end
    end
    if props.neonColor then
        SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
    end

    if props.mods then
        SetVehicleModKit(vehicle, 0)
        for modType, modIndex in pairs(props.mods) do
            SetVehicleMod(vehicle, tonumber(modType), modIndex, false)
        end
    end

    if props.extras then
        for i, enabled in pairs(props.extras) do
            if enabled ~= nil then
                SetVehicleExtra(vehicle, tonumber(i), enabled and 0 or 1)
            end
        end
    end
end

-- ─── Health helpers ──────────────────────────────────────────────────────────

---@param vehicle integer
---@return number  0 – 1000
function Bridge.Vehicle.GetEngineHealth(vehicle)
    return GetVehicleEngineHealth(vehicle)
end

---@param vehicle integer
---@return number  0 – 1000
function Bridge.Vehicle.GetBodyHealth(vehicle)
    return GetVehicleBodyHealth(vehicle)
end

---@param vehicle integer
---@param engine number  0 – 1000
---@param body number    0 – 1000
function Bridge.Vehicle.SetHealth(vehicle, engine, body)
    if engine then SetVehicleEngineHealth(vehicle, engine) end
    if body   then SetVehicleBodyHealth(vehicle, body) end
end

-- Fuel aliases
Bridge.Vehicle.GetFuel = Bridge.Fuel.Get
Bridge.Vehicle.SetFuel = Bridge.Fuel.Set

-- ─── Plate generation ────────────────────────────────────────────────────────

---Generate a random plate using Config.PlateFormat.
---@return string
Bridge.Vehicle.GeneratePlate = Bridge.GeneratePlate

-- ─── Spawn ───────────────────────────────────────────────────────────────────

---Spawn a vehicle at the given position and apply optional props.
---@param model string|integer  model name or hash
---@param coords vector4|{x,y,z,w}
---@param props? table
---@param onSpawn? function(vehicle: integer)
function Bridge.Vehicle.Spawn(model, coords, props, onSpawn)
    local hash = type(model) == 'number' and model or GetHashKey(model)

    if not IsModelValid(hash) then
        Bridge.Debug('Invalid vehicle model: ' .. tostring(model))
        return
    end

    RequestModel(hash)
    local timeout = GetGameTimer() + 10000
    while not HasModelLoaded(hash) do
        Wait(100)
        if GetGameTimer() > timeout then
            Bridge.Debug('Model load timeout: ' .. tostring(model))
            return
        end
    end

    local veh = CreateVehicle(
        hash,
        coords.x, coords.y, coords.z,
        coords.w or 0.0,
        true, false
    )

    SetModelAsNoLongerNeeded(hash)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetEntityAsMissionEntity(veh, true, true)

    if props then
        Bridge.Vehicle.SetProps(veh, props)
    end

    if onSpawn then onSpawn(veh) end
    return veh
end

---Delete a vehicle entity safely.
---@param vehicle integer
function Bridge.Vehicle.Delete(vehicle)
    if not DoesEntityExist(vehicle) then return end
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteVehicle(vehicle)
end
