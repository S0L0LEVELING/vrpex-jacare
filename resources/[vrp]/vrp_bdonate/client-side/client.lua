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
Tunnel.bindInterface("vrp_bdonate",cnVRP)
vSERVER = Tunnel.getInterface("vrp_bdonate")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local typeCars = {}
local typeBikes = {}
local localVehicles = {}
local vehicles = {}
local vehIds = {}
local open = vector3(690.17,588.53,131.07)
local zone = vector3(677.65,560.46,129.05)

local coords = {
	[1] = { cds = vector3(681.86,584.76,130.05), h = 205.25 },
	[2] = { cds = vector3(678.54,578.64,130.05), h = 276.52 },
	[3] = { cds = vector3(694.46,579.8,130.05), h = 116.1 },
	[4] = { cds = vector3(693.24,572.88,130.05), h = 40.36 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_bdonate:syncVehicles")
AddEventHandler("vrp_bdonate:syncVehicles",function(vehs)
	if #vehIds > 0 then
		for k,v in pairs(vehs) do
			if v.model ~= vehicles[k].model then
				swapVehicle(v.model,k)
			end
		end
	else
		vehicles = vehs
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_bdonate:syncList")
AddEventHandler("vrp_bdonate:syncList",function(cars,bikes)
	typeCars = cars
	typeBikes = bikes
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - open)
			if distance <= 2.1 then
				timeDistance = 4
				DrawText3D(open.x,open.y,open.z,"~g~E~w~   ABRIR")
				if IsControlJustPressed(1,38) then
					SetNuiFocus(true,true)
					SendNUIMessage({ action = "show" })
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inside = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local distance = #(coords - zone)
		if distance <= 32.1 then
			if not inside then
				inside = true
				spawnVehicles()
			end
		else
			if inside then
				inside = false
				despawnVehicles()
			end
		end
		

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function spawnVehicles()
	ClearAreaOfVehicles(686.32,577.68,130.47,338.73)
	for k,v in pairs(vehicles) do
		local hash = GetHashKey(v.model)

		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(10)
		end

		local id = CreateVehicle(hash,coords[k].cds.x,coords[k].cds.y,coords[k].cds.z,coords[k].h,false,false)
		SetVehicleOnGroundProperly(id)
		SetVehicleDoorsLocked(id,2)
		SetVehicleDirtLevel(id,0.0)
		FreezeEntityPosition(id,true)
		SetEntityAsMissionEntity(id,true,true)
		SetVehicleNumberPlateText(id,"PDMSALE"..k)
		vehIds[k] = id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function swapVehicle(veh,slot)
	if slot > 0 and slot < 5 then
		if vehIds[slot] then
			if DoesEntityExist(vehIds[slot]) then
				DeleteEntity(vehIds[slot])
			end
		end

		local hash = GetHashKey(veh)

		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(10)
		end

		local id = CreateVehicle(hash,coords[slot].cds.x,coords[slot].cds.y,coords[slot].cds.z,coords[slot].h,false,false)
		SetVehicleDoorsLocked(id,2)
		SetVehicleDirtLevel(id,0.0)
		FreezeEntityPosition(id,true)
		SetEntityAsMissionEntity(id,true,true)
		SetVehicleNumberPlateText(id,"PDMSALE"..slot)
		vehIds[slot] = id
		vehicles[slot].model = veh
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function despawnVehicles()
	for k,v in pairs(vehIds) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end
	vehIds = {}
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEAPP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CloseApp",function(data,cb)
	SetNuiFocus(false,false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandleSpawn",function(data,cb)
	TriggerServerEvent("vrp_bdonate:setVehicles",data.vehicle,data.slot)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetCars",function(data,cb)
	cb(typeCars)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBIKES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetBikes",function(data,cb)
	cb(typeBikes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOWNED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetOwned",function(data,cb)
	local vehs = vSERVER.getOwned()
	cb(vehs)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestSell",function(data,cb)
	vSERVER.requestSell(data.name)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestBuy",function(data,cb)
	vSERVER.requestBuy(data.name,data.form)
	cb("ok")
end)