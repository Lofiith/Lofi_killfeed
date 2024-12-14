RegisterNetEvent('killfeed:display')
AddEventHandler('killfeed:display', function(killerName, victimName)
    SendNUIMessage({
        type = 'updateKillfeed',
        killer = killerName,
        victim = victimName
    })
end)

RegisterNetEvent('killfeed:clear')
AddEventHandler('killfeed:clear', function()
    SendNUIMessage({
        type = 'clearKillfeed'
    })
end)
