Config = {}

Config.MinimumCokeSellingPolice = 0 -- cops needed to start the weedrun

Config.RunAmount = 1000 -- how many drop offs the player does before it automatically stops.

Config.Payment = 100 -- how much marked bills you get paid per baggy

-- NPC SETTINGS --

Config.Invincible = true -- Is the ped going to be invincible?
Config.Frozen = true -- Is the ped frozen in place?
Config.Stoic = true -- Will the ped react to events around them?
Config.FadeIn = true -- Will the ped fade in and out based on the distance. (Looks a lot better.)
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)

Config.MinusOne = true -- Leave this enabled if your coordinates grabber does not -1 from the player coords.

Config.GenderNumbers = { -- No reason to touch these.
	['male'] = 4,
	['female'] = 5
}

Config.CokeRunPedList = { -- ped used to start the weedrun

	{
        model = `s_m_y_dealer_01`,
        coords = vector4(-93.96088, -971.1119, 21.27684, 160.89477),
        gender = 'male',
        scenario = 'WORLD_HUMAN_SMOKING_POT'
    },

}