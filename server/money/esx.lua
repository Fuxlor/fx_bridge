if Bridge.Detected.framework ~= 'esx' then return end

Bridge.Money = Bridge.Money or {}

local function GetESX()
    return exports['es_extended']:getSharedObject()
end

function Bridge.Money.Get(source, account)
    local xPlayer = GetESX().GetPlayerFromId(source)
    if not xPlayer then return 0 end
    if not account or account == 'cash' then
        return xPlayer.getMoney()
    end
    local acc = xPlayer.getAccount(account)
    return acc and acc.money or 0
end

function Bridge.Money.GetSociety(society)
    if GetResourceState('esx_addonaccount') ~= 'started' then return 0 end
    local account = exports['esx_addonaccount']:getSharedAccount(society)
    return account and account.money or 0
end

function Bridge.Money.AddSociety(society, amount)
    if GetResourceState('esx_addonaccount') ~= 'started' then return false end
    exports['esx_addonaccount']:getSharedAccount(society).addMoney(amount)
    return true
end

function Bridge.Money.RemoveSociety(society, amount)
    if GetResourceState('esx_addonaccount') ~= 'started' then return false end
    local account = exports['esx_addonaccount']:getSharedAccount(society)
    if not account or account.money < amount then return false end
    account.removeMoney(amount)
    return true
end
