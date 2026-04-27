if Bridge.Detected.framework ~= 'standalone' then return end

Bridge.ClientFramework = Bridge.ClientFramework or {}

function Bridge.ClientFramework.GetPlayerData()
    return {
        identifier = '',
        name       = GetPlayerName(PlayerId()) or '',
        job        = { name = 'unemployed', grade = 0, label = 'Unemployed' },
        gang       = nil,
        money      = 0,
        metadata   = {},
    }
end

function Bridge.ClientFramework.IsLoaded()
    return true
end

Bridge.Debug('Standalone client framework module loaded')
