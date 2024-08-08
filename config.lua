Config = {}
Config.Framework = 'ESX' -- SELECT 'ESX' or 'QB' or 'Custom'

Config.inventory = 'OX' -- SELECT 'ESX' or 'QB' or 'OX' or 'Custom' 

Config.ped = {
    activate = true, -- if you want disable set false
    pos = vec3(0.0,0.0,0.0),
    heading = 0.0,
    model = ``,
}

Config.interactPlayer = {
    activate = true, -- if you want disable set false
    zone = {{
        vec3(0.0,0.0,0.0),
    }}, -- zone list on can create cards
    jobs = {"police"}, -- job list can create card
    debug = false
}

Config.target = true -- if you have ox_target and you want use