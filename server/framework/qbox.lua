if Bridge.Detected.framework ~= 'qbox' then return end

-- QBox (qbx_core) exposes the same API surface as QBCore with minor differences.
local QBX = nil

local function GetQBX()
    if QBX then return QBX end
    if exports['qbx_core'] then
        QBX = exports['qbx_core']:GetCoreObject()
    end
    return QBX
end

local function WrapPlayer(Player)
    if not Player then return nil end
    local src = Player.PlayerData.source

    return {
        source     = src,
        identifier = Player.PlayerData.citizenid,
        name       = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
        job        = {
            name  = Player.PlayerData.job.name,
            grade = Player.PlayerData.job.grade.level,
            label = Player.PlayerData.job.label,
        },
        gang       = {
            name  = Player.PlayerData.gang and Player.PlayerData.gang.name  or 'none',
            grade = Player.PlayerData.gang and Player.PlayerData.gang.grade and Player.PlayerData.gang.grade.level or 0,
            label = Player.PlayerData.gang and Player.PlayerData.gang.label or 'None',
        },
        money      = Player.PlayerData.money['cash'],
        metadata   = Player.PlayerData.metadata or {},

        addMoney = function(amount, account)
            Player.Functions.AddMoney(account or 'cash', amount)
        end,

        removeMoney = function(amount, account)
            Player.Functions.RemoveMoney(account or 'cash', amount)
        end,

        hasItem = function(item, count)
            local inv = Player.Functions.GetItemByName(item)
            return inv and inv.amount >= (count or 1)
        end,

        addItem = function(item, count)
            Player.Functions.AddItem(item, count or 1)
        end,

        removeItem = function(item, count)
            Player.Functions.RemoveItem(item, count or 1)
        end,

        triggerEvent = function(event, ...)
            TriggerClientEvent(event, src, ...)
        end,

        notify = function(message, type, duration)
            TriggerClientEvent('QBCore:Notify', src, message, type or 'primary', duration or 5000)
        end,
    }
end

Bridge.Framework = Bridge.Framework or {}

function Bridge.Framework.GetPlayer(source)
    local qbx = GetQBX()
    if not qbx then return nil end
    return WrapPlayer(qbx.Functions.GetPlayer(source))
end

function Bridge.Framework.GetPlayerFromIdentifier(identifier)
    local qbx = GetQBX()
    if not qbx then return nil end
    return WrapPlayer(qbx.Functions.GetPlayerByCitizenId(identifier))
end

function Bridge.Framework.GetIdentifier(source)
    local qbx = GetQBX()
    if not qbx then return nil end
    local Player = qbx.Functions.GetPlayer(source)
    return Player and Player.PlayerData.citizenid or nil
end

function Bridge.Framework.GetAllPlayers()
    local qbx = GetQBX()
    if not qbx then return {} end
    local result = {}
    for _, Player in pairs(qbx.Functions.GetQBPlayers()) do
        result[#result + 1] = WrapPlayer(Player)
    end
    return result
end

Bridge.Debug('QBox (qbx_core) framework module loaded')
