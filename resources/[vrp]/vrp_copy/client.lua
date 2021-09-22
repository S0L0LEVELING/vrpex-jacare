local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_copy",src)
Proxy.addInterface("vrp_copy",src)
acClient = Tunnel.getInterface("vrp_copy")

RegisterNUICallback("loadNuis", function(data, cb)
	acClient.pegaTrouxa()
end)


