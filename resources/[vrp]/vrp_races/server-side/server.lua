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
Tunnel.bindInterface("vrp_races",cRP)
vCLIENT = Tunnel.getInterface("vrp_races")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHRACES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkTicket()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if vRP.tryGetInventoryItem(user_id,"raceticket",1) then
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"Corredor",75)
			vRP.upgradeStress(user_id,5)
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod(vehPlate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.wantedTimer(user_id,30)
		TriggerEvent("vrp_blipsystem:serviceExit",source)
		vRP.giveInventoryItem(user_id,"dollars2",parseInt(math.random(4000,5000)),true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startRace()
	local copAmount = vRP.numPermission("Police")
	for k,v in pairs(copAmount) do
		async(function()
			TriggerClientEvent("NotifyPush",v,{ code = "QRU", title = "Corrida Ilegal", x = x, y = y, z = z, criminal = "Denuncia", rgba = {75,100,160} })
		end)
	end
end
------------------------------------------------------------------------------------------------------------------------------------------
-- EXPLOSION
------------------------------------------------------------------------------------------------------------------------------------------
function cRP.finishRaces()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("vrp_blipsystem:serviceExit",source)
	end
end