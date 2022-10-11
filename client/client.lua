local QBCore = exports['qb-core']:GetCoreObject()

-- start /tp -93.78376 -985.848 21.276838

local tasking = false
local cokerunactive = false
local cokeVehicle = 0
local CurrentCops = 0
local rnd = 0
local blip = 0
local deliveryPed = 0
local plt = 0

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

-- cokebaggy
RegisterNetEvent("rsg_cokerun:client:cokerun")
AddEventHandler("rsg_cokerun:client:cokerun", function()
	local dealerrep = QBCore.Functions.GetPlayerData().metadata["dealerrep"]
	if CurrentCops >= Config.MinimumCokeSellingPolice then
		if dealerrep >= 0 then
			if cokerunactive == false then
				local hasItem = QBCore.Functions.HasItem("cokebaggy", 10)
				if hasItem then
					QBCore.Functions.Progressbar("coke-instructions", "Setting up delivery..", 5000, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "mp_common",
						anim = "givetake1_a",
						flags = 8,
					}, {}, {}, function() -- Done
						cokerunactive = true
						TriggerEvent('rsg_cokerun:client:startDealing')
						QBCore.Functions.Notify("now go deliver the product..", "primary")
						TriggerServerEvent("qb-log:server:CreateLog", "drugs", "Coke Run Started", "green", "**"..GetPlayerName(PlayerId()).."** has started doing a coke run!")
					end, function()
						QBCore.Functions.Notify("Cancelled..", "error")
					end)
				else
					cokerunactive = false
					QBCore.Functions.Notify("you dont have enough coke to sell!", "error")
				end
			else
				QBCore.Functions.Notify("you are already dealling!", "error")
			end
		else
			QBCore.Functions.Notify("You dont have the dealing reputation to do this yet!", "error")
		end
	else
		QBCore.Functions.Notify("Not enough police on duty to do this!", "error")
	end
end)

local CokeDropOffs = {
	[1] =  { ['coords'] = vector4(34.562717, -1031.219, 29.493057, 116.14076) },
	[2] =  { ['coords'] = vector4(183.95144, -1005.486, 29.323501, 167.16775) },
	[3] =  { ['coords'] = vector4(959.77288, -1199.265, 26.061895, 292.24194) },
	[4] =  { ['coords'] = vector4(494.94729, -723.1629, 24.898815, 265.42568) },
	[5] =  { ['coords'] = vector4(539.77313, 30.910598, 94.28585, 21.200006) },
	[6] =  { ['coords'] = vector4(-238.6646, 243.40409, 92.04309, 358.93591) },
	[7] =  { ['coords'] = vector4(-360.5898, 519.20202, 120.04254, 158.05801) },
	[8] =  { ['coords'] = vector4(30.377573, 365.1484, 112.65132, 120.71504) },
	[9] =  { ['coords'] = vector4(481.50588, 262.83367, 103.10939, 347.18353) },
	[10] =  { ['coords'] = vector4(928.0191, 53.658107, 81.095985, 34.953327) },
	[11] =  { ['coords'] = vector4(1173.3846, -296.4729, 68.993698, 261.57247) },
	[12] =  { ['coords'] = vector4(1382.3217, -585.5824, 74.337669, 77.638198) },
	[13] =  { ['coords'] = vector4(1078.4418, -699.7879, 58.236576, 145.20216) },
	[14] =  { ['coords'] = vector4(1061.1289, -2272.165, 30.475564, 56.838951) },
	[15] =  { ['coords'] = vector4(766.8728, -2481.728, 20.172201, 139.55778) },
	[16] =  { ['coords'] = vector4(242.05818, -2509.302, 6.382936, 267.46292) },
	[17] =  { ['coords'] = vector4(140.84326, -1983.428, 18.317354, 243.42233) },
	[18] =  { ['coords'] = vector4(138.36801, -1865.328, 24.332376, 165.46823) },
	[19] =  { ['coords'] = vector4(94.792518, -1916.813, 20.722991, 134.80393) },
	[20] =  { ['coords'] = vector4(-1179.283, -1779.592, 3.9084634, 314.9425) },
	[21] =  { ['coords'] = vector4(-1659.292, -980.7276, 7.3333373, 13.502635) },
	[22] =  { ['coords'] = vector4(-2110.561, -340.977, 13.086047, 155.79818) },
	[23] =  { ['coords'] = vector4(-1367.755, 51.079795, 53.700881, 83.387168) },
	[24] =  { ['coords'] = vector4(284.07037, 344.28491, 105.44724, 191.51214) },
	[25] =  { ['coords'] = vector4(1079.4858, -506.7017, 62.77523, 137.77656) },
	[26] =  { ['coords'] = vector4(153.57621, -788.367, 31.194829, 226.69847) },
	[27] =  { ['coords'] = vector4(349.14855, -1092.612, 29.406436, 166.41502) },
	[28] =  { ['coords'] = vector4(808.06109, -746.7705, 26.780929, 344.63586) },
	[29] =  { ['coords'] = vector4(-577.2229, -1086.13, 22.329587, 180.83757) },
	[30] =  { ['coords'] = vector4(383.99432, -833.7318, 29.291664, 163.13162) },
	[31] =  { ['coords'] = vector4(-958.4527, -1173.973, 2.2146453, 109.06101) },
	[32] =  { ['coords'] = vector4(-1274.854, -357.0108, 36.665649, 74.406143) },
	[33] =  { ['coords'] = vector4(-624.8298, -247.9535, 38.435653, 124.45104) },
	[34] =  { ['coords'] = vector4(-68.75217, -1120.67, 25.825458, 134.11315) },
	[35] =  { ['coords'] = vector4(238.67872, -821.9793, 30.092948, 166.39137) },
	[36] =  { ['coords'] = vector4(-839.5587, -742.0629, 23.855813, 132.11953) },
	[37] =  { ['coords'] = vector4(290.59585, -1284.922, 29.586313, 177.60072) },
	[38] =  { ['coords'] = vector4(430.01351, -1967.203, 23.248649, 312.31915) },
	[39] =  { ['coords'] = vector4(-998.1242, -1155.19, 2.2020006, 298.49819) },
	[40] =  { ['coords'] = vector4(-1124.059, -553.4558, 32.319183, 249.49331) },
	[41] =  { ['coords'] = vector4(278.06506, 67.055389, 94.370903, 342.04595) },
	[42] =  { ['coords'] = vector4(878.02667, -163.1732, 78.340301, 15.249855) },
	[43] =  { ['coords'] = vector4(-1801.588, 404.20819, 113.11754, 164.75215) },
	[44] =  { ['coords'] = vector4(-706.5633, 590.49188, 141.9956, 11.340888) },
	[45] =  { ['coords'] = vector4(223.24716, 372.92712, 106.36811, 61.496894) },
	[46] =  { ['coords'] = vector4(109.85091, -736.0612, 33.133262, 341.62042) },
	[47] =  { ['coords'] = vector4(271.46005, -670.7763, 35.204425, 183.56524) },
	[48] =  { ['coords'] = vector4(419.35287, -1008.255, 29.239933, 89.749366) },
	[49] =  { ['coords'] = vector4(812.73645, -910.7065, 25.359785, 160.2815) },
	[50] =  { ['coords'] = vector4(-765.2243, -1316.797, 5.1502728, 229.71536) },
}

