RegisterNetEvent('killfeed:display', function(killerName, victimName)
    SendNUIMessage({
        type = 'updateKillfeed',
        killer = killerName or "Unknown",
        victim = victimName or "Unknown"
    })
end)

RegisterNetEvent('killfeed:clear', function()
    SendNUIMessage({ type = 'clearKillfeed' })
end)

-- Handle player death via game event
AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim = data[1]
        local killer = data[2]

        -- Check if the victim is the local player and if they're dead
        if NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(victim) then
            local killerId = -1
            local killerName = "Unknown"

            -- Determine killer information
            if DoesEntityExist(killer) and killer ~= victim then
                if IsPedAPlayer(killer) then
                    local killerPlayerId = NetworkGetPlayerIndexFromPed(killer)
                    if killerPlayerId and killerPlayerId ~= -1 then
                        killerId = GetPlayerServerId(killerPlayerId)
                        killerName = GetPlayerName(killerPlayerId)
                    end
                else
                    killerName = "Environment"
                end
            else
                killerName = "Self-inflicted"
            end

            -- Notify the server about the player's death
            TriggerServerEvent('killfeed:playerDied', killerId)
        end
    end
end)
