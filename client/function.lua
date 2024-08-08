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
    end
end