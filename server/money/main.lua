-- Loaded last. Provides framework-agnostic Add/Remove (delegate to player wrapper)
-- and no-op stubs for any per-framework function that was not implemented.

Bridge.Money = Bridge.Money or {}

function Bridge.Money.Add(source, amount, account)
    local player = Bridge.Framework.GetPlayer(source)
    if not player then return false end
    player.addMoney(amount, account or 'cash')
    return true
end

function Bridge.Money.Remove(source, amount, account)
    local player = Bridge.Framework.GetPlayer(source)
    if not player then return false end
    if Bridge.Money.Get(source, account) < amount then return false end
    player.removeMoney(amount, account or 'cash')
    return true
end

local stubs = { 'Get', 'GetSociety', 'AddSociety', 'RemoveSociety' }
for _, fn in ipairs(stubs) do
    if not Bridge.Money[fn] then
        Bridge.Money[fn] = function()
            Bridge.Debug('Bridge.Money.' .. fn .. ' not implemented for: ' .. Bridge.Detected.framework)
            return 0
        end
    end
end

-- Society alias
Bridge.Society = {
    Get    = Bridge.Money.GetSociety,
    Add    = Bridge.Money.AddSociety,
    Remove = Bridge.Money.RemoveSociety,
}
