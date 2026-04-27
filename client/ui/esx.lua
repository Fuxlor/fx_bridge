if Bridge.Detected.notify ~= 'esx' then return end

Bridge.UI = Bridge.UI or {}

function Bridge.UI.Notify(message, type, duration)
    TriggerEvent('esx:showNotification', message)
end

function Bridge.UI.ProgressBar(label, duration, canCancel, onFinish, onCancel)
    -- ESX has no built-in progress bar — use the native fallback defined in main.lua
    Bridge.UI._NativeProgressBar(label, duration, canCancel, onFinish, onCancel)
end

function Bridge.UI.ShowTextUI(text, type)
    Bridge.UI.ShowHelpText(text)
end

function Bridge.UI.HideTextUI()
    Bridge.UI.HideHelpText()
end
