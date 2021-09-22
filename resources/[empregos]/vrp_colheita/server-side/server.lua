-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_colheita",cRP)
vCLIENT = Tunnel.getInterface("vrp_colheita")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local itensList = {
	[1] = "tomato",
	[2] = "strawberry",
	[3] = "banana",
	[4] = "orange"
}


function cRP.colletTomato()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
            TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
            return
        end

		vRP.giveInventoryItem(user_id,itensList[math.random(#itensList)],math.random(1,2),true)
		
		vRP.upgradeStress(user_id,1)
	end
end