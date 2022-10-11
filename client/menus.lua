local QBCore = exports['qb-core']:GetCoreObject()

-- start coke run
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("coke-runner", vector3(-94.06, -971.12, 21.28), 1, 1, {
        name = "coke-runner",
        heading = 340,
        debugPoly = false,
		minZ=20.28,
		maxZ=22.28
    }, {
        options = {
            {
                type = "client",
                event = "rsg_cokerun:client:cokerun",
                icon = "fas fa-cannabis",
                label = 'Start Coke Run'
            },
        },
        distance = 2.5
    })
end)