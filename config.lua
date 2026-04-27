Config = {}

-- Framework : 'auto' | 'esx' | 'qbcore' | 'qbox' | 'ox_core' | 'standalone'
Config.Framework = 'auto'

-- Inventory : 'auto' | 'ox_inventory' | 'qb-inventory' | 'qs-inventory' | 'esx_inventory' | 'standalone'
Config.Inventory = 'auto'

-- Target system : 'auto' | 'ox_target' | 'qb-target' | 'qtarget' | 'none'
Config.Target = 'auto'

-- Menu system : 'auto' | 'ox_lib' | 'esx' | 'qb-menu' | 'none'
Config.Menu = 'auto'

-- Notify system : 'auto' | 'ox_lib' | 'esx' | 'qbcore' | 'native'
Config.Notify = 'auto'

-- Fuel system : 'auto' | 'ox_fuel' | 'LegacyFuel' | 'cdn-fuel' | 'ps-fuel' | 'none'
Config.Fuel = 'auto'

-- Locale : 'fr' | 'en'
Config.Locale = 'fr'

Config.Debug = false

-- Plate generation format — '1' = digit, 'A' = letter
Config.PlateFormat = '11AAA111'

Config.Webhooks = {
    enabled  = false,
    default  = '',
    avatar   = '',
    username = 'FX Bundle',
    categories = {
        vehicle = '',
        garage  = '',
        dealer  = '',
        keys    = '',
    },
}
