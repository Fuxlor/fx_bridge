if Bridge.Detected.framework ~= 'esx' then return end

local ESX = nil

-- ESX triggers a 'esx:getSharedObject' event on ready
AddEventHandler('esx:getSharedObject', function(obj)
    ESX = obj
end)

-- Also try an immediate request (handles cases where esx is already ready)
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local function GetESX()
    if not ESX and exports['es_extended'] then
        ESX = exports['es_extended']:getSharedObject()
    end
    return ESX
end

Bridge.ClientFramework = Bridge.ClientFramework or {}

function Bridge.ClientFramework.GetPlayerData()
    local esx = GetESX()
    if not esx then return nil end
    local xPlayer = esx.GetPlayerData()
    if not xPlayer then return nil end
    return {
        identifier = xPlayer.identifier,
        name       = xPlayer.name,
        job        = {
            name  = xPlayer.job.name,
            grade = xPlayer.job.grade,
            label = xPlayer.job.label,
        },
        gang     = nil,
        money    = xPlayer.money,
        metadata = xPlayer.metadata or {},
    }
end

function Bridge.ClientFramework.IsLoaded()
    local esx = GetESX()
    return esx ~= nil and esx.GetPlayerData() ~= nil
end

Bridge.Debug('ESX client framework module loaded')
