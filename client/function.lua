local function loadTarget(ped)
    if Config.target then
        if ped then
            exports.ox_target:addLocalEntity(ped,{
                name = 'e_card:createCardPed',
                label = '📸 '..Translate('createCard'),
                distance = 2.0,
                onSelect = function()
                    TriggerServerEvent("e_card:getCardPlayer")
                end
            })
        else
            exports.ox_target:addGlobalPlayer({
                name = 'e_card:createCardPlayer',
                label = '📸 '..Translate('createCard'),
                distance = 2.0,
                groups = Config.interactPlayer.jobs,
                canInteract = function ()
                    return InZone
                end,
                onSelect = function(data)
                    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
                    TriggerServerEvent("e_card:getCardPlayer",playerId)
                end
            })
        end
    else
        CreateThread(function()
            local uiText = Translate('uiText')
            local playerPed = cache.ped
            if ped then
                while true do
                    local playerCoords = GetEntityCoords(playerPed)
                    local isOpen, currentText = lib.isTextUIOpen()
                    if #(playerCoords - Config.ped.pos) < 2.5 then
                        if not isOpen then
                            lib.showTextUI(uiText)
                        end
                        if IsControlJustReleased(0,51) then
                            TriggerServerEvent("e_card:getCardPlayer")
                        end
                    else
                        if isOpen and currentText == uiText then
                            lib.hideTextUI()
                        end
                    end

                    Wait(1)
                end
            else
                while true do
                    local isOpen, currentText = lib.isTextUIOpen()
                    if InZone then
                        if not isOpen then
                            lib.showTextUI(uiText)
                        end
                        local playerCoords = GetEntityCoords(playerPed)
                        if IsControlJustReleased(0,51) then
                            local playerId = lib.getClosestPlayer(playerCoords)
                            TriggerServerEvent("e_card:getCardPlayer",playerId)
                        end
                    else
                        if isOpen and currentText == uiText then
                            lib.hideTextUI()
                        end
                    end
                    Wait(1)
                end
            end
        end)
    end
end

function LoadPed()
    local config = Config.interactPlayer
    if config.activate then
        local ped = 0
        lib.requestModel(Config.ped.model)
        if not DoesEntityExist(ped) then
            ped = CreatePed(5, config.model, config.pos.x, config.pos.y, config.pos.z, config.heading, false, false)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            loadTarget(ped)
        end
    end
end

function LoadZone()
    local config = Config.interactPlayer
    if config.activate then
        InZone = false
        for _,v in pairs(config.zone) do
            lib.zones.poly({
                points = v,
                onEnter = function()
                    InZone = true
                end,
                onExit = function()
                    InZone = false
                end, 
                debug = config.debug
            })
        end
        loadTarget()
    end
end