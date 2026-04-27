if Bridge.Detected.framework ~= 'standalone' then return end

-- In standalone mode, player data is minimal — identifier is the license token.
-- Money and inventory are not supported without a framework.

local function GetLicense(source)
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        if id and id:sub(1, 8) == 'license:' then
            return id
        end
    end
    -- Fallback: use the first available identifier
    return GetPlayerIdentifier(source, 0)
end

local function WrapPlayer(source)
    if not source or not GetPlayerName(source) then return nil end

    return {
        source     = source,
        identifier = GetLicense(source),
        name       = GetPlayerName(source),
        job        = { name = 'unemployed', grade = 0, label = 'Unemployed' },
        gang       = { name = 'none',       grade = 0, label = 'None' },
        money      = 0,
        metadata   = {},

        addMoney    = function() end,
        removeMoney = function() end,

        hasItem = function() return false end,
        addItem = function() end,
        removeItem = function() end,

        triggerEvent = function(event, ...)
            TriggerClientEvent(event, source, ...)
        end,

        notify = function(message, type, duration)
            -- Native FiveM subtitle fallback
            TriggerClientEvent('fx_bridge:notify', source, message, type, duration)
        end,
    }
end

Bridge.Framework = Bridge.Framework or {}

function Bridge.Framework.GetPlayer(source)
    return WrapPlayer(source)
end

function Bridge.Framework.GetPlayerFromIdentifier(identifier)
    for _, src in ipairs(GetPlayers()) do
        src = tonumber(src)
        if GetLicense(src) == identifier then
            return WrapPlayer(src)
        end
    end
    return nil
end

function Bridge.Framework.GetIdentifier(source)
    return GetLicense(source)
end

function Bridge.Framework.GetAllPlayers()
    local result = {}
    for _, src in ipairs(GetPlayers()) do
        result[#result + 1] = WrapPlayer(tonumber(src))
    end
    return result
end

Bridge.Debug('Standalone framework module loaded')
