if GetResourceState('es_extended') == "started" then

    
local ped = PlayerPedId()
local radio = false
local timeout = 0

local function GetRealPedHealth(ped)
    return math.floor(GetEntityHealth(ped) - 100) < 0 and 0 or math.floor(GetEntityHealth(ped) - 100)
end

CreateThread(function()
    while true do
        local msec = 1000

        local hunger, thirst
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.val / 10000
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.val / 10000
        end)

        SendNUIMessage({
            action = "HUD",
            vidaa = GetRealPedHealth(PlayerPedId()),
            armaduraa = GetPedArmour(ped),
            comidaa = hunger or 0,
            bebidaa = thirst or 0,
        })

        Wait(msec)
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

AddEventHandler('pma-voice:setTalkingMode', function(newTalkingRange)
    timeout = timeout + 2000
    SendNUIMessage({
        toggleprox = true,
        proximity = newTalkingRange,
        timeout = timeout
    })
end)

AddEventHandler("pma-voice:radioActive", function(radioTalking)
    radio = radioTalking
end)

end