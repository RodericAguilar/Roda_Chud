local ped, sleep
local limitador, cinturon = false, false


function Cinturon(ped)
    while true do 
        if cinturon then 
            DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
            DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end

CreateThread(function ()
    while true do 
        sleep = 500
        ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then 
            local vehicle = GetVehiclePedIsUsing(ped)
            local speed = (GetEntitySpeed(vehicle)* 3.6)
            local fuel = GetVehicleFuelLevel(vehicle)
            local position = GetEntityCoords(ped)
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            sleep = 100
            SendNUIMessage({
                action = 'showCarHud';
                speed = speed;
                fuel = fuel;
                sirena = IsVehicleSirenOn(vehicle);
                limitador = limitador;
                cinturon = cinturon;
                streetName = streetName;
            })
        else
            sleep = 1000
            SendNUIMessage({
                action = 'hideCarHud';
            })
        end
        Wait(sleep)
    end
end)


--- Commands ---
if Config.Commands['usekey'] then 
    RegisterKeyMapping(Config.Commands['limitcommand'], 'Put speed limit', 'keyboard', Config.Commands['key'])
end

if Config.Commands['usebeltkey'] then 
    RegisterKeyMapping(Config.Commands['seatbeltcommand'], 'Put Seat Belt', 'keyboard', Config.Commands['keybelt'])
end

RegisterCommand(Config.Commands['limitcommand'], function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)

        if GetPedInVehicleSeat(vehicle, -1) == ped then
            if not limitador then
                local speed = GetEntitySpeed(vehicle)
                SetVehicleMaxSpeed(vehicle,  speed)
                limitador = true
            else
                SetVehicleMaxSpeed(vehicle, maxSpeed)
                limitador = false
            end
        end
    end
end)

RegisterCommand(Config.Commands['seatbeltcommand'], function ()
    local jugador = PlayerPedId()
    if IsPedInAnyVehicle(jugador) then
        if cinturon then 
            cinturon = false
            Cinturon(jugador)
        else
            cinturon = true
            Cinturon(jugador)
        end
    end
end)