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
Tunnel.bindInterface("vrp_gangs",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehicles = {}
local maxPackage = 100
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local functions = {
	{ "ecstasy" },
	{ "cpuchip" },
	{ "lean" },
	{ "cocaine" }
}

local active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_GANGS:ADDPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.addPackage(vehPlate)
	local source = source 
	local user_id = vRP.getUserId(source)
	if active[user_id] == nil then 
		active[user_id] = true
		if vehicles[vehPlate] == nil then
			vehicles[vehPlate] = 1
		else
			if vehicles[vehPlate] < maxPackage then
				vehicles[vehPlate] = vehicles[vehPlate] + 1
			else
				active[user_id] = nil
				return false
			end
		end
	
		TriggerClientEvent("vrp_gangs:updatePackage",-1,vehicles)
		active[user_id] = nil
		return true
	end	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod(x)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,functions[x][1],1,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_GANGS:REMPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_gangs:remPackage")
AddEventHandler("vrp_gangs:remPackage",function(vehPlate)
	local source = source 
	local user_id = vRP.getUserId(source)
	if active[user_id] == nil then 
		active[user_id] = true
		if vehicles[vehPlate] then
			vehicles[vehPlate] = vehicles[vehPlate] - 1
	
			if vehicles[vehPlate] <= 0 then
				vehicles[vehPlate] = nil
			end
	
			TriggerClientEvent("vrp_gangs:updatePackage",-1,vehicles)
			active[user_id] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_gangs:updatePackage",source,vehicles)
end)