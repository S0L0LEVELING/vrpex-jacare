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
Tunnel.bindInterface("vrp_hospital",cRP)
vSERVER = Tunnel.getInterface("vrp_hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local damaged = {}
local bleeding = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if GetEntityHealth(ped) > 110 and not IsPedInAnyVehicle(ped) then
			if not damaged.vehicle and HasEntityBeenDamagedByAnyVehicle(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.vehicle = true
				bleeding = bleeding + 2
				TriggerServerEvent("vrp_dna:dropDna",80,190,40)
			end

			if HasEntityBeenDamagedByWeapon(ped,0,2) then
				ClearEntityLastDamageEntity(ped)
				damaged.bullet = true
				bleeding = bleeding + 1
				TriggerServerEvent("vrp_dna:dropDna",30,100,200)
			end

			if not damaged.taser and IsPedBeingStunned(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.taser = true
			end
		end

		local hit,bone = GetPedLastDamageBone(ped)
		if hit and not damaged[bone] and bone ~= 0 then
			damaged[bone] = true
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if GetEntityHealth(ped) > 101 then
			if bleeding == 4 then
				SetEntityHealth(ped,GetEntityHealth(ped)-2)
			elseif bleeding == 5 then
				SetEntityHealth(ped,GetEntityHealth(ped)-3)
			elseif bleeding == 6 then
				SetEntityHealth(ped,GetEntityHealth(ped)-4)
			elseif bleeding >= 7 then
				SetEntityHealth(ped,GetEntityHealth(ped)-5)
			end

			if bleeding >= 4 then
				TriggerEvent("Notify","vermelho","Você está sangrando.",3000)
				TriggerServerEvent("vrp_dna:dropDna",255,0,0)
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetDiagnostic")
AddEventHandler("resetDiagnostic",function()
	local ped = PlayerPedId()
	ClearPedBloodDamage(ped)

	damaged = {}
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetBleeding")
AddEventHandler("resetBleeding",function()
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWINJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
local exit = true
RegisterNetEvent("drawInjuries")
AddEventHandler("drawInjuries",function(ped,injuries)
	local function draw3dtext(x,y,z,text)
		SetTextFont(4)
		SetTextCentre(1)
		SetTextEntry("STRING")
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,150)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z,0)
		DrawText(0.0,0.0)
		local factor = (string.len(text) / 400) + 0.01
		DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
		ClearDrawOrigin()
	end

	Citizen.CreateThread(function()
		local counter = 0
		exit = not exit

		while true do
			if counter > 1000 or exit then
				exit = true
				break
			end

			for k,v in pairs(injuries) do
				local x,y,z = table.unpack(GetPedBoneCoords(GetPlayerPed(GetPlayerFromServerId(ped)),k))
				draw3dtext(x,y,z,"~w~"..string.upper(v))
			end

			counter = counter + 1
			Citizen.Wait(0)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getDiagnostic()
	return damaged,bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getBleeding()
	return bleeding
end