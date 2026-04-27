-- Loaded last. No-op stubs for any unimplemented menu function.

Bridge.Menu = Bridge.Menu or {}

local stubs = { 'Context', 'Input', 'Alert' }
for _, fn in ipairs(stubs) do
    if not Bridge.Menu[fn] then
        Bridge.Menu[fn] = function()
            Bridge.Debug('Bridge.Menu.' .. fn .. ' not implemented for menu: ' .. Bridge.Detected.menu)
            return nil
        end
    end
end
