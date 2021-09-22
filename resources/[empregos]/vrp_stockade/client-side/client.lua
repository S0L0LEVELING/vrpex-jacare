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
Tunnel.bindInterface("vrp_stockade",cnVRP)
vSERVER = Tunnel.getInterface("vrp_stockade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockStockades = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) then
			local vehicle = getNearVehicle(11)
			if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey("stockade") then
				local coordsPed = GetEntityCoords(ped)
				local plate = GetVehicleNumberPlateText(vehicle)
				local coords = GetOffsetFromEntityInWorldCoords(vehicle,0.0,-3.5,0.0)
				local distance = #(coords - coordsPed)
				if distance <= 2.5 and blockStockades[plate] == nil then
					timeDistance = 4
					DrawText3D(coords.x,coords.y,coords.z+1,"~g~E~w~   ROUBAR")
					if IsControlJustPressed(1,38) and distance <= 1.0 and vSERVER.checkPolice(plate) then
						SetEntityHeading(ped,GetEntityHeading(vehicle))
						vSERVER.withdrawMoney(plate,VehToNet(vehicle))
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FREEZEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.freezePlayers(status)
	FreezeEntityPosition(PlayerPedId(),status)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_STOCKADE:DESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_stockade:Destroy")
AddEventHandler("vrp_stockade:Destroy",function(vehNet)
	if NetworkDoesNetworkIdExist(vehNet) then
		local v = NetToEnt(vehNet)
		if DoesEntityExist(v) then
			SetVehicleEngineHealth(v,100.0)
			SetVehicleBodyHealth(v,100.0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_STOCKADE:CLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_stockade:Client")
AddEventHandler("vrp_stockade:Client",function(status)
	blockStockades = status
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
		local distance = #(coords - coordsVeh)
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
-- DWTEXT
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