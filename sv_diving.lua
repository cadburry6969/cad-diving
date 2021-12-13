QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("cad-diving:collected")
AddEventHandler("cad-diving:collected", function(type, item, count)    
    local xPlayer = QBCore.Functions.GetPlayer(source)    
    if xPlayer ~= nil then      
        if type == "normal" then
            xPlayer.Functions.AddItem(item, count)            
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")        
        elseif type == "rare" then
            xPlayer.Functions.AddItem(item, count)            
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")        
        else
            TriggerClientEvent("QBCore:Notify", source, "You got nothing")
        end
	end
end)