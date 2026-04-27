if Bridge.Detected.menu ~= 'esx' then return end

Bridge.Menu = Bridge.Menu or {}

function Bridge.Menu.Context(id, title, options, onClose)
    if GetResourceState('esx_menu_default') ~= 'started' then
        Bridge.Debug('esx_menu_default not available — Context menu skipped: ' .. id)
        return
    end
    local elements = {}
    for _, opt in ipairs(options) do
        elements[#elements + 1] = { label = opt.title, value = opt }
    end
    exports['esx_menu_default']:Open('default', GetCurrentResourceName(), id, {
        title    = title,
        elements = elements,
    }, function(data, menu)
        local opt = data.current
        if opt and opt.value and opt.value.onSelect then opt.value.onSelect() end
    end, function(data, menu)
        menu:Close()
        if onClose then onClose() end
    end)
end

function Bridge.Menu.Input(title, fields)
    Bridge.Debug('Input dialog not supported by ESX menu')
    return nil
end

function Bridge.Menu.Alert(title, description, confirmLabel, cancelLabel)
    Bridge.Debug('Alert dialog not supported by ESX menu')
    return false
end
