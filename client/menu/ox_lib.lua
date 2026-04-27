if Bridge.Detected.menu ~= 'ox_lib' then return end

Bridge.Menu = Bridge.Menu or {}

function Bridge.Menu.Context(id, title, options, onClose)
    lib.registerContext({ id = id, title = title, options = options, onExit = onClose })
    lib.showContext(id)
end

function Bridge.Menu.Input(title, fields)
    local rows = {}
    for i, f in ipairs(fields) do
        rows[i] = { type = f.type or 'input', label = f.label, placeholder = f.placeholder, default = f.default, required = f.required }
    end
    local result = lib.inputDialog(title, rows)
    if not result then return nil end
    local out = {}
    for i, f in ipairs(fields) do out[f.label] = result[i] end
    return out
end

function Bridge.Menu.Alert(title, description, confirmLabel, cancelLabel)
    local result = lib.alertDialog({ header = title, content = description, centered = true, cancel = true })
    return result == 'confirm'
end
