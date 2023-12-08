fx_version 'cerulean'
game 'gta5'

author 'TuNombre'
description 'Sistema de teletransportación para el job de policía en QbCore'
version '1.0.0'

client_script 'client.lua'
server_script {
    '@qb-core/import.lua',
    'server.lua'
}
