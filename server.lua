local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('localPrison:server:nearbyPlayers', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local nearbyPlayers = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local nPlayer = QBCore.Functions.GetPlayer(v)
        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(v))) < 5 then
            if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(v))) ~= 0 then
                nearbyPlayers[#nearbyPlayers+1] = {
                    value = v,
                    text = nPlayer.PlayerData.charinfo.firstname..' ' ..nPlayer.PlayerData.charinfo.lastname,
                }
            end
        end
    end
    cb(nearbyPlayers)
end)

QBCore.Commands.Add('localJail', 'Place player in local cell', {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.onduty then
        TriggerClientEvent('localPrison:client:jailInput', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Only LEO jobs can use this command', 'error')
    end
end)

RegisterServerEvent('localPrison:server:jailPlayer', function(jailed)
    local src = source
    local crim = tonumber(jailed.crim)
    local cell = tonumber(jailed.cell)
    local time = tonumber(jailed.time)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local OtherPlayer = QBCore.Functions.GetPlayer(crim)
    if not OtherPlayer then return end
    local otherName = OtherPlayer.PlayerData.charinfo.firstname..' ' ..OtherPlayer.PlayerData.charinfo.lastname

    local currentDate = os.date('*t')
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    OtherPlayer.Functions.SetMetaData('injail', time)
    OtherPlayer.Functions.SetMetaData('criminalrecord', {
        ['hasRecord'] = true,
        ['date'] = currentDate
    })
    TriggerClientEvent('localPrison:client:sendToCell', OtherPlayer.PlayerData.source, cell, time)
    TriggerClientEvent('QBCore:Notify', src, otherName .. ' has been sent to Cell #' .. cell .. ' for ' .. time .. ' minutes.')
end)