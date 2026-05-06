RegisterNetEvent('fx_bridge:client:notify', function(message, type, duration)
    Bridge.UI.Notify(message, type, duration)
end)