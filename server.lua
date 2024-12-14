RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local victimId = source
    local victimName = GetPlayerName(victimId)

    if data.killedByPlayer then
        local killerId = data.killerServerId
        local killerName = GetPlayerName(killerId)

        -- Send the killfeed update only to the killer and victim
        TriggerClientEvent('killfeed:display', killerId, killerName, victimName)
        TriggerClientEvent('killfeed:display', victimId, killerName, victimName)
    else
        TriggerClientEvent('killfeed:display', victimId, nil, victimName)
    end
end)
