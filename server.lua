local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = {}

RegisterServerEvent('teleportPlayerToJail')
AddEventHandler('teleportPlayerToJail', function(playerId, cmd, time)
    local x, y, z, heading = 0, 0, 0, 0 -- Coordenadas iniciales (se sobrescribirán)
    local x2, y2, z2, heading2 = 0, 0, 0, 0 -- Coordenadas después de 'time' segundos

    if cmd == 'jail1' then
        x, y, z, heading = -429.69, 6001.41, 31.72, 131.24 -- Coordenadas jail1  
        x2, y2, z2, heading2 = -438.07, 6018.17, 31.49, 317.68 -- Coordenadas después de 'time' segundos vector4()
    elseif cmd == 'jail2' then
        x, y, z, heading = -426.59, 5998.07, 31.72, 132.37 -- Coordenadas jail2
        x2, y2, z2, heading2 = -465.31, 6042.85, 31.34, 0 -- Coordenadas después de 'time' segundos
    elseif cmd == 'jail3' then
        x, y, z, heading = 1845.41, 3684.74, 34.26, 299.21 -- Coordenadas jail3
        x2, y2, z2, heading2 = 1854.21, 3681.02, 34.27, 220.34 -- Coordenadas después de 'time' segundos
    elseif cmd == 'jail4' then
        x, y, z, heading = 1843.71, 3687.82, 34.26, 304.08 -- Coordenadas jail4
        x2, y2, z2, heading2 = 1854.21, 3681.02, 34.27, 220.34 -- Coordenadas después de 'time' segundos
    else
        print(('Comando desconocido: %s'):format(cmd))
        return
    end

    if time > 0 then
        print(('Jugador %s teletransportado a la coordenada %s por %s segundos.'):format(playerId, cmd, time))
        TriggerClientEvent('teleportToCoords', playerId, x, y, z)
        Citizen.Wait(time * 100000) -- Esperar 'time' segundos en milisegundos
        print(('Tiempo cumplido. Jugador %s teletransportado a la siguiente coordenada.'):format(playerId))
        TriggerClientEvent('teleportToCoords', playerId, x2, y2, z2)
    else
        print(('Error: El tiempo debe ser mayor que cero para el jugador %s.'):format(playerId))
    end
end)