-- Loaded last. Validates client framework interface and exposes top-level aliases.

local required = { 'GetPlayerData', 'IsLoaded' }

for _, fn in ipairs(required) do
    if not Bridge.ClientFramework[fn] then
        Bridge.ClientFramework[fn] = function()
            Bridge.Debug('Bridge.ClientFramework.' .. fn .. ' not implemented for: ' .. Bridge.Detected.framework)
            return nil
        end
    end
end

Bridge.GetPlayerData = Bridge.ClientFramework.GetPlayerData
Bridge.IsLoaded      = Bridge.ClientFramework.IsLoaded
