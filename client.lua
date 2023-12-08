local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('localPrison:client:jailInput', function(nearbyPlayers)
    QBCore.Functions.TriggerCallback('localPrison:server:nearbyPlayers', function(nearbyPlayers)
        if next(nearbyPlayers) ~= nil then
            local cells = {}
            for k in pairs(Config.Cells) do cells[#cells +1] = {value = k, text = 'Cell #'..k} end
            --exports['rpemotes']:EmoteCommandStart('tablet2')
            local dialog = exports['qb-input']:ShowInput({
                header = 'Nearby Citizens',
                submitText = 'Send to Jail',
                inputs = {
                    {
                        text = 'Civilian',
                        name = 'criminal',
                        type = 'select',
                        isRequired = true,
                        options = nearbyPlayers
                    },
                    {
                        text = 'Local Cell',
                        name = 'cell',
                        type = 'select',
                        isRequired = true,
                        options = cells
                    },
                    {
                        text = 'Jail Time (minutes)',
                        name = 'jailTime',
                        type = 'number',
                        isRequired = true,
                        default = 1,
                    },
                },
            })
            if dialog then
                local jailed = {
                    crim = dialog.criminal,
                    cell = dialog.cell,
                    time = dialog.jailTime,
                }
                TriggerServerEvent('localPrison:server:jailPlayer', jailed)
            end
            --exports['rpemotes']:EmoteCancel(true)
        else
            QBCore.Functions.Notify('Nobody nearby to jail', 'error')
        end
    end)
end)

RegisterNetEvent('localPrison:client:sendToCell', function(cell, time)
    local ped = PlayerPedId()
    local x, y, z, h = table.unpack(Config.Cells[cell].inside)
    DoScreenFadeOut(500)
    SetEntityCoords(ped, x, y, z, false, false, true, false)
    SetEntityHeading(ped, w)
    DoScreenFadeIn(1000)

    SetTimeout(time * 60000, function()
        local x, y, z, h = table.unpack(Config.Cells[cell].outside)
        QBCore.Functions.Notify('Your time is up!', 'success')
        DoScreenFadeOut(500)
        SetEntityCoords(ped, x, y, z, false, false, true, false)
        SetEntityHeading(ped, w)
        DoScreenFadeIn(1000)
    end)
end)