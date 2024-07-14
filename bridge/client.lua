if GetResourceState("es_extended") == 'started' then
    ESX = exports["es_extended"]:getSharedObject()
    Framework = 'esx'

    RegisterNetEvent("esx:playerLoaded",function(xPlayer)
        ESX.PlayerData = xPlayer
        ESX.PlayerLoaded = true
    end)

    RegisterNetEvent("esx:setJob",function(job)
        ESX.PlayerData.job = job
    end)

elseif GetResourceState("qb-core") == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = 'qb'
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded",function()
        LocalPlayer.state:set('isLoggedIn', true, false)
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload",function()
        LocalPlayer.state:set('isLoggedIn', false, false)
    end)
else
    -- add your custom framework
end