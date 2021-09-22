-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_hunting",cRP)
vSERVER = Tunnel.getInterface("vrp_hunting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blipHunting = {}
local inHunting = false
local animalHunting = {}
local huntCoords = { -773.41,5598.71,33.61 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local animalCoords = {
	{ 558.49,2708.02,41.94 },
	{ 505.9,2741.32,44.57 },
	{ 425.42,2719.38,50.47 },
	{ 307.47,2674.99,44.35 },
	{ 246.48,2653.59,44.84 },
	{ 207.26,2590.61,46.08 },
	{ 241.53,2562.8,47.13 },
	{ 287.35,2532.36,46.1 },
	{ 347.03,2448.11,47.26 },
	{ 256.96,2444.23,53.97 },
	{ 449.11,2584.9,43.71 },
	{ 481.42,2655.61,43.02 },
	{ 548.84,2596.42,42.87 },
	{ 535.85,2659.89,42.39 },
	{ 635.1,2674.9,42.95 },
	{ 722.48,2652.73,43.99 },
	{ 823.32,2671.28,42.11 },
	{ 874.91,2663.1,41.25 },
	{ 930.35,2667.18,41.13 },
	{ 1019.4,2635.38,41.82 },
	{ 1073.71,2618.23,40.49 },
	{ 1155.45,2604.61,40.27 },
	{ 1217.31,2618.13,39.75 },
	{ 1229.82,2659.6,37.71 },
	{ 1297.1,2655.2,37.66 },
	{ 1337.97,2604.84,37.74 },
	{ 1410.52,2582.31,37.04 },
	{ 1340.72,2627.48,37.71 },
	{ 1275.91,2706.07,37.78 },
	{ 1258.79,2731.77,38.45 },
	{ 1186.29,2757.06,36.56 },
	{ 1115.41,2739.8,37.98 },
	{ 1058.71,2727.78,38.05 },
	{ 1009.39,2739.61,39.71 },
	{ 909.97,2721.42,40.79 },
	{ 862.82,2727.35,43.52 },
	{ 760.49,2715.24,39.98 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(huntCoords[1],huntCoords[2],huntCoords[3]))

			if distance <= 2 then
				timeDistance = 4

				if inHunting then
					DrawText3D(huntCoords[1],huntCoords[2],huntCoords[3],"~g~E~w~   FINALIZAR")
				else
					DrawText3D(huntCoords[1],huntCoords[2],huntCoords[3],"~g~E~w~   INICIAR")
				end

				if IsControlJustPressed(1,38) then
					for k,v in pairs(blipHunting) do
						if DoesBlipExist(blipHunting[k]) then
							RemoveBlip(blipHunting[k])
							blipHunting[k] = nil
						end
					end

					for k,v in pairs(animalHunting) do
						if DoesEntityExist(animalHunting[k]) then
							DeleteEntity(animalHunting[k])
							animalHunting[k] = nil
						end
					end

					if inHunting then
						inHunting = false
					else
						inHunting = true

						for i = 1,5 do
							newHunting(i)
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMEATANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if inHunting and animalHunting then
				local coords = GetEntityCoords(ped)
				for k,v in pairs(animalHunting) do
					local deerCoords = GetEntityCoords(animalHunting[k])
					local distance = #(coords - deerCoords)

					if distance <= 1 then
						if IsPedDeadOrDying(animalHunting[k]) and not IsPedAPlayer(animalHunting[k]) then
							timeDistance = 4

							DrawText3D(deerCoords["x"],deerCoords["y"],deerCoords["z"],"~g~E~w~   ESFOLAR")

							if IsControlJustPressed(1,38) and GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
								TaskTurnPedToFaceEntity(ped,animalHunting[k],-1)

								Citizen.Wait(1000)

								vRP._playAnim(true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)
								vRP._playAnim(false,{"amb@medic@standing@kneel@base","base"},true)
								TriggerEvent("cancelando",true)

								Citizen.Wait(15000)

								TriggerEvent("cancelando",false)
								vSERVER.animalPayment()
								vRP.removeObjects()

								if DoesBlipExist(blipHunting[k]) then
									RemoveBlip(blipHunting[k])
									blipHunting[k] = nil
								end

								if DoesEntityExist(animalHunting[k]) then
									DeleteEntity(animalHunting[k])
									animalHunting[k] = nil
								end

								newHunting(k)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWHUNTING
-----------------------------------------------------------------------------------------------------------------------------------------
function newHunting(i)
	RequestModel("a_c_deer")
	while not HasModelLoaded("a_c_deer") do
		RequestModel("a_c_deer")
		Citizen.Wait(1)
	end

	local inLocate = math.random(#animalCoords)
	animalHunting[i] = CreatePed(28,"a_c_deer",animalCoords[inLocate][1],animalCoords[inLocate][2],animalCoords[inLocate][3] - 1,math.random(0,359) + 0.0,false,true)
	TaskWanderStandard(animalHunting[i],true,true)
	blipAnimal(i)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function blipAnimal(i)
	if DoesBlipExist(blipHunting[i]) then
		RemoveBlip(blipHunting[i])
		blipHunting[i] = nil
	end

	blipHunting[i] = AddBlipForEntity(animalHunting[i])
	SetBlipDisplay(blipHunting[i],2)
	SetBlipSprite(blipHunting[i],141)
	SetBlipColour(blipHunting[i],41)
	SetBlipScale(blipHunting[i],0.8)
	SetBlipAsShortRange(blipHunting[i],true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Cervo "..500 + i)
	EndTextCommandSetBlipName(blipHunting[i])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 375) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end