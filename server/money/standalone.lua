if Bridge.Detected.framework ~= 'standalone' then return end

Bridge.Money = Bridge.Money or {}

-- Standalone has no money system — all operations are no-ops returning safe defaults.

function Bridge.Money.Get(source, account)
    return 0
end

function Bridge.Money.GetSociety(society)
    return 0
end

function Bridge.Money.AddSociety(society, amount)
    return false
end

function Bridge.Money.RemoveSociety(society, amount)
    return false
end
