-- Loaded last. No-op stubs for any unimplemented target function.

Bridge.Target = Bridge.Target or {}

local stubs = { 'AddBoxZone', 'AddSphereZone', 'AddPolyZone', 'AddTargetEntity', 'AddTargetModel', 'RemoveZone', 'RemoveTargetEntity' }
for _, fn in ipairs(stubs) do
    if not Bridge.Target[fn] then
        Bridge.Target[fn] = function()
            Bridge.Debug('Bridge.Target.' .. fn .. ' not implemented for target: ' .. Bridge.Detected.target)
        end
    end
end
