if Bridge.Detected.inventory ~= 'qb-inventory' then return end

Bridge.Inventory = Bridge.Inventory or {}

local function GetPlayer(source)
    return exports['qb-core']:GetCoreObject().Functions.GetPlayer(source)
end

function Bridge.Inventory.HasItem(source, item, count)
    local Player = GetPlayer(source)
    if not Player then return false end
    local inv = Player.Functions.GetItemByName(item)
    return inv and inv.amount >= (count or 1)
end

function Bridge.Inventory.AddItem(source, item, count, metadata)
    local Player = GetPlayer(source)
    if not Player then return false end
    Player.Functions.AddItem(item, count or 1, false, metadata)
    return true
end

function Bridge.Inventory.RemoveItem(source, item, count)
    local Player = GetPlayer(source)
    if not Player then return false end
    return Player.Functions.RemoveItem(item, count or 1)
end

function Bridge.Inventory.GetItem(source, item)
    local Player = GetPlayer(source)
    if not Player then return nil end
    local inv = Player.Functions.GetItemByName(item)
    if not inv then return nil end
    return { count = inv.amount, metadata = inv.info or {} }
end
