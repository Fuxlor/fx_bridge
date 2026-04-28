if Bridge.Detected.framework ~= 'esx' then return end

ESX = exports['es_extended']:getSharedObject()

Bridge.ClientFramework = Bridge.ClientFramework or {}

function Bridge.ClientFramework.GetPlayerData()
    if not ESX then return nil end
    local xPlayer = ESX.GetPlayerData()
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
    return ESX ~= nil and ESX.GetPlayerData() ~= nil
end

Bridge.Debug('ESX client framework module loaded')
