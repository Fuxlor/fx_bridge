if Bridge.Detected.inventory ~= 'ox_inventory' then return end

Bridge.Inventory = Bridge.Inventory or {}

function Bridge.Inventory.HasItem(source, item, count)
    local slots = exports.ox_inventory:Search(source, 'slots', item)
    if not slots or #slots == 0 then return false end
    local total = 0
    for _, s in ipairs(slots) do total = total + s.count end
    return total >= (count or 1)
end

function Bridge.Inventory.AddItem(source, item, count, metadata)
    return exports.ox_inventory:AddItem(source, item, count or 1, metadata)
end

function Bridge.Inventory.RemoveItem(source, item, count)
    return exports.ox_inventory:RemoveItem(source, item, count or 1)
end

function Bridge.Inventory.GetItem(source, item)
    local slots = exports.ox_inventory:Search(source, 'slots', item)
    if not slots or #slots == 0 then return nil end
    local total, meta = 0, {}
    for _, s in ipairs(slots) do
        total = total + s.count
        meta  = s.metadata or meta
    end
    return { count = total, metadata = meta }
end
