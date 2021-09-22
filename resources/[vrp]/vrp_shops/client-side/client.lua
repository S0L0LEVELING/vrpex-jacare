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
Tunnel.bindInterface("vrp_shops",cRP)
vSERVER = Tunnel.getInterface("vrp_shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,weight,maxweight,infos = vSERVER.requestShop(data.shop)
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data,cb)
	vSERVER.functionShops(data.shop,data.item,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("vrp_shops:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("vrp_shops:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_SHOPS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_shops:Update")
AddEventHandler("vrp_shops:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ -455.64,1603.99,361.12,"departamentStore",true,false },
	{ 1164.3,3323.05,50.74,"departamentStore",true,false },
	{ 25.68,-1346.6,29.5,"departamentStore",true,false },
	{ 2556.47,382.05,108.63,"departamentStore",true,false },
	{ 1163.55,-323.02,69.21,"departamentStore",true,false },
	{ -707.31,-913.75,19.22,"departamentStore",true,false },
	{ -47.72,-1757.23,29.43,"departamentStore",true,false },
	{ 373.89,326.86,103.57,"departamentStore",true,false },
	{ -3242.95,1001.28,12.84,"departamentStore",true,false },
	{ 1729.3,6415.48,35.04,"departamentStore",true,false },
	{ 548.0,2670.35,42.16,"departamentStore",true,false },
	{ 1960.69,3741.34,32.35,"departamentStore",true,false },
	{ 2677.92,3280.85,55.25,"departamentStore",true,false },
	{ 1698.5,4924.09,42.07,"departamentStore",true,false },
	{ -1820.82,793.21,138.12,"departamentStore",true,false },
	{ 1393.21,3605.26,34.99,"departamentStore",true,false },
	{ -2967.78,390.92,15.05,"departamentStore",true,false },
	{ -3040.14,585.44,7.91,"departamentStore",true,false },
	{ 1135.56,-982.24,46.42,"departamentStore",true,false },
	{ 1166.0,2709.45,38.16,"departamentStore",true,false },
	{ 4903.15,-4940.73,3.37,"departamentStore",true,false },
	{ -1487.21,-378.99,40.17,"departamentStore",true,false },
	{ -1222.76,-907.21,12.33,"departamentStore",true,false },
	{ 1692.62,3759.50,34.70,"ammunationStore",true,false },
	{ 252.89,-49.25,69.94,"ammunationStore",true,false },
	{ 843.28,-1034.02,28.19,"ammunationStore",true,false },
	{ -331.35,6083.45,31.45,"ammunationStore",true,false },
	{ -663.15,-934.92,21.82,"ammunationStore",true,false },
	{ -1305.18,-393.48,36.69,"ammunationStore",true,false },
	{ -1118.80,2698.22,18.55,"ammunationStore",true,false },
	{ 2568.83,293.89,108.73,"ammunationStore",true,false },
	{ -3172.68,1087.10,20.83,"ammunationStore",true,false },
	{ 21.32,-1106.44,29.79,"ammunationStore",true,false },
	{ 811.19,-2157.67,29.61,"ammunationStore",true,false },
	{ -1082.22,-247.54,37.77,"premiumStore",false,false },
	{ -1037.57,-1397.13,5.56,"fishingSell",false,false },
	{ 308.84,-562.29,43.29,"pharmacyStore",false,false },
	{ 229.39,-369.77,-98.78,"registryStore",false,false },
	{ 46.66,-1749.79,29.64,"megaMallStore",false,false },
	{ 2747.34,3473.01,55.68,"megaMallStore",false,false },
	{ -428.54,-1728.29,19.78,"recyclingSell",false,false },
	{ 719.03,-961.58,30.4,"lester",false,false },
	{ 716.56,-961.59,30.4,"lester2",false,false },
	{ -656.84,-857.51,24.5,"digitalDen",true,false },
	{ 392.7,-831.61,29.3,"digitalDen",true,false },
	{ -41.37,-1036.79,28.49,"digitalDen",true,false },
	{ -509.38,278.8,83.33,"digitalDen",true,false },
	{ 1137.52,-470.69,66.67,"digitalDen",true,false },
	{ 42.24,-1008.38,29.55,"foodGrill",false,false },
	{ 43.58,-1008.97,29.65,"foodFridge",false,false },
	{ 2488.55,-378.37,82.7,"policeStore",false,false },
--	{ 1781.75,2588.74,49.72,"policeStore",false,false },
	{ -1172.11,-1571.84,4.67,"smoke",false,false },
	{ 1134.83,3358.03,47.06,"comedyBar",false,false },
	{ 988.65,-94.18,74.85,"comedyBar",false,false },
	{ 1982.12,3052.95,47.22,"comedyBar",false,false },
	{ 416.41,-1902.86,25.62,"redCash",false,false },
}
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
			for k,v in pairs(shopList) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   ABRIR")
					if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[4]) then
						SetNuiFocus(true,true)
						TransitionToBlurred(1000)
						SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
						if v[5] then
							TriggerEvent("vrp_sound:source","shop",0.5)
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPSHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local propShops = {
	{ "prop_vend_coffe_01","coffeeMachine" },
	{ "prop_vend_soda_02","sodaMachine" },
	{ "prop_vend_soda_01","colaMachine" },
	{ "v_ret_247_donuts","donutMachine" },
	{ "prop_burgerstand_01","burgerMachine" },
	{ "prop_hotdogstand_01","hotdogMachine" },
	{ "prop_vend_water_01","waterMachine" }
}

RegisterCommand("comprar",function(source,args)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(propShops) do
		if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey(v[1]),true) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = tostring(v[2]), type = vSERVER.getShopType(v[2]) })
		end
	end
end)
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
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end