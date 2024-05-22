local ped = PlayerPedId()

local function GetRealPedHealth(ped)
    return math.floor(GetEntityHealth(ped) - 100) < 0 and 0 or math.floor(GetEntityHealth(ped) - 100)
end

CreateThread(function()
    while true do
        local msec = 1000;

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



