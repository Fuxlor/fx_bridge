if Bridge.Detected.notify ~= 'native' then return end

Bridge.UI = Bridge.UI or {}

function Bridge.UI.Notify(message, type, duration)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, true)
end

function Bridge.UI.ProgressBar(label, duration, canCancel, onFinish, onCancel)
    Bridge.UI._NativeProgressBar(label, duration, canCancel, onFinish, onCancel)
end

function Bridge.UI.ShowTextUI(text, type)
    Bridge.UI.ShowHelpText(text)
end

function Bridge.UI.HideTextUI()
    Bridge.UI.HideHelpText()
end
