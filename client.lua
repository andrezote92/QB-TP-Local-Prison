local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('jail1', function(source, args, rawCommand) 
    local playerId = tonumber(args[1])
    local time = tonumber(args[2])

    if playerId and time then
        TriggerServerEvent('teleportPlayerToJail', playerId, 'jail1', time)
    else
        print('Uso: /jail1 [ID] [TIEMPO]')
    end
end, false)

RegisterCommand('jail2', function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local time = tonumber(args[2])

    if playerId and time then
        TriggerServerEvent('teleportPlayerToJail', playerId, 'jail2', time)
    else
        print('Uso: /jail2 [ID] [TIEMPO]')
    end
end, false)

RegisterCommand('jail3', function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local time = tonumber(args[2])

    if playerId and time then
        TriggerServerEvent('teleportPlayerToJail', playerId, 'jail3', time)
    else
        print('Uso: /jail3 [ID] [TIEMPO]')
    end
end, false)

RegisterCommand('jail4', function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local time = tonumber(args[2])

    if playerId and time then
        TriggerServerEvent('teleportPlayerToJail', playerId, 'jail4', time)
    else
        print('Uso: /jail4 [ID] [TIEMPO]')
    end
end, false)

RegisterNetEvent('teleportToCoords')
AddEventHandler('teleportToCoords', function(x, y, z)
    local playerPed = GetPlayerPed(-1)
    if playerPed and playerPed ~= -1 then
        SetEntityCoords(playerPed, x, y, z, false, false, false, false)
    end
end)