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
Tunnel.bindInterface("vrp_trucker",cRP)
vCLIENT = Tunnel.getInterface("vrp_trucker")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
          TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
        return
      end

		vRP.giveInventoryItem(user_id,"plastic",math.random(25,50),true)
        vRP.giveInventoryItem(user_id,"copper",math.random(25,50),true)
        vRP.giveInventoryItem(user_id,"glass",math.random(25,50),true)
		vRP.giveInventoryItem(user_id,"rubber",math.random(25,50),true)
		vRP.giveInventoryItem(user_id,"cloth",math.random(5,10),true)
	end
end