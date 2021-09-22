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
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuels = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentFuel(price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,parseInt(price)) then
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GALLONBUYING
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.gallonBuying()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local request = vRP.request(source,"Deseja comprar um <b>Galão</b> por <b>$250</b>?",30)
		if request then
			if vRP.paymentBank(user_id,250) then
				vRP.giveInventoryItem(user_id,"WEAPON_PETROLCAN",1)
				vRP.giveInventoryItem(user_id,"WEAPON_PETROLCAN_AMMO",4500)
				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_engine:tryFuel")
AddEventHandler("vrp_engine:tryFuel",function(vehicle,fuel)
	vehFuels[vehicle] = fuel
	TriggerClientEvent("vrp_engine:syncFuel",-1,vehicle,fuel)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_engine:syncFuelPlayers",source,vehFuels)
end)