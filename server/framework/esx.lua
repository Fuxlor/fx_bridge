if Bridge.Detected.framework ~= 'esx' then return end

ESX = exports['es_extended']:getSharedObject()

-- ─── Player object factory ───────────────────────────────────────────────────

---Build a standardised Bridge player from an ESX xPlayer.
---@param xPlayer table  ESX player object
---@return BridgePlayer
local function WrapPlayer(xPlayer)
    if not xPlayer then return nil end

    return {
        source     = xPlayer.source,
        identifier = xPlayer.identifier,
        name       = xPlayer.getName(),
        job        = {
            name   = xPlayer.job.name,
            grade  = xPlayer.job.grade,
            label  = xPlayer.job.label,
        },
        gang       = nil, -- ESX has no native gang system
        money      = xPlayer.getMoney(),
        metadata   = xPlayer.metadata or {},

        -- Methods --

        addMoney = function(amount, account)
            if account and account ~= 'cash' then
                xPlayer.addAccountMoney(account, amount)
            else
                xPlayer.addMoney(amount)
            end
        end,

        removeMoney = function(amount, account)
            if account and account ~= 'cash' then
                xPlayer.removeAccountMoney(account, amount)
            else
                xPlayer.removeMoney(amount)
            end
        end,

        hasItem = function(item, count)
            local inv = xPlayer.getInventoryItem(item)
            return inv and inv.count >= (count or 1)
        end,

        addItem = function(item, count)
            xPlayer.addInventoryItem(item, count or 1)
        end,

        removeItem = function(item, count)
            xPlayer.removeInventoryItem(item, count or 1)
        end,

        triggerEvent = function(event, ...)
            TriggerClientEvent(event, xPlayer.source, ...)
        end,

        notify = function(message, type, duration)
            TriggerClientEvent('esx:showNotification', xPlayer.source, message)
        end,
    }
end

-- ─── Framework interface ─────────────────────────────────────────────────────

Bridge.Framework = Bridge.Framework or {}

function Bridge.Framework.GetPlayer(source)
    return WrapPlayer(ESX.GetPlayerFromId(source))
end

function Bridge.Framework.GetPlayerFromIdentifier(identifier)
    local xPlayers = ESX.GetExtendedPlayers()
    for _, xPlayer in ipairs(xPlayers) do
        if xPlayer.identifier == identifier then
            return WrapPlayer(xPlayer)
        end
    end
    return nil
end

function Bridge.Framework.GetIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer and xPlayer.identifier or nil
end

function Bridge.Framework.GetAllPlayers()
    local result = {}
    for _, xPlayer in ipairs(ESX.GetExtendedPlayers()) do
        result[#result + 1] = WrapPlayer(xPlayer)
    end
    return result
end

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    TriggerEvent('fx:playerLoaded')
end)

AddEventHandler('esx:setJob', function(source, job, lastjob)
    TriggerEvent('fx:setJob', source, job, lastjob)
end)

Bridge.Debug('ESX framework module loaded')
