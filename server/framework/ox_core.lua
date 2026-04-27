if Bridge.Detected.framework ~= 'ox_core' then return end

local ox = exports.ox_core

local function WrapPlayer(player)
    if not player then return nil end
    local src = player.source

    return {
        source     = src,
        identifier = player.userId and tostring(player.userId) or player.identifier,
        name       = player.name,
        job        = {
            name  = player.get('job') and player.get('job').name  or 'unemployed',
            grade = player.get('job') and player.get('job').grade or 0,
            label = player.get('job') and player.get('job').label or 'Unemployed',
        },
        gang       = {
            name  = player.get('group') and player.get('group').name  or 'none',
            grade = player.get('group') and player.get('group').grade or 0,
            label = player.get('group') and player.get('group').label or 'None',
        },
        money      = player.getAccount and player.getAccount('money') or 0,
        metadata   = {},

        addMoney = function(amount, account)
            player.addAccount(account or 'money', amount)
        end,

        removeMoney = function(amount, account)
            player.removeAccount(account or 'money', amount)
        end,

        hasItem = function(item, count)
            return ox.GetInventoryItems and false or false -- ox_inventory handles this
        end,

        addItem = function(item, count)
            exports.ox_inventory:AddItem(src, item, count or 1)
        end,

        removeItem = function(item, count)
            exports.ox_inventory:RemoveItem(src, item, count or 1)
        end,

        triggerEvent = function(event, ...)
            TriggerClientEvent(event, src, ...)
        end,

        notify = function(message, type, duration)
            -- ox_core triggers ox_lib notify if available
            TriggerClientEvent('ox_lib:notify', src, {
                type        = type or 'inform',
                description = message,
                duration    = duration or 5000,
            })
        end,
    }
end

Bridge.Framework = Bridge.Framework or {}

function Bridge.Framework.GetPlayer(source)
    local player = ox.GetPlayer(source)
    return WrapPlayer(player)
end

function Bridge.Framework.GetPlayerFromIdentifier(identifier)
    local players = ox.GetPlayers()
    for _, src in ipairs(players) do
        local p = ox.GetPlayer(src)
        if p and tostring(p.userId) == tostring(identifier) then
            return WrapPlayer(p)
        end
    end
    return nil
end

function Bridge.Framework.GetIdentifier(source)
    local player = ox.GetPlayer(source)
    return player and tostring(player.userId) or nil
end

function Bridge.Framework.GetAllPlayers()
    local result = {}
    for _, src in ipairs(ox.GetPlayers()) do
        local p = WrapPlayer(ox.GetPlayer(src))
        if p then result[#result + 1] = p end
    end
    return result
end

Bridge.Debug('ox_core framework module loaded')
