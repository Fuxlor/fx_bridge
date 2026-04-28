if Bridge.Detected.inventory ~= 'esx_inventory' then return end

Bridge.Inventory = Bridge.Inventory or {}

ESX = exports['es_extended']:getSharedObject()

local function GetxPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function Bridge.Inventory.HasItem(source, item, count)
    local xPlayer = GetxPlayer(source)
    if not xPlayer then return false end
    local inv = xPlayer.getInventoryItem(item)
    return inv and inv.count >= (count or 1)
end

function Bridge.Inventory.AddItem(source, item, count, metadata)
    local xPlayer = GetxPlayer(source)
    if not xPlayer then return false end
    xPlayer.addInventoryItem(item, count or 1)
    return true
end

function Bridge.Inventory.RemoveItem(source, item, count)
    local xPlayer = GetxPlayer(source)
    if not xPlayer then return false end
    local inv = xPlayer.getInventoryItem(item)
    if not inv or inv.count < (count or 1) then return false end
    xPlayer.removeInventoryItem(item, count or 1)
    return true
end

function Bridge.Inventory.GetItem(source, item)
    local xPlayer = GetxPlayer(source)
    if not xPlayer then return nil end
    local inv = xPlayer.getInventoryItem(item)
    if not inv or inv.count < 1 then return nil end
    return { count = inv.count, metadata = {} }
end
