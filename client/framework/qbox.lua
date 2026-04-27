if Bridge.Detected.framework ~= 'qbox' then return end

local QBX = exports['qbx_core']:GetCoreObject()

Bridge.ClientFramework = Bridge.ClientFramework or {}

function Bridge.ClientFramework.GetPlayerData()
    local data = QBX.Functions.GetPlayerData()
    if not data then return nil end
    return {
        identifier = data.citizenid,
        name       = data.charinfo.firstname .. ' ' .. data.charinfo.lastname,
        job        = {
            name  = data.job.name,
            grade = data.job.grade.level,
            label = data.job.label,
        },
        gang       = data.gang and {
            name  = data.gang.name,
            grade = data.gang.grade and data.gang.grade.level or 0,
            label = data.gang.label,
        } or nil,
        money    = data.money and data.money.cash or 0,
        metadata = data.metadata or {},
    }
end

function Bridge.ClientFramework.IsLoaded()
    return QBX.Functions.GetPlayerData() ~= nil
end

Bridge.Debug('QBox client framework module loaded')
