fx_version 'cerulean'
game 'gta5'

name        'fx_bridge'
description 'Multi-framework abstraction layer for the FX vehicle management bundle'
version     '1.0.0'
author      'Fuxlor'

lua54 'yes'

optional_dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory',
    'es_extended',
    'qb-core',
    'qbx_core',
    'ox_core',
    'LegacyFuel',
    'cdn-fuel',
    'ps-fuel',
    'ox_fuel',
}

shared_scripts {
    'config.lua',
    'shared/init.lua',
    'shared/utils.lua',
    'shared/locale/fr.lua',
    'shared/locale/en.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/logger.lua',
    'server/db.lua',

    -- Framework
    'server/framework/esx.lua',
    'server/framework/qbcore.lua',
    'server/framework/qbox.lua',
    'server/framework/ox_core.lua',
    'server/framework/standalone.lua',
    'server/framework/main.lua',

    -- Money
    'server/money/esx.lua',
    'server/money/qbcore.lua',
    'server/money/qbox.lua',
    'server/money/ox_core.lua',
    'server/money/standalone.lua',
    'server/money/main.lua',

    -- Inventory
    'server/inventory/ox_inventory.lua',
    'server/inventory/qb_inventory.lua',
    'server/inventory/qs_inventory.lua',
    'server/inventory/esx_inventory.lua',
    'server/inventory/standalone.lua',
    'server/inventory/main.lua',

    'server/exports.lua',
}

client_scripts {
    -- Framework
    'client/framework/esx.lua',
    'client/framework/qbcore.lua',
    'client/framework/qbox.lua',
    'client/framework/ox_core.lua',
    'client/framework/standalone.lua',
    'client/framework/main.lua',

    -- UI / notify
    'client/ui/ox_lib.lua',
    'client/ui/esx.lua',
    'client/ui/qbcore.lua',
    'client/ui/native.lua',
    'client/ui/main.lua',

    -- Target
    'client/target/ox_target.lua',
    'client/target/qb_target.lua',
    'client/target/qtarget.lua',
    'client/target/none.lua',
    'client/target/main.lua',

    -- Menu
    'client/menu/ox_lib.lua',
    'client/menu/qb_menu.lua',
    'client/menu/esx.lua',
    'client/menu/none.lua',
    'client/menu/main.lua',

    -- Fuel
    'client/fuel/ox_fuel.lua',
    'client/fuel/LegacyFuel.lua',
    'client/fuel/cdn_fuel.lua',
    'client/fuel/ps_fuel.lua',
    'client/fuel/native.lua',

    -- Vehicle
    'client/vehicle/standalone.lua',

    'client/exports.lua',
}
