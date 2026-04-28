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

-- Returns all slots for a given item (with full metadata per slot)
function Bridge.Inventory.GetItemSlots(source, item)
    return exports.ox_inventory:Search(source, 'slots', item) or {}
end

-- Check whether the player has at least one slot matching all filterMeta key/value pairs
function Bridge.Inventory.HasItemWithMeta(source, item, filterMeta)
    local slots = exports.ox_inventory:Search(source, 'slots', item)
    if not slots then return false end
    for _, slot in ipairs(slots) do
        local meta = slot.metadata or {}
        local match = true
        for k, v in pairs(filterMeta) do
            if meta[k] ~= v then match = false; break end
        end
        if match then return true end
    end
    return false
end

-- Remove one unit of item whose metadata matches filterMeta; returns true on success
function Bridge.Inventory.RemoveItemWithMeta(source, item, filterMeta)
    local slots = exports.ox_inventory:Search(source, 'slots', item)
    if not slots then return false end
    for _, slot in ipairs(slots) do
        local meta = slot.metadata or {}
        local match = true
        for k, v in pairs(filterMeta) do
            if meta[k] ~= v then match = false; break end
        end
        if match then
            return exports.ox_inventory:RemoveItem(source, item, 1, nil, slot.slot) ~= false
        end
    end
    return false
end
