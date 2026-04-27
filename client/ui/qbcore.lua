if Bridge.Detected.notify ~= 'qbcore' then return end

Bridge.UI = Bridge.UI or {}

function Bridge.UI.Notify(message, type, duration)
    local qbType = type == 'success' and 'success'
                or type == 'error'   and 'error'
                or type == 'warning' and 'warning'
                or 'primary'
    TriggerEvent('QBCore:Notify', message, qbType, duration or 4000)
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
