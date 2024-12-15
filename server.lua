local function handlePlayerDeath(victimId, killerId)
    local victimName = GetPlayerName(victimId) or "Unknown"
    local killerName = "Environment"

    if killerId and killerId > 0 then
        killerName = GetPlayerName(killerId) or "Unknown"
    elseif killerId == -1 then
        killerName = "Environment"
    end

    TriggerClientEvent('killfeed:display', victimId, killerName, victimName)

    if killerId and killerId > 0 then
        TriggerClientEvent('killfeed:display', killerId, killerName, victimName)
    end
end

RegisterServerEvent('killfeed:playerDied', function(killerId)
    local victimId = source
    if not victimId then return end
    handlePlayerDeath(victimId, killerId)
end)
