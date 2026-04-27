if Bridge.Detected.inventory ~= 'qs-inventory' then return end

Bridge.Inventory = Bridge.Inventory or {}

function Bridge.Inventory.HasItem(source, item, count)
    local amount = exports['qs-inventory']:GetItemTotalAmount(source, item)
    return amount >= (count or 1)
end

function Bridge.Inventory.AddItem(source, item, count, metadata)
    return exports['qs-inventory']:AddItem(source, item, count or 1, false, metadata)
end

function Bridge.Inventory.RemoveItem(source, item, count)
    return exports['qs-inventory']:RemoveItem(source, item, count or 1)
end

function Bridge.Inventory.GetItem(source, item)
    local amount = exports['qs-inventory']:GetItemTotalAmount(source, item)
    if not amount or amount < 1 then return nil end
    return { count = amount, metadata = {} }
end
