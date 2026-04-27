if Bridge.Detected.framework ~= 'ox_core' then return end

Bridge.Money = Bridge.Money or {}

function Bridge.Money.Get(source, account)
    local player = exports.ox_core:GetPlayer(source)
    return player and player.getAccount(account or 'money') or 0
end

function Bridge.Money.GetSociety(society)
    return MySQL.scalar.await('SELECT `balance` FROM `ox_accounts` WHERE `name` = ?', { society }) or 0
end

function Bridge.Money.AddSociety(society, amount)
    MySQL.update.await('UPDATE `ox_accounts` SET `balance` = `balance` + ? WHERE `name` = ?', { amount, society })
    return true
end

function Bridge.Money.RemoveSociety(society, amount)
    local current = Bridge.Money.GetSociety(society)
    if current < amount then return false end
    MySQL.update.await('UPDATE `ox_accounts` SET `balance` = `balance` - ? WHERE `name` = ?', { amount, society })
    return true
end
