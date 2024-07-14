
if GetResourceState("es_extended") == 'started' then
    ESX = exports["es_extended"]:getSharedObject()
    Framework = 'esx'

elseif GetResourceState("qb-core") == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = 'qb'

else
    -- add your custom framework
end