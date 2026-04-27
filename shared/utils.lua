-- ─── Locale helpers ─────────────────────────────────────────────────────────

Bridge.Locale  = Bridge.Locale  or {}
Bridge.Locales = Bridge.Locales or {}

---@param key string
---@param ... any  format args
---@return string
function Bridge.Locale._(key, ...)
    local str = Bridge.Locales and Bridge.Locales[key]
    if not str then
        if Config.Debug then
            print(('[fx_bridge] Missing locale key: %s'):format(key))
        end
        return key
    end
    if select('#', ...) > 0 then
        return str:format(...)
    end
    return str
end

-- Shorthand alias
_  = Bridge.Locale._
_U = function(key, ...) return Bridge.Locale._(key, ...):upper() end

-- ─── String helpers ─────────────────────────────────────────────────────────

---Trim whitespace from both ends of a string.
---@param s string
---@return string
function string.trim(s)
    return s:match('^%s*(.-)%s*$')
end

---Check if a string starts with a prefix.
---@param s string
---@param prefix string
---@return boolean
function string.startsWith(s, prefix)
    return s:sub(1, #prefix) == prefix
end

---Check if a string ends with a suffix.
---@param s string
---@param suffix string
---@return boolean
function string.endsWith(s, suffix)
    return suffix == '' or s:sub(-#suffix) == suffix
end

---Split a string by a separator.
---@param s string
---@param sep string
---@return string[]
function string.split(s, sep)
    local parts = {}
    local pattern = ('([^%s]+)'):format(sep)
    for part in s:gmatch(pattern) do
        parts[#parts + 1] = part
    end
    return parts
end

-- ─── Table helpers ──────────────────────────────────────────────────────────

---Check if a value exists in an array-table.
---@param t table
---@param value any
---@return boolean
function table.contains(t, value)
    for _, v in ipairs(t) do
        if v == value then return true end
    end
    return false
end

---Return a shallow copy of a table.
---@param t table
---@return table
function table.shallowCopy(t)
    local copy = {}
    for k, v in pairs(t) do
        copy[k] = v
    end
    return copy
end

---Merge src into dst (overwrites existing keys).
---@param dst table
---@param src table
---@return table
function table.merge(dst, src)
    for k, v in pairs(src) do
        dst[k] = v
    end
    return dst
end

-- ─── Math helpers ───────────────────────────────────────────────────────────

---Clamp a value between min and max.
---@param value number
---@param min number
---@param max number
---@return number
function math.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

---Round a number to n decimal places.
---@param value number
---@param decimals? integer
---@return number
function math.round(value, decimals)
    local factor = 10 ^ (decimals or 0)
    return math.floor(value * factor + 0.5) / factor
end

-- ─── Plate generation ───────────────────────────────────────────────────────

local LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
local DIGITS  = '0123456789'

---Generate a random plate matching Config.PlateFormat.
---  '1' → random digit   'A' → random uppercase letter
---@return string
function Bridge.GeneratePlate()
    local result = {}
    for i = 1, #Config.PlateFormat do
        local ch = Config.PlateFormat:sub(i, i)
        if ch == '1' then
            result[i] = DIGITS:sub(math.random(1, #DIGITS), math.random(1, #DIGITS))
        elseif ch == 'A' then
            result[i] = LETTERS:sub(math.random(1, #LETTERS), math.random(1, #LETTERS))
        else
            result[i] = ch
        end
    end
    return table.concat(result)
end

-- ─── Debug helper ───────────────────────────────────────────────────────────

---Print only when Config.Debug is true.
function Bridge.Debug(...)
    if Config.Debug then
        print('[fx_bridge]', ...)
    end
end

