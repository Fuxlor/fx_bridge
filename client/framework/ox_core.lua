if Bridge.Detected.framework ~= 'ox_core' then return end

Bridge.ClientFramework = Bridge.ClientFramework or {}

function Bridge.ClientFramework.GetPlayerData()
    local player = exports.ox_core:GetPlayerData()
    if not player then return nil end
    return {
        identifier = player.userId and tostring(player.userId) or '',
        name       = player.name or '',
        job        = player.job or { name = 'unemployed', grade = 0, label = 'Unemployed' },
        gang       = player.group,
        money      = 0, -- ox_core doesn't expose money client-side directly
        metadata   = {},
    }
end

function Bridge.ClientFramework.IsLoaded()
    return exports.ox_core:GetPlayerData() ~= nil
end

Bridge.Debug('ox_core client framework module loaded')
