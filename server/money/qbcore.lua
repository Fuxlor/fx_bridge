if Bridge.Detected.framework ~= 'qbcore' then return end

Bridge.Money = Bridge.Money or {}

local function GetQB()
    return exports['qb-core']:GetCoreObject()
end

function Bridge.Money.Get(source, account)
    local Player = GetQB().Functions.GetPlayer(source)
    return Player and Player.PlayerData.money[account or 'cash'] or 0
end

function Bridge.Money.GetSociety(society)
    return MySQL.scalar.await('SELECT `money` FROM `player_gangs` WHERE `name` = ?', { society }) or 0
end

function Bridge.Money.AddSociety(society, amount)
    MySQL.update.await('UPDATE `player_gangs` SET `money` = `money` + ? WHERE `name` = ?', { amount, society })
    return true
end

function Bridge.Money.RemoveSociety(society, amount)
    local current = Bridge.Money.GetSociety(society)
    if current < amount then return false end
    MySQL.update.await('UPDATE `player_gangs` SET `money` = `money` - ? WHERE `name` = ?', { amount, society })
    return true
end
