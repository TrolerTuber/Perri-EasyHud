if GetResourceState('qb-core') == "started" then
    QBCore = exports["qb-core"]:GetCoreObject()
    local isLoggedIn = false

    RegisterNetEvent('hud:client:UpdateNeeds') -- Desencadenado en qb-core
    AddEventHandler('hud:client:UpdateNeeds', function(newHunger, newThirst)
        hunger = newHunger
        thirst = newThirst
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload')
    AddEventHandler('QBCore:Client:OnPlayerUnload', function()
        isLoggedIn = false
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        isLoggedIn = true
    end)

    local ped, vidaa, armaduraa, comidaa, bebidaa, Player

    Citizen.CreateThread(function()
        while true do
            if isLoggedIn and not IsPauseMenuActive() then
                ped = PlayerPedId()
                Player = QBCore.Functions.GetPlayerData()
                SendNUIMessage({
                    action = "HUD",
                    vidaa = GetEntityHealth(ped),
                    armaduraa = GetPedArmour(ped),
                    comidaa = hunger,
                    bebidaa = thirst
                })
            end
            Wait(1000)
        end
end)

CreateThread(function()
        while true do
            local playerId = PlayerId()
    
            SendNUIMessage({
                talking = MumbleIsPlayerTalking(playerId),
                radio = radio
            })
    
            Wait(500)
        end
end)
    

    
    AddEventHandler("pma-voice:radioActive", function(radioTalking)
        radio = radioTalking
    end)
end
