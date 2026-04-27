if Bridge.Detected.notify ~= 'ox_lib' then return end

Bridge.UI = Bridge.UI or {}

function Bridge.UI.Notify(message, type, duration)
    lib.notify({ type = type or 'inform', description = message, duration = duration or 4000 })
end

function Bridge.UI.ProgressBar(label, duration, canCancel, onFinish, onCancel)
    lib.progressBar({
        duration     = duration,
        label        = label,
        useWhileDead = false,
        canCancel    = canCancel or false,
    }, function(cancelled)
        if cancelled and onCancel then onCancel()
        elseif not cancelled and onFinish then onFinish() end
    end)
end

function Bridge.UI.ShowTextUI(text, type)
    lib.showTextUI(text, { position = 'right-center' })
end

function Bridge.UI.HideTextUI()
    lib.hideTextUI()
end
