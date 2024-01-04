local cardOpen = false
local ox_target = exports.ox_target
local imageBase64
local img_txd = nil
local img_tex = nil

RegisterNetEvent("esx:playerLoaded",function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("esx:setjob",function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do
        Citizen.Wait(0)
    end
    exports.ox_inventory:displayMetadata({
        firstname = "Prénom",
        lastname = "Nom",
        dateofbirth = "Date de naissance",
        sex = "Sexe",
        height = "taille",
        handler = "tete"
    })
end)

-- Servern callback
RegisterNetEvent('jsfour-legitimation:open')
AddEventHandler('jsfour-legitimation:open', function(playerData)
	cardOpen = true
    imageBase64 = playerData.mudshot
    img_txd = CreateRuntimeTxd("img_txd")
    img_tex = CreateRuntimeTextureFromImage(img_txd,"img_tex",imageBase64)
	SendNUIMessage({
		action = "open",
		array = playerData
	})
end)

--ImG the ID card

Citizen.CreateThread(function()
	local x, y = GetActiveScreenResolution()
    if x == 2560 and y == 1440 then
        posx, posy = 0.83, 0.22
        width, height = 0.05, 0.098
    elseif x == 1920 and y == 1080 then
        posx, posy = 0.773, 0.29
        width, height = 0.06, 0.14
    elseif x == 1366 and y == 768 then
        posx, posy = 0.687, 0.363
        width, height = 0.1, 0.215
    elseif x == 1360 and y == 768 then
        posx, posy = 0.687, 0.363
        width, height = 0.1, 0.215
    elseif x == 1600 and y == 900 then
        posx, posy = 0.730, 0.309
        width, height = 0.08, 0.180
    elseif x == 1400 and y == 1050 then
        posx, posy = 0.694, 0.267
        width, height = 0.083, 0.145
    elseif x == 1440 and y == 900 then
        posx, posy = 0.702, 0.312
        width, height = 0.082, 0.169
    elseif x == 1680 and y == 1050 then
        posx, posy = 0.745, 0.268
        width, height = 0.068, 0.1435
    elseif x == 1280 and y == 720 then
        posx, posy = 0.665, 0.3905
        width, height = 0.09, 0.2105
    elseif x == 1280 and y == 768 then
        posx, posy = 0.665, 0.366
        width, height = 0.091, 0.196
    elseif x == 1280 and y == 800 then
        posx, posy = 0.665, 0.3515
        width, height = 0.091, 0.1895
    elseif x == 1280 and y == 960 then
        posx, posy = 0.665, 0.2925
        width, height = 0.091, 0.1585
    elseif x == 1280 and y == 1024 then
        posx, posy = 0.665, 0.2745
        width, height = 0.091, 0.1475
    elseif x == 1024 and y == 768 then
        posx, posy = 0.5810, 0.366
        width, height = 0.115, 0.1965
    elseif x == 800 and y == 600 then
        posx, posy = 0.4635, 0.4685
        width, height = 0.1455, 0.251
    elseif x == 1152 and y == 864 then
        posx, posy = 0.6275, 0.325
        width, height = 0.1005, 0.175
    elseif x == 1280 and y == 600 then
        posx, posy = 0.665, 0.468
        width, height = 0.0905, 0.251
    end
end)

-- Close the ID card
-- Key events
Citizen.CreateThread(function()
	while true do
		if IsControlPressed(0, 322) or IsControlPressed(0, 177) and cardOpen then
			SendNUIMessage({
				action = "close"
			})
			cardOpen = false
            		img_tex = nil
            		img_txd = nil
            		imageBase64= nil
		end
        if cardOpen then
            -- print(img_tex)
            DrawSprite("img_txd" , "img_tex", posx, posy, width, height, 0.0, 255, 255, 255, 1000)
        end
        Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do
        local idCard = {}
        local countIdCard = exports.ox_inventory:Search('count', Config.item)
        if countIdCard > 0 then
            local itemsIdCard = exports.ox_inventory:Search('slots', Config.item)
            for k,i in pairs(itemsIdCard) do
                idCard[#idCard+1] = {
                                name = 'ox_card:action:ShowCard'..k,
                                icon = 'fa-solid fa-people-arrows',
                                label = "Montrer la carte d'identité de "..i.metadata.firstname.." "..i.metadata.lastname,
                                canInteract = function(entity, distance)
                                    local playerPed = PlayerPedId()
                                    if IsPedFatallyInjured(playerPed) or IsPedCuffed(playerPed) or IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) or IsEntityPlayingAnim(playerPed, 'missminuteman_1ig_2', 'handsup_base', 3) or IsEntityPlayingAnim(playerPed, 'missminuteman_1ig_2', 'handsup_enter', 3) or IsEntityPlayingAnim(playerPed, 'random@mugging3', 'handsup_standing_base', 3) then return end
                                    if IsPedAPlayer(entity) and distance < 2.0 then
                                        return true
                                    end
                                    return false
                                end,
                                onSelect = function(data)
                                    local TargetID = NetworkGetPlayerIndexFromPed(data.entity)
                                    TriggerServerEvent("jsfour-legitimation:open", i.metadata, GetPlayerServerId(TargetID))
                                end}
            end
            ox_target:addGlobalPlayer(idCard)
            Citizen.Wait(2000)
            for k,v in pairs(idCard) do
                ox_target:removeGlobalPlayer('ox_card:action:ShowCard'..k)
            end
        end
        Citizen.Wait(2000)
    end
end)

RegisterNetEvent("otz_client:getIdCard")
AddEventHandler("otz_client:getIdCard",function(player)
    TriggerServerEvent("otz_client:getIdCard",exports["MugShotBase64"]:GetMugShotBase64(PlayerPedId(),false),player)
end)

exports("OpenCardID",function (slot, itemdata)
    TriggerEvent("jsfour-legitimation:open",itemdata.metadata)
end)

ox_target:addGlobalPlayer({
    name = 'ox_client:action:createIdCard',
    icon = 'fa-solid fa-id-card',
    label = "creer la carte d'identité",
    canInteract = function(entity, distance)
        if ESX.PlayerData.job.name == Config.job then
            if IsPedCuffed(PlayerPedId()) or IsPedCuffed(entity) then return end
            if IsPedAPlayer(entity) and distance < 4.0 then
                local coordsplayer = GetEntityCoords(entity)
                if #(coordsplayer - Config.zoneIdCard) < 2.0 then
                    return true
                end
            end
        end
        return false
    end,
    onSelect = function(data)
        local TargetID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
        TriggerServerEvent("otz_card:createID",TargetID)
    end
})
