-- Open ID card
RegisterServerEvent('jsfour-legitimation:open')
AddEventHandler('jsfour-legitimation:open', function(idCard, targetID)
	local xPlayer = ESX.GetPlayerFromId(targetID)
	if (xPlayer) then
		TriggerClientEvent('jsfour-legitimation:open', xPlayer.source, idCard)
	end
end)

local function createID(player,giveplayer)
    local xPlayer = ESX.GetPlayerFromId(player)
    if xPlayer then
        TriggerClientEvent("otz_client:getIdCard",xPlayer.source,giveplayer)
    end
end

RegisterServerEvent("otz_card:createID")
AddEventHandler("otz_card:createID",function(player)
    createID(player,source)
end)



RegisterNetEvent("otz_client:getIdCard")
AddEventHandler("otz_client:getIdCard",function(mudshot,player)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)
    local metaData = {
        firstname = xPlayer.get("firstName"),
        lastname = xPlayer.get("lastName"),
        dateofbirth = xPlayer.get("dateofbirth"),
        sex = xPlayer.get("sex"),
        height = xPlayer.get("height"),
        mudshot = mudshot
    }
    local success, response = exports.ox_inventory:AddItem(tPlayer.source,"identification",1,metaData)
    if not success then
        -- if no slots are available, the value will be "inventory_full"
        return print(response)
    end
end)