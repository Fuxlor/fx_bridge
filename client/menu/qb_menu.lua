if Bridge.Detected.menu ~= 'qb-menu' then return end

Bridge.Menu = Bridge.Menu or {}

function Bridge.Menu.Context(id, title, options, onClose)
    local items = {}
    for _, opt in ipairs(options) do
        items[#items + 1] = {
            header = opt.title,
            txt    = opt.description or '',
            params = { isAction = true, event = opt.onSelect },
        }
    end
    exports['qb-menu']:openMenu(items)
end

function Bridge.Menu.Input(title, fields)
    Bridge.Debug('Input dialog not supported by qb-menu')
    return nil
end

function Bridge.Menu.Alert(title, description, confirmLabel, cancelLabel)
    Bridge.Debug('Alert dialog not supported by qb-menu')
    return false
end
