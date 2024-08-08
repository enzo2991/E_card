function Framework()
    if Config.Framework == 'ESX' then
        ESX = exports['es_extended']:getSharedObject()
        PlayerData = ESX.GetPlayerData()
    elseif Config.Framework == 'QB' then
        QBCore = exports['qb-core']:GetCoreObject()
		QBCore.Functions.GetPlayerData(function(p)
			PlayerData = p
			if PlayerData.job ~= nil then
				PlayerData.job.grade = PlayerData.job.grade.level
			end
        end)
    else
        -- custom
    end
end

function Playerloaded()
	if Config.framework == 'ESX' then
		RegisterNetEvent('esx:playerLoaded')
		AddEventHandler('esx:playerLoaded', function(xPlayer)
			PlayerData = xPlayer
			Playerloaded = true
			TriggerServerEvent('renzu_customs:loaded')
		end)
	elseif Config.framework == 'QBCORE' then
		RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
		AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
			Playerloaded = true
			TriggerServerEvent('renzu_customs:loaded')
			QBCore.Functions.GetPlayerData(function(p)
				PlayerData = p
				if PlayerData.job ~= nil then
					PlayerData.job.grade = PlayerData.job.grade.level
				end
			end)
		end)
	end
end

function SetJob()
	if Config.framework == 'ESX' then
		RegisterNetEvent('esx:setJob')
		AddEventHandler('esx:setJob', function(job)
			PlayerData.job = job
		end)
	elseif Config.framework == 'QBCORE' then
		RegisterNetEvent('QBCore:Client:OnJobUpdate')
		AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
			PlayerData.job = job
			PlayerData.job.grade = PlayerData.job.grade.level
		end)
	end
end