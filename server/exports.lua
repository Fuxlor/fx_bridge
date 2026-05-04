-- ─── Framework ───────────────────────────────────────────────────────────────
exports('GetPlayer',               Bridge.Framework.GetPlayer)
exports('GetPlayerFromIdentifier', Bridge.Framework.GetPlayerFromIdentifier)
exports('GetIdentifier',           Bridge.Framework.GetIdentifier)
exports('GetAllPlayers',           Bridge.Framework.GetAllPlayers)

-- ─── Money ───────────────────────────────────────────────────────────────────
exports('GetMoney',       Bridge.Money.Get)
exports('AddMoney',       Bridge.Money.Add)
exports('RemoveMoney',    Bridge.Money.Remove)
exports('GetSociety',     Bridge.Money.GetSociety)
exports('AddSociety',     Bridge.Money.AddSociety)
exports('RemoveSociety',  Bridge.Money.RemoveSociety)

-- ─── Jobs ────────────────────────────────────────────────────────────────────
exports('GetJob',  Bridge.Jobs.GetJob)
exports('HasJob',  Bridge.Jobs.HasJob)
exports('GetGang', Bridge.Jobs.GetGang)
exports('HasGang', Bridge.Jobs.HasGang)

-- ─── Inventory ───────────────────────────────────────────────────────────────
exports('HasItem',            Bridge.Inventory.HasItem)
exports('AddItem',            Bridge.Inventory.AddItem)
exports('RemoveItem',         Bridge.Inventory.RemoveItem)
exports('GetItem',            Bridge.Inventory.GetItem)
exports('GetItemSlots',       Bridge.Inventory.GetItemSlots)
exports('HasItemWithMeta',    Bridge.Inventory.HasItemWithMeta)
exports('RemoveItemWithMeta', Bridge.Inventory.RemoveItemWithMeta)

-- ─── DB ──────────────────────────────────────────────────────────────────────
exports('DBQuery',   Bridge.DB.Query)
exports('DBInsert',  Bridge.DB.Insert)
exports('DBUpdate',  Bridge.DB.Update)
exports('DBSingle',  Bridge.DB.Single)
exports('DBScalar',  Bridge.DB.Scalar)
exports('DBPrepare', Bridge.DB.Prepare)
exports('Migrate',   Bridge.DB.Migrate)

-- ─── Logger ──────────────────────────────────────────────────────────────────
exports('Log', Bridge.Logger.Log)

-- ─── Misc ────────────────────────────────────────────────────────────────────
exports('GetDetected',     function() return Bridge.Detected end)
exports('GeneratePlate',   Bridge.GeneratePlate)

-- ─── CL/SV Link ────────────────────────────────────────────────────────────────
exports('Notify', function(player, message, type, duration) TriggerClientEvent('fx_bridge:client:notify', player, message, type, duration) end)
