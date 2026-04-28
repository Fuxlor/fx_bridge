-- Loaded last. No-op stubs for any function not implemented by the detected inventory module.

Bridge.Inventory = Bridge.Inventory or {}

local stubs = { 'HasItem', 'AddItem', 'RemoveItem', 'GetItem', 'GetItemSlots', 'HasItemWithMeta', 'RemoveItemWithMeta' }
for _, fn in ipairs(stubs) do
    if not Bridge.Inventory[fn] then
        Bridge.Inventory[fn] = function()
            Bridge.Debug('Bridge.Inventory.' .. fn .. ' not implemented for: ' .. Bridge.Detected.inventory)
            return nil
        end
    end
end
