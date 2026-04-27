Bridge = {}

-- Detection results — filled below, readable by all scripts via Bridge.Detected
Bridge.Detected = {
    framework = 'standalone',
    inventory = 'standalone',
    target    = 'none',
    menu      = 'none',
    notify    = 'native',
    fuel      = 'none',
    keys      = 'none',
}

-- ─── Framework detection ────────────────────────────────────────────────────

local function DetectFramework()
    if Config.Framework ~= 'auto' then
        return Config.Framework
    end

    -- ox_core must be checked before ESX (it can coexist with es_extended remnants)
    if GetResourceState('ox_core') == 'started' then
        return 'ox_core'
    elseif GetResourceState('qbx_core') == 'started' then
        return 'qbox'
    elseif GetResourceState('qb-core') == 'started' then
        return 'qbcore'
    elseif GetResourceState('es_extended') == 'started' then
        return 'esx'
    end

    return 'standalone'
end

-- ─── Inventory detection ────────────────────────────────────────────────────

local function DetectInventory()
    if Config.Inventory ~= 'auto' then
        return Config.Inventory
    end

    if GetResourceState('ox_inventory') == 'started' then
        return 'ox_inventory'
    elseif GetResourceState('qs-inventory') == 'started' then
        return 'qs-inventory'
    elseif GetResourceState('qb-inventory') == 'started' then
        return 'qb-inventory'
    elseif GetResourceState('esx_inventoryhud') == 'started' then
        return 'esx_inventory'
    end

    return 'standalone'
end

-- ─── Target detection ───────────────────────────────────────────────────────

local function DetectTarget()
    if Config.Target ~= 'auto' then
        return Config.Target
    end

    if GetResourceState('ox_target') == 'started' then
        return 'ox_target'
    elseif GetResourceState('qb-target') == 'started' then
        return 'qb-target'
    elseif GetResourceState('qtarget') == 'started' then
        return 'qtarget'
    end

    return 'none'
end

-- ─── Menu detection ─────────────────────────────────────────────────────────

local function DetectMenu()
    if Config.Menu ~= 'auto' then
        return Config.Menu
    end

    if GetResourceState('ox_lib') == 'started' then
        return 'ox_lib'
    elseif GetResourceState('qb-menu') == 'started' then
        return 'qb-menu'
    end

    -- ESX has built-in menu
    if Bridge.Detected.framework == 'esx' then
        return 'esx'
    end

    return 'none'
end

-- ─── Notify detection ───────────────────────────────────────────────────────

local function DetectNotify()
    if Config.Notify ~= 'auto' then
        return Config.Notify
    end

    if GetResourceState('ox_lib') == 'started' then
        return 'ox_lib'
    end

    local fw = Bridge.Detected.framework
    if fw == 'esx' then
        return 'esx'
    elseif fw == 'qbcore' or fw == 'qbox' then
        return 'qbcore'
    end

    return 'native'
end

-- ─── Fuel detection ─────────────────────────────────────────────────────────

local function DetectFuel()
    if Config.Fuel ~= 'auto' then
        return Config.Fuel
    end

    if GetResourceState('ox_fuel') == 'started' then
        return 'ox_fuel'
    elseif GetResourceState('cdn-fuel') == 'started' then
        return 'cdn-fuel'
    elseif GetResourceState('ps-fuel') == 'started' then
        return 'ps-fuel'
    elseif GetResourceState('LegacyFuel') == 'started' then
        return 'LegacyFuel'
    end

    return 'none'
end

-- ─── Run all detections ─────────────────────────────────────────────────────

Bridge.Detected.framework = DetectFramework()
Bridge.Detected.inventory  = DetectInventory()
Bridge.Detected.target     = DetectTarget()
Bridge.Detected.menu       = DetectMenu()
Bridge.Detected.notify     = DetectNotify()
Bridge.Detected.fuel       = DetectFuel()

if Config.Debug then
    print(('[fx_bridge] Framework: %s | Inventory: %s | Target: %s | Menu: %s | Notify: %s | Fuel: %s'):format(
        Bridge.Detected.framework,
        Bridge.Detected.inventory,
        Bridge.Detected.target,
        Bridge.Detected.menu,
        Bridge.Detected.notify,
        Bridge.Detected.fuel
    ))
end
