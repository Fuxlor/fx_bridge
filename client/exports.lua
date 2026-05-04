-- ─── Framework ───────────────────────────────────────────────────────────────
exports('GetPlayerData', Bridge.ClientFramework.GetPlayerData)
exports('IsLoaded',      Bridge.ClientFramework.IsLoaded)

-- ─── UI ──────────────────────────────────────────────────────────────────────
exports('Notify',       Bridge.UI.Notify)
exports('DrawText3D',   Bridge.UI.DrawText3D)
exports('StopDrawText3D', Bridge.UI.StopDrawText3D)
exports('ProgressBar',  Bridge.UI.ProgressBar)
exports('ShowHelpText', Bridge.UI.ShowHelpText)
exports('HideHelpText', Bridge.UI.HideHelpText)
exports('ShowTextUI',   Bridge.UI.ShowTextUI)
exports('HideTextUI',   Bridge.UI.HideTextUI)

-- ─── Target ──────────────────────────────────────────────────────────────────
exports('AddBoxZone',         Bridge.Target.AddBoxZone)
exports('AddSphereZone',      Bridge.Target.AddSphereZone)
exports('AddPolyZone',        Bridge.Target.AddPolyZone)
exports('AddTargetEntity',    Bridge.Target.AddTargetEntity)
exports('AddTargetModel',     Bridge.Target.AddTargetModel)
exports('RemoveZone',         Bridge.Target.RemoveZone)
exports('RemoveTargetEntity', Bridge.Target.RemoveTargetEntity)

-- ─── Menu ────────────────────────────────────────────────────────────────────
exports('OpenContext', Bridge.Menu.Context)
exports('OpenInput',   Bridge.Menu.Input)
exports('OpenAlert',   Bridge.Menu.Alert)

-- ─── Vehicle ─────────────────────────────────────────────────────────────────
exports('GetVehicleProps',    Bridge.Vehicle.GetProps)
exports('SetVehicleProps',    Bridge.Vehicle.SetProps)
exports('GetFuel',            Bridge.Vehicle.GetFuel)
exports('SetFuel',            Bridge.Vehicle.SetFuel)
exports('GetEngineHealth',    Bridge.Vehicle.GetEngineHealth)
exports('GetBodyHealth',      Bridge.Vehicle.GetBodyHealth)
exports('SetVehicleHealth',   Bridge.Vehicle.SetHealth)
exports('GeneratePlate',      Bridge.Vehicle.GeneratePlate)
exports('GetEntityFromPlate', Bridge.Vehicle.GetEntityFromPlate)
exports('SpawnVehicle',       Bridge.Vehicle.Spawn)
exports('DeleteVehicle',      Bridge.Vehicle.Delete)

-- ─── Misc ────────────────────────────────────────────────────────────────────
exports('GetDetected', function() return Bridge.Detected end)
exports('Locale',      Bridge.Locale._)
