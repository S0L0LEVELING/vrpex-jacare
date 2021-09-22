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
Tunnel.bindInterface("vrp_methlabs",cRP)
vSERVER = Tunnel.getInterface("vrp_methlabs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(gallons) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 4

					if v[5] >= 100 then
						DrawText3D(v[1],v[2],v[3]+0.5,"~g~E~w~   RETIRAR")
					elseif v[5] > 0 then
						DrawText3D(v[1],v[2],v[3]+0.5,"~y~"..v[5].."%~w~  PROGRESSO")
					else
						DrawText3D(v[1],v[2],v[3]+0.5,"~g~E~w~   LIGAR")
					end

					if IsControlJustPressed(1,38) and distance <= 0.8 then
						vSERVER.checkStatus(k)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTRANSFORM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(39.01,3717.33,11.01))
			if distance <= 1.5 then
				timeDistance = 4
				DrawText3D(39.01,3717.33,11.01,"~g~E~w~   PRODUZIR")
				if IsControlJustPressed(1,38) and distance <= 0.8 then
					vSERVER.checkProduction()
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEEXISTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_methlabs:labUpdate")
AddEventHandler("vrp_methlabs:labUpdate",function(status)
	gallons = status
end)
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