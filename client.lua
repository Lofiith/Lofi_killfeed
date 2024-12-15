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

-- Track player death state
CreateThread(function()
    local isDead = false

    while true do
        Wait(500)

        local playerPed = PlayerPedId()
        local currentlyDead = IsEntityDead(playerPed)

        if currentlyDead and not isDead then
            isDead = true

            local killerPed = GetPedSourceOfDeath(playerPed)
            local killerId, killerName = -1, "Unknown"

            if killerPed and killerPed ~= playerPed then
                if IsPedAPlayer(killerPed) then
                    local killerPlayerId = NetworkGetPlayerIndexFromPed(killerPed)
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

            TriggerServerEvent('killfeed:playerDied', killerId)

        elseif not currentlyDead and isDead then
            isDead = false
        end
    end
end)
