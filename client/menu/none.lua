if Bridge.Detected.menu ~= 'none' then return end

Bridge.Menu = Bridge.Menu or {}

function Bridge.Menu.Context(id, ...)  Bridge.Debug('No menu system — Context skipped: ' .. id) end
function Bridge.Menu.Input(...)        return nil end
function Bridge.Menu.Alert(...)        return false end
