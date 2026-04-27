if Bridge.Detected.inventory ~= 'standalone' then return end

Bridge.Inventory = Bridge.Inventory or {}

-- No inventory system: delegate to player wrapper methods set by the framework module.

function Bridge.Inventory.HasItem(source, item, count)
    local player = Bridge.Framework.GetPlayer(source)
    return player and player.hasItem(item, count or 1) or false
end

function Bridge.Inventory.AddItem(source, item, count, metadata)
    local player = Bridge.Framework.GetPlayer(source)
    if not player then return false end
    player.addItem(item, count or 1)
    return true
end

function Bridge.Inventory.RemoveItem(source, item, count)
    local player = Bridge.Framework.GetPlayer(source)
    if not player then return false end
    if not player.hasItem(item, count or 1) then return false end
    player.removeItem(item, count or 1)
    return true
end

function Bridge.Inventory.GetItem(source, item)
    local player = Bridge.Framework.GetPlayer(source)
    if not player then return nil end
    local has = player.hasItem(item, 1)
    return has and { count = 1, metadata = {} } or nil
end