local carspawns = {
	[1] =  { ['coords'] = vector4(-93.78376, -985.848, 21.276838, 119.94963), },
}

local carpick = {
    [1] = "felon",
    [2] = "kuruma",
    [3] = "sultan",
    [4] = "granger",
    [5] = "tailgater",
	[6] = "blista3",
}

function CreateCokeVehicle()

	if DoesEntityExist(cokeVehicle) then
	    SetVehicleHasBeenOwnedByPlayer(cokeVehicle,false)
		SetEntityAsNoLongerNeeded(cokeVehicle)
		DeleteEntity(cokeVehicle)
	end

    local car = GetHashKey(carpick[math.random(#carpick)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Wait(0)
    end

    local spawnpoint = 1
    for i = 1, #carspawns do
	    local caisseo = GetClosestVehicle(carspawns[i]['coords']["x"], carspawns[i]['coords']["y"], carspawns[i]['coords']["z"], 3.500, 0, 70)
		if not DoesEntityExist(caisseo) then
			spawnpoint = i
		end
    end

    cokeVehicle = CreateVehicle(car, carspawns[spawnpoint]['coords']["x"], carspawns[spawnpoint]['coords']["y"], carspawns[spawnpoint]['coords']["z"], carspawns[spawnpoint]['coords']["w"], true, false)
    local plt = GetVehicleNumberPlateText(cokeVehicle)
    SetVehicleHasBeenOwnedByPlayer(cokeVehicle,true)
	TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(cokeVehicle))
	SetVehicleDirtLevel(cokeVehicle, 0.0)
	exports['LegacyFuel']:SetFuel(cokeVehicle, 100)
    while true do
    	Wait(1)
		DrawText3Ds(carspawns[spawnpoint]['coords']["x"], carspawns[spawnpoint]['coords']["y"], carspawns[spawnpoint]['coords']["z"], "Your Delivery Car (Stolen).")
		if #(GetEntityCoords(PlayerPedId()) - vector3(carspawns[spawnpoint]['coords']["x"], carspawns[spawnpoint]['coords']["y"], carspawns[spawnpoint]['coords']["z"])) < 8.0 then
			return
		end
    end
end

function CreateCokePed()

    local hashKey = `a_m_y_stwhi_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Wait(100)
    end

	deliveryPed = CreatePed(pedType, hashKey, CokeDropOffs[rnd]['coords']["x"], CokeDropOffs[rnd]['coords']["y"], CokeDropOffs[rnd]['coords']["z"], CokeDropOffs[rnd]['coords']["w"], 0, 0)

    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)
    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)
end

function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)
		Wait(20000)
		DeletePed(deliveryPed)
	end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if CokeRun then
		print("you are in coke run")
		blip = AddBlipForCoord(CokeDropOffs[rnd]['coords']["x"], CokeDropOffs[rnd]['coords']["y"], CokeDropOffs[rnd]['coords']["z"])
	end
    SetBlipSprite(blip, 480)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off Coke")
    EndTextCommandSetBlipName(blip)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Wait( 5 )
    end
end 

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function DoDropOff()
	local success = true
	local CokeChance = math.random(1,1000)

	Wait(1000)
	playerAnim()
	Wait(800)

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

		local counter = math.random(50,200)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Wait(1)
		end
	
		if success then
			local counter = math.random(100,300)
			while counter > 0 do
				local crds = GetEntityCoords(deliveryPed)
				counter = counter - 1
				Wait(1)
			end
			giveAnim()
		end
	
		local crds = GetEntityCoords(deliveryPed)
		local crds2 = GetEntityCoords(PlayerPedId())
	
		if #(crds - crds2) > 3.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
			success = false
		end
		
		DeleteBlip()
		if success then
			local policenotifychance = math.random(1,100)
			local cokeorder = math.random(1,10)
			local hasItem = QBCore.Functions.HasItem("cokebaggy", 10)
			if hasItem then
				if policenotifychance >= 80 then -- 20% change of police notifed
					TriggerServerEvent('police:server:policeAlert', 'spotted: coke runner', 10000)
					TriggerServerEvent('rsg_cokerun:server:dealreward', cokeorder)
					TriggerServerEvent("QBCore:Server:SetMetaData", "dealerrep", QBCore.Functions.GetPlayerData().metadata["dealerrep"] + 1)
					Wait(5000)
					local cokedealerrep = QBCore.Functions.GetPlayerData().metadata["dealerrep"]
					QBCore.Functions.Notify("dealer reputation is now "..cokedealerrep, "success")
				else
					TriggerServerEvent('rsg_cokerun:server:dealreward', cokeorder)
					TriggerServerEvent("QBCore:Server:SetMetaData", "dealerrep", QBCore.Functions.GetPlayerData().metadata["dealerrep"] + 1)
					Wait(5000)
					local cokedealerrep = QBCore.Functions.GetPlayerData().metadata["dealerrep"]
					QBCore.Functions.Notify("dealer reputation is now "..cokedealerrep, "success")
				end
				
			else
				QBCore.Functions.Notify('not enough product to fill any more orders!', 'error')
				SetVehicleHasBeenOwnedByPlayer(cokeVehicle,false)
				SetEntityAsNoLongerNeeded(cokeVehicle)
				tasking = false
				CokeRun = false
				cokerunactive = false
			end
		else
			QBCore.Functions.Notify('the dropoff failed', 'error')
		end
	
		DeleteCreatedPed()
	end
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent("rsg_cokerun:client:cokedelivery")
AddEventHandler("rsg_cokerun:client:cokedelivery", function()

	if tasking then
		return
	end
	
	rnd = math.random(1,#CokeDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true

	while tasking do

		Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(CokeDropOffs[rnd]['coords']["x"], CokeDropOffs[rnd]['coords']["y"], CokeDropOffs[rnd]['coords']["z"])) 
		local cokeVehCoords = GetEntityCoords(cokeVehicle)
		local dstcheck2 = #(plycoords - cokeVehCoords) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated and (cokeVehicle == veh or dstcheck2 < 15.0) then
			pedCreated = true
			DeleteCreatedPed()
			CreateCokePed()
			QBCore.Functions.Notify('you are close to the dropoff point')
		end
		if dstcheck < 2.0 and pedCreated then
			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E] Deal Coke")  
			if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Wait(1500)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()
				tasking = false
			end
		end
	end
	DeleteCreatedPed()
	DeleteBlip()
end)

local firstdeal = false
Citizen.CreateThread(function()

    while true do
		local sleep = 2000
		if CokeRun then
			if not DoesEntityExist(cokeVehicle) or GetVehicleEngineHealth(cokeVehicle) < 200.0 or GetVehicleBodyHealth(cokeVehicle) < 200.0 then
				CokeRun = false
				tasking = false
				cokerunactive = false
				QBCore.Functions.Notify('the car is too damaged to continue!', 'error')
			else
				if tasking then
			        Wait(30000)
			    else
			        TriggerEvent("rsg_cokerun:client:cokedelivery")  
				    salecount = salecount + 1
				    if salecount == Config.RunAmount then
				    	Wait(300000)
				    	CokeRun = false
						cokerunactive = false
				    end
				end
			end
	    end
		Wait(sleep)
    end
	
end)

RegisterNetEvent("rsg_cokerun:client:startDealing")
AddEventHandler("rsg_cokerun:client:startDealing", function()
    local NearNPC = GetClosestPed()

	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	salecount = 0
	CokeRun = true
	firstdeal = true
	CreateCokeVehicle()
	QBCore.Functions.Notify('a stolen car has been provided', 'success')
end)