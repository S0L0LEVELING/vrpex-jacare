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
Tunnel.bindInterface("ns_blitz", cRP)
vCLIENT = Tunnel.getInterface("ns_blitz")

function cRP.checkPermission(perm)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, perm) then
		return true
	else
		return false
	end
end