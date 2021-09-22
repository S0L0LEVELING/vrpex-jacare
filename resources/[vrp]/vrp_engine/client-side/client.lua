-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_engine",cnVRP)
vSERVER = Tunnel.getInterface("vrp_engine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local lastFuel = 0
local isPrice = 0
local isGallons = 0
local isFuel = false
local vehFuels = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCLASS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehClass = {
	[0] = 0.7,
	[1] = 0.7,
	[2] = 0.7,
	[3] = 0.7,
	[4] = 0.7,
	[5] = 0.7,
	[6] = 0.7,
	[7] = 0.7,
	[8] = 0.7,
	[9] = 0.7,
	[10] = 0.7,
	[11] = 0.7,
	[12] = 0.7,
	[13] = 0.0,
	[14] = 0.0,
	[15] = 0.0,
	[16] = 0.0,
	[17] = 0.4,
	[18] = 0.4,
	[19] = 0.7,
	[20] = 0.7,
	[21] = 0.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuel = {
	[1.0] = 1.0,
	[0.9] = 0.9,
	[0.8] = 0.8,
	[0.7] = 0.7,
	[0.6] = 0.6,
	[0.5] = 0.5,
	[0.4] = 0.4,
	[0.3] = 0.3,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUELLOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local fuelLocs = {
	{ 1,265.05,-1262.65,29.3,15.0 },
	{ 2,819.14,-1028.65,26.41,15.0 },
	{ 3,1208.61,-1402.43,35.23,15.0 },
	{ 4,1181.48,-330.26,69.32,15.0 },
	{ 5,621.01,268.68,103.09,15.0 },
	{ 6,2581.09,361.79,108.47,17.0 },
	{ 7,175.08,-1562.12,29.27,15.0 },
	{ 8,-319.76,-1471.63,30.55,17.0 },
	{ 9,1782.33,3328.46,41.26,10.0 },
	{ 10,49.42,2778.8,58.05,15.0 },
	{ 11,264.09,2606.56,44.99,15.0 },
	{ 12,1039.38,2671.28,39.56,15.0 },
	{ 13,1207.4,2659.93,37.9,10.0 },
	{ 14,2539.19,2594.47,37.95,9.0 },
	{ 15,2679.95,3264.18,55.25,10.0 },
	{ 16,2005.03,3774.43,32.41,15.0 },
	{ 17,1687.07,4929.53,42.08,15.0 },
	{ 18,1701.53,6415.99,32.77,10.0 },
	{ 19,180.1,6602.88,31.87,15.0 },
	{ 20,-94.46,6419.59,31.48,15.0 },
	{ 21,-2555.17,2334.23,33.08,16.0 },
	{ 22,-1800.09,803.54,138.72,16.0 },
	{ 23,-1437.0,-276.8,46.21,15.0 },
	{ 24,-2096.3,-320.17,13.17,17.0 },
	{ 25,-724.56,-935.97,19.22,17.0 },
	{ 26,-525.26,-1211.19,18.19,15.0 },
	{ 27,-70.96,-1762.21,29.54,15.0 },
	{ 28,4929.14,-5192.99,2.44,161.01 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GALLONLOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local gallonLocs = {
	{ 1,289.2,-1266.97,29.45 },
	{ 2,818.1,-1040.89,26.76 },
	{ 3,1211.25,-1389.01,35.38 },
	{ 4,1167.01,-323.09,69.26 },
	{ 5,642.1,260.4,103.3 },
	{ 6,2559.24,373.79,108.63 },
	{ 7,166.94,-1553.39,29.27 },
	{ 8,-342.46,-1474.93,30.75 },
	{ 9,1776.26,3327.38,41.44 },
	{ 10,46.5,2789.15,57.88 },
	{ 11,265.85,2598.39,44.83 },
	{ 12,1039.28,2664.31,39.56 },
	{ 13,1202.17,2654.35,37.86 },
	{ 14,2545.25,2591.9,37.96 },
	{ 15,2674.11,3266.88,55.25 },
	{ 16,2001.6,3779.76,32.19 },
	{ 17,1694.77,4923.83,42.24 },
	{ 18,1706.18,6425.62,32.77 },
	{ 19,162.19,6636.62,31.56 },
	{ 20,-97.68,6406.04,31.65 },
	{ 21,-2544.09,2316.02,33.22 },
	{ 22,-1819.37,797.52,138.16 },
	{ 23,-1428.03,-268.34,46.23 },
	{ 24,-2073.23,-327.3,13.32 },
	{ 25,-702.84,-916.75,19.22 },
	{ 26,-531.47,-1221.17,18.46 },
	{ 27,-48.02,-1761.12,29.44 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(num)
	local mult = 10^1
	return math.floor(num*mult+0.5) / mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREDCONSUMEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local speed = GetEntitySpeed(vehicle) * 2.236936
			if IsVehicleEngineOn(vehicle) and GetPedInVehicleSeat(vehicle,-1) == ped and speed >= 5 and GetVehicleFuelLevel(vehicle) >= 2 then
				TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),GetVehicleFuelLevel(vehicle) - (vehFuel[floor(GetVehicleCurrentRpm(vehicle))] or 1.0) * (vehClass[GetVehicleClass(vehicle)] or 1.0) / 10)
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREDREFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetSelectedPedWeapon(ped) == 883325847 then
				local vehicle = GetPlayersLastVehicle()
				if DoesEntityExist(vehicle) then
					local vehFuel = GetVehicleFuelLevel(vehicle)
					local coords = GetEntityCoords(ped)
					local coordsVeh = GetEntityCoords(vehicle)
					local distance = #(coords - vector3(coordsVeh.x,coordsVeh.y,coordsVeh.z))
					if distance <= 3.5 then
						timeDistance = 4

						if not isFuel then
							if vehFuel >= 100.0 then
								text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+1,"~p~TANQUE CHEIO")
							elseif GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 <= 0 then
								text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+1,"~b~GALÃO VAZIO")
							else
								text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+1,"~g~E~w~   ABASTECER")
							end
						else
							if vehFuel >= 0.0 and GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 > 0 then
								SetPedAmmo(ped,883325847,math.floor(GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100))

								SetVehicleFuelLevel(vehicle,vehFuel+0.03)
								text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+1,"~g~E~w~   CANCELAR")
								text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+0.85,"TANQUE: ~y~"..parseInt(floor(vehFuel)).."%   ~w~GALÃO: ~y~"..parseInt(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100).."%")

								if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
									TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
								end

								if vehFuel >= 100.0 or GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 <= 0 or GetEntityHealth(ped) <= 101 then
									TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),vehFuel)
									StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
									RemoveAnimDict("timetable@gardener@filling_can")
									isFuel = false
								end
							end
						end

						if IsControlJustPressed(1,38) then
							if isFuel then
								TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),vehFuel)
								StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
								RemoveAnimDict("timetable@gardener@filling_can")
								isFuel = false
							else
								if GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 >= 0 and vehFuel <= 100.0 then
									TaskTurnPedToFaceEntity(ped,vehicle,5000)
									loadAnim("timetable@gardener@filling_can")
									TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
									isFuel = true
								end
							end
						end

					end

					if isFuel and distance > 3.5 then
						TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),vehFuel)
						StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
						RemoveAnimDict("timetable@gardener@filling_can")
						isFuel = false
					end

				end
			else
				local coords = GetEntityCoords(ped)
				for k,v in pairs(fuelLocs) do
					local distance = #(coords - vector3(v[2],v[3],v[4]))
					if distance <= v[5] then
						timeDistance = 4
						local vehicle = GetPlayersLastVehicle()
						if DoesEntityExist(vehicle) then
							local coordsVeh = GetEntityCoords(vehicle)
							local vehFuel = GetVehicleFuelLevel(vehicle)
							local distance = #(coords - vector3(coordsVeh.x,coordsVeh.y,coordsVeh.z))

							if distance <= 3.5 then

								if not isFuel then
									if vehFuel >= 100.0 then
										text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+1,"~p~TANQUE CHEIO")
									else
										text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+1,"~g~E~w~   ABASTECER")
									end
								else
									if vehFuel >= 0.0 then
										isPrice = isPrice + 0.075
										isGallons = isGallons + 0.02
										SetVehicleFuelLevel(vehicle,vehFuel+0.02)
										text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+1,"~g~E~w~   CANCELAR")
										text3D(coordsVeh.x,coordsVeh.y,coordsVeh.z+0.85,"TANQUE: ~y~"..parseInt(floor(vehFuel)).."%   ~w~PREÇO: ~y~$"..parseInt(isPrice))

										if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
											TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
										end

										if vehFuel >= 100.0 or GetEntityHealth(ped) <= 101 then
											if vSERVER.paymentFuel(isPrice) then
												TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),vehFuel)
											else
												TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),lastFuel)
											end

											StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
											RemoveAnimDict("timetable@gardener@filling_can")
											isFuel = false
											isGallons = 0
											isPrice = 0
										end
									end
								end

								if IsControlJustPressed(1,38) then
									if isFuel then
										if vSERVER.paymentFuel(isPrice) then
											TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),vehFuel)
										else
											TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),lastFuel)
										end

										StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
										RemoveAnimDict("timetable@gardener@filling_can")
										isFuel = false
										isGallons = 0
										isPrice = 0
									else
										if vehFuel < 100.0 then
											lastFuel = vehFuel
											TaskTurnPedToFaceEntity(ped,vehicle,5000)
											loadAnim("timetable@gardener@filling_can")
											TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
											isFuel = true
										end
									end
								end

							end

							if isFuel and distance > 3.5 then
								if vSERVER.paymentFuel(isPrice) then
									TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),vehFuel)
								else
									TriggerServerEvent("vrp_engine:tryFuel",VehToNet(vehicle),lastFuel)
								end

								StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
								RemoveAnimDict("timetable@gardener@filling_can")
								isFuel = false
								isGallons = 0
								isPrice = 0
							end

						end
					end
				end

				for k,v in pairs(gallonLocs) do
					local distance = #(coords - vector3(v[2],v[3],v[4]))
					if distance <= 3.5 then
						timeDistance = 4
						DrawText3Ds(v[2],v[3],v[4]+0.3,"~b~E~w~   COMPRAR GÁS")
						if distance <= 1.1 then
							if IsControlJustPressed(1,38) then
								vSERVER.gallonBuying()
							end
						end
					end
				end
			end

			if isFuel then
				DisableControlAction(1,22,true)
				DisableControlAction(1,23,true)
				DisableControlAction(1,24,true)
				DisableControlAction(1,29,true)
				DisableControlAction(1,30,true)
				DisableControlAction(1,31,true)
				DisableControlAction(1,44,true)
				DisableControlAction(1,140,true)
				DisableControlAction(1,311,true)
				DisableControlAction(1,323,true)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_engine:syncFuel")
AddEventHandler("vrp_engine:syncFuel",function(index,fuel)
	vehFuels[index] = fuel + 0.0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCFUELPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_engine:syncFuelPlayers")
AddEventHandler("vrp_engine:syncFuelPlayers",function(status)
	vehFuels = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			if vehFuels[VehToNet(vehicle)] then
				SetVehicleFuelLevel(vehicle,vehFuels[VehToNet(vehicle)])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function text3D(x,y,z,text)
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

function DrawText3Ds(x,y,z,text)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end