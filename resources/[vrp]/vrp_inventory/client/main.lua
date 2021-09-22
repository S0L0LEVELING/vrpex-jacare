-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_inventory",func)
vSERVER = Tunnel.getInterface("vrp_inventory")

local currentWeapon = nil
local currentWeaponModel = nil
local takingWeapon = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEWEAPONN
-----------------------------------------------------------------------------------------------------------------------------------------
local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"PISTOL":"0x1B06D571","PISTOL_MK2":"0xBFE256D4","COMBATPISTOL":"0x5EF9FEC4","APPISTOL":"0x22D8FE39","STUNGUN":"0x3656C8C1","PISTOL50":"0x99AEEB3B","SNSPISTOL":"0xBFD21232","SNSPISTOL_MK2":"0x88374054","HEAVYPISTOL":"0xD205520E","VINTAGEPISTOL":"0x83839C4","FLAREGUN":"0x47757124","MARKSMANPISTOL":"0xDC4DB296","REVOLVER":"0xC1B3C3D1","REVOLVER_MK2":"0xCB96392F","DOUBLEACTION":"0x97EA20B8","RAYPISTOL":"0xAF3696A1"},"smg":{"MICROSMG":"0x13532244","SMG":"0x2BE6766B","SMG_MK2":"0x78A97CD0","ASSAULTSMG":"0xEFE7E2DF","COMBATPDW":"0xA3D4D34","MACHINEPISTOL":"0xDB1AA450","MINISMG":"0xBD248B55","RAYCARBINE":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"ASSAULTRIFLE":"0xBFEFFF6D","ASSAULTRIFLE_MK2":"0x394F415C","CARBINERIFLE":"0x83BF0278","CARBINERIFLE_MK2":"0xFAD1F1C9","ADVANCEDRIFLE":"0xAF113F99","SPECIALCARBINE":"0xC0A3098D","SPECIALCARBINE_MK2":"0x969C3D67","BULLPUPRIFLE":"0x7F229F94","BULLPUPRIFLE_MK2":"0x84D6FAFD","COMPACTRIFLE":"0x624FE830"},"MACHINE_GUNS":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}')
Citizen.CreateThread(function()
	while true do
		local slyphe = 500
		local ped = PlayerPedId()
		local player = GetPlayerPed(-1)
		local status = {}
		if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
			slyphe = 1
			if IsPedShooting(player) then
				local weapon = GetSelectedPedWeapon(player)
				local ammoTotal = GetAmmoInPedWeapon(player,weapon)

				for key,value in pairs(AllWeapons) do
					for keyTwo,valueTwo in pairs(AllWeapons[key]) do
						if weapon == GetHashKey('weapon_'..keyTwo) then
							TriggerServerEvent("updateWeaponAmmo","WEAPON_"..keyTwo,ammoTotal)
						end
					end
				end
			end
		end
		Citizen.Wait(slyphe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data,cb)
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.closeInventory()
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moc",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 101 then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)

		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "showMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("moc","Inventario","keyboard","oem_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
    TriggerServerEvent("vrp_inventory:dropItem",data.item,data.amount,true)
end)
function func.dropItem(item,amount)
    TriggerServerEvent("vrp_inventory:dropItem",item,amount,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem",function(data)
    print(json.encode(data))
    TriggerServerEvent("itemdrop:Pickup",data.id,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
    TriggerServerEvent("vrp_inventory:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local droplist = {}
local cooldown = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Remove")
AddEventHandler("itemdrop:Remove",function(id)
	if droplist[id] ~= nil then
		droplist[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Players")
AddEventHandler("itemdrop:Players",function(id,marker)
	droplist[id] = marker
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Update")
AddEventHandler("itemdrop:Update",function(status)
	droplist = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(droplist) do
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
            local distance = #(coords - vector3(v.x,v.y,cdz))
            if distance <= 15 then
               timeDistance = 4
               DrawMarker(28,v.x,v.y,cdz+0.1,0,0,0,180.0,0,0,0.05,0.05,0.05,0,129,254,100,0,0,0,0)
			end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	TriggerServerEvent("vrp_inventory:useItem",data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
		-- RemoveAllPedWeapons(ped, false)
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerServerEvent("vrp_inventory:sendItem",data.item,data.amount)
	else
		TriggerServerEvent("vrp_inventory:sendItem",data.item,data.amount)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("vrp_inventory:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local dropItems = {}
	for k,v in pairs(droplist) do
		local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
		if GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true) <= 1.5 then
			table.insert(dropItems,{ name = v.name, key = v.name, amount = v.count, index = v.index, peso = v.peso, desc = v.desc, id = k })
		end
	end

	local inventario,peso,maxpeso,infos = vSERVER.Mochila()
	if inventario then
		cb({ inventario = inventario, drop = dropItems, peso = peso, maxpeso = maxpeso, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_inventory:Update")
AddEventHandler("vrp_inventory:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local plateX = -1133.31
local plateY = 2694.2
local plateZ = 18.81
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(plateX,plateY,plateZ))
			if distance <= 50.0 then
				timeDistance = 4
				DrawMarker(23,plateX,plateY,plateZ-0.98,0,0,0,0,0,0,5.0,5.0,1.0,255,0,0,50,0,0,0,0)
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function func.plateDistance()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(plateX,plateY,plateZ))
			if distance <= 3.0 then
				FreezeEntityPosition(vehicle,true)
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - COLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.plateApply(plate)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleNumberPlateText(vehicle,plate)
		FreezeEntityPosition(vehicle,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_inventory:repairVehicle")
AddEventHandler("vrp_inventory:repairVehicle",function(index,status)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			local fuel = GetVehicleFuelLevel(v)
			if status then
				SetVehicleFixed(v)
				SetVehicleDeformationFixed(v)
			end
			SetVehicleBodyHealth(v,1000.0)
			SetVehicleEngineHealth(v,1000.0)
			SetVehiclePetrolTankHealth(v,1000.0)
			SetVehicleFuelLevel(v,fuel)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRTIRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_inventory:repairTires")
AddEventHandler("vrp_inventory:repairTires",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			for i = 0,8 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCKPICKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_inventory:lockpickVehicle")
AddEventHandler("vrp_inventory:lockpickVehicle",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,true,true)
			if GetVehicleDoorsLockedForPlayer(v,PlayerId()) == 1 then
				SetVehicleDoorsLocked(v,false)
				SetVehicleDoorsLockedForAllPlayers(v,false)
			else
				SetVehicleDoorsLocked(v,true)
				SetVehicleDoorsLockedForAllPlayers(v,true)
			end
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
			Wait(200)
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockButtons = false
function func.blockButtons(status)
	blockButtons = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if blockButtons then
			timeDistance = 4
			DisableControlAction(1,73,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,105,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,288,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.parachuteColors()
	vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1 }})
	SetPedParachuteTintIndex(PlayerPedId(),math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKFOUNTAIN
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkFountain()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler"),true) or DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler_dark"),true) then
		return true,"fountain"
	end

	if IsEntityInWater(ped) then
		return true,"floor"
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASHREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
local registerCoords = {}
function func.cashRegister()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(registerCoords) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 1 then
			return false,v[1],v[2],v[3]
		end
	end

	local object = GetClosestObjectOfType(coords,0.4,GetHashKey("prop_till_01"),0,0,0)
	if DoesEntityExist(object) then
		SetEntityHeading(ped,GetEntityHeading(object)-360.0)
		local coords = GetEntityCoords(object)
		return true,coords.x,coords.y,coords.z
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_inventory:updateRegister")
AddEventHandler("vrp_inventory:updateRegister",function(status)
	registerCoords = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.fishingStatus()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(1971.85,4207.1,29.84))
	if distance <= 150 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function func.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WCOMPONENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local wComponents = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_PISTOL_MK2"] = {
		"COMPONENT_AT_PI_RAIL",
		"COMPONENT_AT_PI_FLSH_02",
		"COMPONENT_AT_PI_COMP"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_AT_SCOPE_MACRO"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02",
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_SUPP_02"
	},
	["WEAPON_COMBATPDW"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_AR_AFGRIP",
		"COMPONENT_AT_SCOPE_SMALL"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_AT_AR_FLSH"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_MACHINEPISTOL"] = {
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_AT_AR_AFGRIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		"COMPONENT_AT_PI_FLSH_03",
		"COMPONENT_AT_PI_RAIL_02",
		"COMPONENT_AT_PI_COMP_02"
	},
	["WEAPON_SMG_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_SMALL",
		"COMPONENT_AT_AR_SUPP"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_SPECIALCARBINE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	for k,v in pairs(wComponents) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.putWeaponHands(weapon)
	if not takingWeapon then
	    local ped = GetPlayerPed(-1)
	    local wep = GetHashKey(weapon)
	    if not HasPedGotWeapon(ped, GetHashKey(currentWeapon), false) then
	    	currentWeapon = wep
	    	currentWeaponModel = weapon
				vRP.giveWeapons({[weapon] = { ammo = 0 }})
	    else
	    	RemoveWeaponFromPed(ped, GetHashKey(currentWeapon))
	    	currentWeapon = nil
	    	currentWeaponModel = nil
    	end
    end
end

function func.removeWeaponInHand()
	local ped = GetPlayerPed(-1)
	if HasPedGotWeapon(ped, GetHashKey(currentWeapon), false) then
		RemoveWeaponFromPed(ped, GetHashKey(currentWeapon))
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerEvent('vrp_inventory:takingWeapon', false)		
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON_AMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_ammos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_COMPACTRIFLE",
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_SMG_MK2",
		"WEAPON_ASSAULTSMG",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_SPECIALCARBINE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_MUSKET"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_SAWNOFFSHOTGUN"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function func.rechargeCheck(ammoType)
	local ped = PlayerPedId()
	if weapon_ammos[ammoType] then
		for k,v in pairs(weapon_ammos[ammoType]) do
			if HasPedGotWeapon(ped,v) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function func.rechargeWeapon(ammoType,ammoAmount)
	local ped = PlayerPedId()
	if weapon_ammos[ammoType] then
		for k,v in pairs(weapon_ammos[ammoType]) do
			if HasPedGotWeapon(ped,v) then
				AddAmmoToPed(ped,v,parseInt(ammoAmount))
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function func.rechargeWeapon2(ammoType,ammoAmount)
	local ped = PlayerPedId()
	AddAmmoToPed(ped,ammoType,parseInt(ammoAmount))
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINEDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local adrenalineCds = {
	{ 1978.76,5171.11,47.64 },
	{ 707.86,4183.95,40.71 },
	{ 436.64,6462.23,28.75 },
	{ -2173.5,4291.73,49.04 }
}

function func.adrenalineDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(adrenalineCds) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 5 then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local firecracker = nil
RegisterNetEvent("vrp_inventory:Firecracker")
AddEventHandler("vrp_inventory:Firecracker",function()
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			RequestNamedPtfxAsset("scr_indep_fireworks")
			Citizen.Wait(10)
		end
	end

	local mHash = GetHashKey("ind_prop_firework_03")

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	local explosives = 25
	local ped = PlayerPedId()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.6,0.0)
	firecracker = CreateObjectNoOffset(mHash,coords.x,coords.y,coords.z,true,false,false)

	PlaceObjectOnGroundProperly(firecracker)
	FreezeEntityPosition(firecracker,true)
	SetModelAsNoLongerNeeded(mHash)

	Citizen.Wait(10000)

	repeat
		UseParticleFxAssetNextCall("scr_indep_fireworks")
		local explode = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",coords.x,coords.y,coords.z,0.0,0.0,0.0,2.5,false,false,false,false)
		explosives = explosives - 1

		Citizen.Wait(2000)
	until explosives == 0

	TriggerServerEvent("tryDeleteEntity",ObjToNet(firecracker))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TECHDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.techDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(1174.66,2640.45,37.82))
	if distance <= 10 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.animalDistance()
	local pedId = false
	local searching = false
	local random,animal = FindFirstPed()

	repeat
		local coords = GetEntityCoords(animal)
		local coordsPed = GetEntityCoords(PlayerPedId())
		local distance = #(coords - coordsPed)
		if IsPedDeadOrDying(animal) and not IsPedAPlayer(animal) and GetPedType(animal) == 28 and distance <= 1.5 then
			pedId = PedToNet(animal)
			break
		end

		searching,animal = FindNextPed(random)
	until not searching
	EndFindPed(random)

	return pedId
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local divingMask = nil
local divingTank = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- TECHDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.setDiving()
	local ped = PlayerPedId()

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			SetEntityAsMissionEntity(divingMask,false,false)
			DeleteObject(divingMask)
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			SetEntityAsMissionEntity(divingTank,false,false)
			DeleteObject(divingTank)
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	else
		local tankModel = GetHashKey("p_s_scuba_tank_s")
		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end

		local maskModel = GetHashKey("p_d_scuba_mask_s")
		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end

		divingTank = CreateObjectNoOffset(tankModel,1.0,1.0,1.0,true,false,false)
		AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
		SetEntityAsMissionEntity(divingTank,true,true)
		SetEntityAsNoLongerNeeded(divingTank)
		SetModelAsNoLongerNeeded(divingTank)

		divingMask = CreateObjectNoOffset(maskModel,1.0,1.0,1.0,true,false,false)
		AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
		SetEntityAsMissionEntity(divingMask,true,true)
		SetEntityAsNoLongerNeeded(divingMask)
		SetModelAsNoLongerNeeded(divingMask)

		SetEnableScuba(ped,true)
		SetPedMaxTimeUnderwater(ped,2000.0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COWCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local cowCoords = {
	{ 954.66,-2245.76,30.58 },
	{ 955.52,-2235.34,30.58 },
	{ 955.88,-2231.89,30.6 },
	{ 956.68,-2222.24,30.58 },
	{ 957.08,-2218.57,30.58 },
	{ 957.8,-2208.96,30.6 },
	{ 958.26,-2205.3,30.58 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COWDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.cowDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(cowCoords) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 0.8 then
			return true
		end
	end

	return false
end