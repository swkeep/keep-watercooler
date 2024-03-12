--                _
--               | |
--   _____      _| | _____  ___ _ __
--  / __\ \ /\ / / |/ / _ \/ _ \ '_ \
--  \__ \\ V  V /|   <  __/  __/ |_) |
--  |___/ \_/\_/ |_|\_\___|\___| .__/
--                             | |
--                             |_|
-- https://github.com/swkeep
fx_version 'cerulean'
lua54 'yes'
games { 'gta5' }

name 'keep-vendingMachines'
description 'I do not know It is just a vending machine script'
version '1.0.0'
author "swkeep"
repository ''

shared_scripts {
    -- shared config
    'config.shared.lua',
}

client_scripts {
    'client.lua',
}

server_script {
    'server.lua',
}

dependencies {
    '/server:5848',
    '/onesync',
}
