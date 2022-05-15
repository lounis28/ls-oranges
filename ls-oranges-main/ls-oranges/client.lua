local QBCore = exports['qb-core']:GetCoreObject()
local CarPed = {
    Config.CarSpawnPed
}
local ProcessPed = {
    Config.ProcessPed
}
local SellPed = {
    Config.SellPed
}



RegisterNetEvent('ls-oranges:client:RetirarVeiculo', function()
    local vehicle = Config.CarName
    local coords = Config.CarSpawnLoc

    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "FARMING"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)  
    QBCore.Functions.Notify('You take out a vehicle!', 'primary', 7500)   
    SetNewWaypoint(Config.OrangesField)
    QBCore.Functions.Notify('Oranges farm field waypoint seted. <br> Lets go work body!', 'primary', 7500)
end)

Citizen.CreateThread(function()
    for _,v in pairs(CarPed) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        CarProcPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(CarProcPed, v[5])
        FreezeEntityPosition(CarProcPed, true)
        SetEntityInvincible(CarProcPed, true)
        SetBlockingOfNonTemporaryEvents(CarProcPed, true)
        TaskStartScenarioInPlace(CarProcPed, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true) 
    end
end)

RegisterNetEvent('ls-oranges:client:GuardarVeiculo', function()
    QBCore.Functions.Notify('Vehicle puted back!')

    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    DeleteVehicle(car)
    DeleteEntity(car)
end)

Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("CarPed", Config.CarPedLoc, 1, 1, {
        name = "CarPed",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "ls-oranges:client:RetirarVeiculo",
                icon = "fas fa-car",
                label = 'Take farm car'
            },
            {
                type = "client",
                event = "ls-oranges:client:GuardarVeiculo",
                icon = "fas fa-car",
                label = 'Put back car'
            },
        },
        distance = 2.5
    })
end)



RegisterNetEvent('ls-oranges:client:ApanharLaranjas', function(data)
    local ped = PlayerPedId()

    QBCore.Functions.Progressbar('pick-fiel', 'PICKING SOME ORANGES...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function()
        ClearPedTasks(ped)
        TriggerServerEvent('ls-oranges:server:ApanharLaranjas')
        SetNewWaypoint(Config.OrangesProcess)
        QBCore.Functions.Notify('You picked some oranges! <br> If you are tired and want to process that shit go to the waypoint on your map.', 'primary', 7500)
    end)
end)

------------------------------
---- Blip ------------

Citizen.CreateThread(function()
    local car = Config.CarPedLoc
	SetBlipSprite(car, 270)
	SetBlipDisplay(car, 4)
	SetBlipScale(car, 0.7)
	SetBlipAsShortRange(car, true)
	SetBlipColour(car, 17)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Oranges Farm")
    EndTextCommandSetBlipName(car)
end)


Citizen.CreateThread(function()
    for _,v in pairs(ProcessPed) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        ProcessProcPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(ProcessProcPed, v[5])
        FreezeEntityPosition(ProcessProcPed, true)
        SetEntityInvincible(ProcessProcPed, true)
        SetBlockingOfNonTemporaryEvents(ProcessProcPed, true)
        TaskStartScenarioInPlace(ProcessProcPed, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true) 
    end 
end)

RegisterNetEvent('ls-oranges:client:ProcessarLaranjas', function(data)
    local ped = PlayerPedId()

    QBCore.Functions.Progressbar('pick-fiel', 'MAKING ORANGE JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function()
        ClearPedTasks(ped)
        TriggerServerEvent('ls-oranges:server:ProcessarLaranjas')
        SetNewWaypoint(Config.OrangesSell)
        QBCore.Functions.Notify('You make some orange juice! <br> If you dont have mora anything to process go to the seted waypoint and sell that shit.', 'primary', 7500)
    end)
end)


Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("ProcessPed", Config.ProcessPedLoc, 1, 1, {
        name = "ProcessPed",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "ls-oranges:client:ProcessarLaranjas",
                icon = "fas fa-wine-bottle",
                label = 'Make Orange Juice'
            },
        },
        distance = 2.5
    })
end)

--------------------------------
---- Sell Ped ------------------

Citizen.CreateThread(function()
    for _,v in pairs(SellPed) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        SellProcPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(SellProcPed, v[5])
        FreezeEntityPosition(SellProcPed, true)
        SetEntityInvincible(SellProcPed, true)
        SetBlockingOfNonTemporaryEvents(SellProcPed, true)
        TaskStartScenarioInPlace(SellProcPed, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true) 
    end 
end)

Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("SellPed", Config.OrangesSell, 1, 1, {
        name = "SellPed",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "ls-oranges:client:VenderSumo",
                icon = "fas fa-wine-bottle",
                label = 'Sell Orange Juice'
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('ls-oranges:client:VenderSumo', function(data)
    local ped = PlayerPedId()

    QBCore.Functions.Progressbar('pick-fiel', 'SELLING ORANGE JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(ped)
        TriggerServerEvent('ls-oranges:server:VenderSumo')
        SetNewWaypoint(Config.OrangesSell)
        QBCore.Functions.Notify('You sell all orange juice, thanks for the work. <br> Now you will need to put this fucking vehicle bakc! THANKS!', 'primary', 7500)
    end)
end)