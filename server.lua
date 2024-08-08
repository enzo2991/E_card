RegisterNetEvent("otz_client:getIdCard")
AddEventHandler("otz_client:getIdCard",function()
    local _source = source
    if Config.Framework == 'ESX' then
        local xPlayer = ESX.GetPlayerFromId(_source)
        local metaData = {
            firstname = xPlayer.get("firstName"),
            lastname = xPlayer.get("lastName"),
            dateofbirth = xPlayer.get("dateofbirth"),
            sex = xPlayer.get("sex"),
            height = xPlayer.get("height"),
        }
        local success, response = exports.ox_inventory:AddItem(xPlayer.source,"identification",1,metaData)
        if not success then
            -- if no slots are available, the value will be "inventory_full"
            return print(response)
        end
    elseif Framework == 'QB' then
    else
        -- custom framework
    end
end)