QBCore = exports['qb-core']:GetCoreObject()

local locations = {
    [1] = {x = 3144.94, y = -280.54, z = -10.31},
    [2] = {x = 3151.75, y = -286.02, z = -27.16},
    [3] = {x = 3127.14, y = -341.26, z = -23.14},
    [4] = {x = 3162.18, y = -357.39, z = -27.6},
    [5] = {x = 3195.47, y = -388.18, z = -32.16},
    [6] = {x = 3188.67, y = -395.82, z = -27.51},
    [7] = {x = 3221.45, y = -405.6, z = -48.48},
    [8] = {x = 3192.30, y = -385.23, z = -16.81},
}

local normal = {
    [1] = {item = 'steel'},    
    [2] = {item = 'iron'},
    [3] = {item = 'plastic'},    
}

local rare = {
    [1] = {item = 'goldbar'},
    [2] = {item = 'diamond'},
}

local pickup = math.random(1, #locations)
local lastpick = 0

Citizen.CreateThread(function() 
    Wait(1000)   
    CreateBlip()
	while true do        
        inRange = false
        x = locations[pickup].x
        y = locations[pickup].y
        z = locations[pickup].z
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = #(vector3(coords.x, coords.y, coords.z) - vector3(x, y, z))
        if distance < 250 then            
            inRange = true            
            if distance > 3 then
                QBCore.Functions.DrawText3D(x, y, z, "Distance: "..(math.floor(distance*10)/10).."m")
            else          
                lastpick = pickup      
                pickup = math.random(1, #locations)
                local random = math.random(1, 100)                                                
                if random > 0 and random < 60 then
                    TriggerServerEvent("cad-diving:collected", "normal", normal[math.random(1,#normal)].item, math.random(1, 4))                
                elseif random > 95 and random < 100 then
                    TriggerServerEvent("cad-diving:collected", "rare", rare[math.random(1,#rare)].item, 1)
                else
                    TriggerServerEvent("cad-diving:collected", "none", nil)
                end
                Citizen.Wait(2000)                
            end
		end
        if inRange then
            Citizen.Wait(4)
        else
            Citizen.Wait(2000)
        end
	end
end)

function CreateBlip()
    local divingblip = AddBlipForCoord(3146.24, -280.84, -8.44)
    SetBlipSprite(divingblip, 465)
    SetBlipDisplay(diving, 4)
    SetBlipScale(divingblip, 0.9)
    SetBlipColour(divingblip, 3)
    SetBlipAsShortRange(divingblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Sunken Ship')
    EndTextCommandSetBlipName(divingblip)
end