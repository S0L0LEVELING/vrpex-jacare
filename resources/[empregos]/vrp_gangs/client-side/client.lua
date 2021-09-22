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
Tunnel.bindInterface("vrp_gangs",cnVRP)
vSERVER = Tunnel.getInterface("vrp_gangs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local maxPackage = 100
local boxVehicles = {}
local inPackage = false
local handPackage = false
local inService = false
local cdsStart = { 700.53,-303.07,59.25 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(cdsStart) do
			local distance = #(coords - vector3(cdsStart[1],cdsStart[2],cdsStart[3]))
			if distance <= 1 then
				timeDistance = 4

				if inService then
					DrawText3D1(cdsStart[1],cdsStart[2],cdsStart[3],"~g~E~w~   FINALIZAR")
				else
					DrawText3D1(cdsStart[1],cdsStart[2],cdsStart[3],"~g~E~w~   INICIAR")
				end

				if IsControlJustPressed(1,38) then
					inService = not inService
					startthreadstockade()
					startthreadblock()
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local functions = {
	{ -3155.54,1125.26,20.86,-444.92,1594.49,358.47 }, -- ECSTASY
	{ 3725.43,4525.73,22.48,-830.41,-420.58,36.77 }, -- FUELTECH
	{ 2232.38,5611.71,54.92,1130.24,3384.62,45.81 } -- LEAN
}

local cooldown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadstockade()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 1000
			if inService then
				local ped = PlayerPedId()

				if not IsPedInAnyVehicle(ped) then
					local vehicle = getNearVehicle(11)

					if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey("gburrito2") then
						local coordsPed = GetEntityCoords(ped)
						local plate = GetVehicleNumberPlateText(vehicle)
						local coords = GetOffsetFromEntityInWorldCoords(vehicle,0.0,-2.5,0.0)
						local distance = #(coords - coordsPed)
						if distance <= 1.2 then
							timeDistance = 4

							if inPackage then
								if boxVehicles[plate] == nil then
									DrawText3D(coords.x,coords.y,coords.z,"~g~E~w~   GUARDAR SUPRIMENTOS\nTOTAL DE SUPRIMENTOS:  0/"..maxPackage)
								else
									DrawText3D(coords.x,coords.y,coords.z,"~g~E~w~   GUARDAR SUPRIMENTOS\nTOTAL DE SUPRIMENTOS:  "..boxVehicles[plate].."/"..maxPackage)
								end

								if IsControlJustPressed(1,38) and cooldown == 0 then
									cooldown = 2
									Citizen.Wait(1000)
								 	vSERVER.addPackage(plate)
									inPackage = false
									handPackage = false
									vRP.removeObjects("one")
								end
							else
								if boxVehicles[plate] == nil then
									DrawText3D(coords.x,coords.y,coords.z,"~b~E~w~   RETIRAR SUPRIMENTOS\nTOTAL DE SUPRIMENTOS:  0/"..maxPackage,550,0.0225,0.06)
								else
									DrawText3D(coords.x,coords.y,coords.z,"~b~E~w~   RETIRAR SUPRIMENTOS\nTOTAL DE SUPRIMENTOS:  "..boxVehicles[plate].."/"..maxPackage,550,0.0225,0.06)
								end

								if IsControlJustPressed(1,38) and boxVehicles[plate] and cooldown == 0 then
									cooldown = 2
									if boxVehicles[plate] > 0 then
										inPackage = true
										handPackage = true
										TriggerServerEvent("vrp_gangs:remPackage",plate)
										vRP.createObjects("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
									end
								end
							end
						end
					end

					local coords = GetEntityCoords(ped)

					for k,v in pairs(functions) do
						local distance01 = #(coords - vector3(v[1],v[2],v[3]))
						local distance02 = #(coords - vector3(v[4],v[5],v[6]))
						if distance01 <= 2 then
							timeDistance = 4
							DrawText3D1(v[1],v[2],v[3],"~g~E~w~  PEGAR SUPRIMENTOS")
							if distance01 <= 0.6 and IsControlJustPressed(1,38) then
								if inPackage then
									inPackage = false
									vRP.removeObjects("one")
								else
									inPackage = true
									vRP.createObjects("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
								end
							end
						end

						if distance02 <= 2 and handPackage then
							timeDistance = 4
							DrawText3D1(v[4],v[5],v[6],"~g~E~w~ ENTREGAR SUPRIMENTOS")
							if distance02 <= 0.6 and IsControlJustPressed(1,38) then
								inPackage = false
								handPackage = false
								vSERVER.paymentMethod(k)
								vRP.removeObjects()
							end
						end
					end
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end

CreateThread(function()
	while true do
		if cooldown > 0 then 
			cooldown = cooldown - 1
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_GANGS:THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadblock()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inPackage then
				timeDistance = 4
				DisableControlAction(1,245,true)
				DisableControlAction(1,167,true)
				DisableControlAction(1,21,true)
				DisableControlAction(1,22,true)
				DisableControlAction(1,23,true)
			end

			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_GANGS:UPDATEPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_gangs:updatePackage")
AddEventHandler("vrp_gangs:updatePackage",function(status)
	boxVehicles = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function getNearVehicles(radius)
	local r = {}
	local coords = GetEntityCoords(PlayerPedId())

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local coordsVeh = GetEntityCoords(veh)
		local distance = #(coordsVeh - coords)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function getNearVehicle(radius)
	local veh
	local vehs = getNearVehicles(radius)
	local min = radius + 0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D1(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end

function DrawText3D(x,y,z,text,h,g,f)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / h
	DrawRect(_x,_y+g,0.01+factor,0.05,38,42,56,200)
end