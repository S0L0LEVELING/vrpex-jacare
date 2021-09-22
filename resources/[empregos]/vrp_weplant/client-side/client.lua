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
Tunnel.bindInterface("vrp_weplants",cnVRP)
vSERVER = Tunnel.getInterface("vrp_weplants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local wePlants = {}
local weObjects = {}
local weHashsA = "bkr_prop_weed_01_small_01c"
local weHashsB = "bkr_prop_weed_01_small_01a"
local weHashsC = "bkr_prop_weed_med_01a"
local weHashsD = "bkr_prop_weed_lrg_01a"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(wePlants) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance < 25 then
				if weObjects[k] == nil then
					if v[4] <= 39 then
						createModels(k,weHashsA,v[1],v[2],v[3])
					elseif v[4] >= 40 and v[4] <= 69 then
						createModels(k,weHashsB,v[1],v[2],v[3])
					elseif v[4] >= 70 and v[4] <= 99 then
						createModels(k,weHashsC,v[1],v[2],v[3])
					elseif v[4] >= 100 then
						createModels(k,weHashsD,v[1],v[2],v[3])
					end
				else
					timeDistance = 4

					if distance <= 2 then
						if parseInt(v[4]) >= 100 then
							dwText(v[1],v[2],v[3]-0.5,"~b~E~w~   COLETAR")
						else
							dwText(v[1],v[2],v[3]-0.5,"~y~"..v[4].."%~w~  PROGRESSO")
						end
					end

					if distance <= 0.7 then
						if IsControlJustPressed(1,38) and vSERVER.checkTimers(k) then
							if DoesEntityExist(weObjects[k]) then
								vSERVER.removePlants(k)
							end
						end
					end
				end
			else
				if weObjects[k] then
					TriggerEvent("vrp_weplants:removeExists",k)
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPLANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.pressPlants(x,y,z)
	vSERVER.pressPlants(x,y,z)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLEUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_weplants:tableUpdate")
AddEventHandler("vrp_weplants:tableUpdate",function(status)
	wePlants = status

	for k,v in pairs(wePlants) do
		if DoesEntityExist(weObjects[k]) then
			if v[4] == 40 then
				TriggerEvent("vrp_weplants:removeExists",k)
				createModels(k,weHashsB,v[1],v[2],v[3])
			elseif v[4] == 70 then
				TriggerEvent("vrp_weplants:removeExists",k)
				createModels(k,weHashsC,v[1],v[2],v[3])
			elseif v[4] == 100 then
				TriggerEvent("vrp_weplants:removeExists",k)
				createModels(k,weHashsD,v[1],v[2],v[3])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
function createModels(id,hash,x,y,z)
	local mHash = GetHashKey(hash)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	weObjects[id] = CreateObject(mHash,x,y,z,false,false,false)
	SetEntityAsMissionEntity(weObjects[id],true,true)
	PlaceObjectOnGroundProperly(weObjects[id])
	FreezeEntityPosition(weObjects[id],true)
	SetModelAsNoLongerNeeded(mHash)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEEXISTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_weplants:removeExists")
AddEventHandler("vrp_weplants:removeExists",function(id)
	if DoesEntityExist(weObjects[id]) then
		SetEntityAsMissionEntity(weObjects[id],false,false)
		DeleteEntity(weObjects[id])
		weObjects[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(x,y,z,text)
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
-- ENTITYINWORLDCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.entityInWorldCoords()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	if DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsA),true) or DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsB),true) or DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsC),true) or DoesObjectOfTypeExistAtCoords(x,y,z,0.6,GetHashKey(weHashsD),true) then
		return false
	end
	return true,x,y,z
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkWater()
	return IsEntityInWater(PlayerPedId())
end