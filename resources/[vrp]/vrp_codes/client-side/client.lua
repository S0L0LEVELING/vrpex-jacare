-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 4

			if IsPedOnAnyBike(ped) then
				SetPedHelmet(ped,false)
				DisableControlAction(0,345,true)
			end

			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped then
				SetVehicleDirtLevel(veh,0.0)

				local speed = GetEntitySpeed(veh) * 2.236936
				if speed ~= oldSpeed then
					if (oldSpeed - speed) >= 60 then
						TriggerServerEvent("upgradeStress",10)

						if GetVehicleClass(veh) ~= 8 and (GetEntityModel(veh) ~= 1755270897 or GetEntityModel(veh) ~= -34623805) then
							SetVehicleEngineOn(veh,false,true,true)
							vehicleTyreBurst(veh)
						end
					end

					oldSpeed = speed
				end
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleTyreBurst(vehicle)
	local tyre = math.random(4)
	if tyre == 1 then
		if not IsVehicleTyreBurst(vehicle,0,false) then
			SetVehicleTyreBurst(vehicle,0,true,1000.0)
		end
	elseif tyre == 2 then
		if not IsVehicleTyreBurst(vehicle,1,false) then
			SetVehicleTyreBurst(vehicle,1,true,1000.0)
		end
	elseif tyre == 3 then
		if not IsVehicleTyreBurst(vehicle,4,false) then
			SetVehicleTyreBurst(vehicle,4,true,1000.0)
		end
	elseif tyre == 4 then
		if not IsVehicleTyreBurst(vehicle,5,false) then
			SetVehicleTyreBurst(vehicle,5,true,1000.0)
		end
	end

	if math.random(100) < 30 then
		Citizen.Wait(500)
		vehicleTyreBurst(vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBO NO F
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
    local timeDistance = 500
    local ped = PlayerPedId()
	if IsPedJacking(ped) then
		timeDistance = 4
      local veh = GetVehiclePedIsIn(ped)
      SetPedIntoVehicle(ped, veh, 0)
      ClearPedTasks(ped)
		end
		Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ -342.69,-138.23,39.01,402,17,"Mecanica",0.5 },
	{ 139.58,-3033.34,7.06,402,17,"Benny's",0.6 },
	{ 265.05,-1262.65,29.3,361,4,"Posto de Gasolina",0.4 },
	{ 819.02,-1027.96,26.41,361,4,"Posto de Gasolina",0.4 },
	{ 1208.61,-1402.43,35.23,361,4,"Posto de Gasolina",0.4 },
	{ 1181.48,-330.26,69.32,361,4,"Posto de Gasolina",0.4 },
	{ 621.01,268.68,103.09,361,4,"Posto de Gasolina",0.4 },
	{ 2581.09,361.79,108.47,361,4,"Posto de Gasolina",0.4 },
	{ 175.08,-1562.12,29.27,361,4,"Posto de Gasolina",0.4 },
	{ -319.76,-1471.63,30.55,361,4,"Posto de Gasolina",0.4 },
	{ 1782.33,3328.46,41.26,361,4,"Posto de Gasolina",0.4 },
	{ 49.42,2778.8,58.05,361,4,"Posto de Gasolina",0.4 },
	{ 264.09,2606.56,44.99,361,4,"Posto de Gasolina",0.4 },
	{ 1039.38,2671.28,39.56,361,4,"Posto de Gasolina",0.4 },
	{ 1207.4,2659.93,37.9,361,4,"Posto de Gasolina",0.4 },
	{ 2539.19,2594.47,37.95,361,4,"Posto de Gasolina",0.4 },
	{ 2679.95,3264.18,55.25,361,4,"Posto de Gasolina",0.4 },
	{ 2005.03,3774.43,32.41,361,4,"Posto de Gasolina",0.4 },
	{ 1687.07,4929.53,42.08,361,4,"Posto de Gasolina",0.4 },
	{ 1701.53,6415.99,32.77,361,4,"Posto de Gasolina",0.4 },
	{ 180.1,6602.88,31.87,361,4,"Posto de Gasolina",0.4 },
	{ -94.46,6419.59,31.48,361,4,"Posto de Gasolina",0.4 },
	{ -2555.17,2334.23,33.08,361,4,"Posto de Gasolina",0.4 },
	{ -1800.09,803.54,138.72,361,4,"Posto de Gasolina",0.4 },
	{ -1437.0,-276.8,46.21,361,4,"Posto de Gasolina",0.4 },
	{ -2096.3,-320.17,13.17,361,4,"Posto de Gasolina",0.4 },
	{ -724.56,-935.97,19.22,361,4,"Posto de Gasolina",0.4 },
	{ -525.26,-1211.19,18.19,361,4,"Posto de Gasolina",0.4 },
	{ -70.96,-1762.21,29.54,361,4,"Posto de Gasolina",0.4 },
	{ 298.43,-584.54,43.27,80,75,"Hospital",0.4 },
	{ 55.43,-876.19,30.66,289,4,"Garagem",0.4 },
	{ 317.25,2623.14,44.46,289,4,"Garagem",0.4 },
	{ -96.74,6324.1,31.58,289,4,"Garagem",0.4 },
	{ 275.23,-345.54,45.17,289,4,"Garagem",0.4 },
	{ 596.40,90.65,93.12,289,4,"Garagem",0.4 },
	{ -340.76,265.97,85.67,289,4,"Garagem",0.4 },
	{ -2030.01,-465.97,11.60,289,4,"Garagem",0.4 },
	{ -1184.92,-1510.00,4.64,289,4,"Garagem",0.4 },
	{ -73.44,-2004.99,18.27,289,4,"Garagem",0.4 },
	{ 214.02,-808.44,31.01,289,4,"Garagem",0.4 },
	{ -348.88,-874.02,31.31,289,4,"Garagem",0.4 },
	{ 67.74,12.27,69.21,289,4,"Garagem",0.4 },
	{ 361.90,297.81,103.88,289,4,"Garagem",0.4 },
	{ 1035.89,-763.89,57.99,289,4,"Garagem",0.4 },
	{ -796.63,-2022.77,9.16,289,4,"Garagem",0.4 },
	{ 453.27,-1146.76,29.52,289,4,"Garagem",0.4 },
	{ 528.66,-146.3,58.38,289,4,"Garagem",0.4 },
	{ -1159.48,-739.32,19.89,289,4,"Garagem",0.4 },
	{ 29.29,-1770.35,29.61,289,4,"Garagem",0.4 },
	{ 101.22,-1073.68,29.38,289,4,"Garagem",0.4 },
	-- { 440.9,-982.89,30.69,60,4,"Departamento Policial",0.6 },
	-- { 2519.01,-362.0,94.93,60,4,"Departamento Policial",0.6 },
	{ 2518.98,-360.64,94.12,60,30,"Departamento Policial",0.5 },
	{ 25.68,-1346.6,29.5,52,36,"Loja de Departamento",0.4 },
	{ 2556.47,382.05,108.63,52,36,"Loja de Departamento",0.4 },
	{ 1163.55,-323.02,69.21,52,36,"Loja de Departamento",0.4 },
	{ -707.31,-913.75,19.22,52,36,"Loja de Departamento",0.4 },
	{ -47.72,-1757.23,29.43,52,36,"Loja de Departamento",0.4 },
	{ 373.89,326.86,103.57,52,36,"Loja de Departamento",0.4 },
	{ -3242.95,1001.28,12.84,52,36,"Loja de Departamento",0.4 },
	{ 1729.3,6415.48,35.04,52,36,"Loja de Departamento",0.4 },
	{ 548.0,2670.35,42.16,52,36,"Loja de Departamento",0.4 },
	{ 1960.69,3741.34,32.35,52,36,"Loja de Departamento",0.4 },
	{ 2677.92,3280.85,55.25,52,36,"Loja de Departamento",0.4 },
	{ 1698.5,4924.09,42.07,52,36,"Loja de Departamento",0.4 },
	{ -1820.82,793.21,138.12,52,36,"Loja de Departamento",0.4 },
	{ 1393.21,3605.26,34.99,52,36,"Loja de Departamento",0.4 },
	{ -2967.78,390.92,15.05,52,36,"Loja de Departamento",0.4 },
	{ -3040.14,585.44,7.91,52,36,"Loja de Departamento",0.4 },
	{ 1135.56,-982.24,46.42,52,36,"Loja de Departamento",0.4 },
	{ 1166.0,2709.45,38.16,52,36,"Loja de Departamento",0.4 },
	{ -1487.21,-378.99,40.17,52,36,"Loja de Departamento",0.4 },
	{ -1222.76,-907.21,12.33,52,36,"Loja de Departamento",0.4 },
	{ 1692.62,3759.50,34.70,76,6,"Loja de Armas",0.4 },
	{ 252.89,-49.25,69.94,76,6,"Loja de Armas",0.4 },
	{ 843.28,-1034.02,28.19,76,6,"Loja de Armas",0.4 },
	{ -331.35,6083.45,31.45,76,6,"Loja de Armas",0.4 },
	{ -663.15,-934.92,21.82,76,6,"Loja de Armas",0.4 },
	{ -1305.18,-393.48,36.69,76,6,"Loja de Armas",0.4 },
	{ -1118.80,2698.22,18.55,76,6,"Loja de Armas",0.4 },
	{ 2568.83,293.89,108.73,76,6,"Loja de Armas",0.4 },
	{ -3172.68,1087.10,20.83,76,6,"Loja de Armas",0.4 },
	{ 21.32,-1106.44,29.79,76,6,"Loja de Armas",0.4 },
	{ 811.19,-2157.67,29.61,76,6,"Loja de Armas",0.4 },
	{ -1213.44,-331.02,37.78,207,2,"Banco",0.5 },
	{ -351.59,-49.68,49.04,207,2,"Banco",0.5 },
	{ 313.47,-278.81,54.17,207,2,"Banco",0.5 },
	{ 149.35,-1040.53,29.37,207,2,"Banco",0.5 },
	{ -2962.60,482.17,15.70,207,2,"Banco",0.5 },
	{ -112.81,6469.91,31.62,207,2,"Banco",0.5 },
	{ 1175.74,2706.80,38.09,207,2,"Banco",0.5 },
	{ -51.82,-1111.38,26.44,225,4,"Concessionaria",0.5 },
	{ 690.19,588.55,131.07,225,22,"Concessionaria Premium",0.5 },
	{ -815.12,-184.15,37.57,71,4,"Barbearia",0.5 },
	{ 138.13,-1706.46,29.3,71,4,"Barbearia",0.5 },
	{ -1280.92,-1117.07,7.0,71,4,"Barbearia",0.5 },
	{ 1930.54,3732.06,32.85,71,4,"Barbearia",0.5 },
	{ 1214.2,-473.18,66.21,71,4,"Barbearia",0.5 },
	{ -33.61,-154.52,57.08,71,4,"Barbearia",0.5 },
	{ -276.65,6226.76,31.7,71,4,"Barbearia",0.5 },
	{ 75.35,-1392.92,29.38,73,4,"Loja de Roupas",0.5 },
	{ -710.15,-152.36,37.42,73,4,"Loja de Roupas",0.5 },
	{ -163.73,-303.62,39.74,73,4,"Loja de Roupas",0.5 },
	{ -822.38,-1073.52,11.33,73,4,"Loja de Roupas",0.5 },
	{ -1193.13,-767.93,17.32,73,4,"Loja de Roupas",0.5 },
	{ -1449.83,-237.01,49.82,73,4,"Loja de Roupas",0.5 },
	{ 4.83,6512.44,31.88,73,4,"Loja de Roupas",0.5 },
	{ 1693.95,4822.78,42.07,73,4,"Loja de Roupas",0.5 },
	{ 125.82,-223.82,54.56,73,4,"Loja de Roupas",0.5 },
	{ 614.2,2762.83,42.09,73,4,"Loja de Roupas",0.5 },
	{ 1196.72,2710.26,38.23,73,4,"Loja de Roupas",0.5 },
	{ -3170.53,1043.68,20.87,73,4,"Loja de Roupas",0.5 },
	{ -1101.42,2710.63,19.11,73,4,"Loja de Roupas",0.5 },
	{ 425.6,-806.25,29.5,73,4,"Loja de Roupas",0.5 },
	{ -1082.22,-247.54,37.77,439,4,"Life Invader",0.6 },
	{ -1728.06,-1050.69,1.71,266,4,"Embarcações",0.5 },
	{ 1966.36,3975.86,31.51,266,4,"Embarcações",0.5 },
	{ -776.72,-1495.02,2.29,266,4,"Embarcações",0.5 },
	{ -893.97,5687.78,3.29,266,4,"Embarcações",0.5 },
	{ 468.11,-585.95,28.5,513,4,"Motorista",0.5 },
	{ -837.97,5406.55,34.59,285,4,"Lenhador",0.5 },
	{ -1038.11,-1396.97,5.56,68,4,"La Spada",0.5 },  
	{ 1971.85,4207.1,29.84,68,4,"Pescador",0.5 },
	{ 132.6,-1305.06,29.2,93,4,"Bar",0.5 },
	{ -565.14,271.56,83.02,93,4,"Bar",0.5 },
	{ 84.23,-1552.15,29.6,318,4,"Lixeiro",0.5 },
	{ 4.58,-705.95,45.98,351,4,"Escritório",0.5 },
	{ -117.29,-604.52,36.29,351,4,"Escritório",0.5 },
	{ -826.9,-699.89,28.06,351,4,"Escritório",0.5 },
	{ -935.68,-378.77,38.97,351,4,"Escritório",0.5 },
	{ 237.81,-413.08,48.12,498,8,"Cartório",0.6 },
	{ 46.66,-1749.79,29.64,78,11,"Mega Mall",0.5 },
	{ 2747.3,3473.09,55.68,78,11,"Mega Mall",0.5 },
	{ 47.73,-996.67,29.35,77,4,"Legion Hotdog",0.5 },
	{ -428.59,-1728.28,19.79,467,11,"Reciclagem",0.6 },
	{ -653.38,-852.87,24.51,459,11,"Eletrônicos",0.6 },
	{ 392.7,-831.61,29.3,459,11,"Eletrônicos",0.6 },
	{ -41.37,-1036.79,28.49,459,11,"Eletrônicos",0.6 },
	{ -509.38,278.8,83.33,459,11,"Eletrônicos",0.6 },
	{ 1137.52,-470.69,66.67,459,11,"Eletrônicos",0.6 },
	{ 408.17,-1635.57,29.3,515,4,"Reboque",0.7 },
	{ 1706.07,4791.75,41.98,515,4,"Reboque",0.7 },
	{ 909.8,-176.49,74.23,56,4,"Taxista",0.6 },
	{ -439.03,-2796.89,7.3,478,4,"Entregador",0.6 },
	{ 1322.93,-1652.29,52.27,75,4,"Loja de Tatuagem",0.5 },
	{ -1154.42,-1425.9,4.95,75,4,"Loja de Tatuagem",0.5 },
	{ 322.84,180.16,103.58,75,4,"Loja de Tatuagem",0.5 },
	{ -3169.62,1075.8,20.83,75,4,"Loja de Tatuagem",0.5 },
	{ 1864.07,3747.9,33.03,75,4,"Loja de Tatuagem",0.5 },
	{ -293.57,6199.85,31.48,75,4,"Loja de Tatuagem",0.5 },
	{ -772.32,5594.92,33.48,141,4,"Cabana do Caçador",0.5 },
	{ -1172.19,-1571.76,4.67,140,4,"Smoke On The Water",0.5 },
	{ -892.89,-782.37,15.92,512,4,"Bicicletario",0.5 },
	{ -1220.81,-1495.79,4.34,512,4,"Bicicletario",0.5 },
}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 1000
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		N_0xf4f2c0d4ee209e20()
		DistantCopCarSirens(false)

		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL50"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"),0.8)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"),0.8)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HATCHET"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BATTLEAXE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BOTTLE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DAGGER"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HAMMER"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_STONE_HATCHET"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WRENCH"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMPACTRIFLE"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MINISMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VINTAGEPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUSENBERG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAWNOFFSHOTGUN"),1.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"),2.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 5
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		DisableControlAction(1,192,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,157,false)
		DisableControlAction(1,158,false)
		DisableControlAction(1,160,false)
		DisableControlAction(1,164,false)
		DisableControlAction(1,165,false)
		DisableControlAction(1,159,false)
		DisableControlAction(1,161,false)
		DisableControlAction(1,162,false)
		DisableControlAction(1,163,false)
		
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_KNIFE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PISTOL"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_MINISMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_SMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PUMPSHOTGUN"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_CARBINERIFLE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_COMBATPISTOL"))

		DisablePlayerVehicleRewards(PlayerId())

		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			SetPedInfiniteAmmo(ped,true,"WEAPON_FIREEXTINGUISHER")
		end
		Citizen.Wait(5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 0
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",false,true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
	AddTextEntry("FE_THDR_GTAO","ANGRA CITY")
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("PlayerOnDLCHeist4Island",true)
	SetAudioFlag("PoliceScannerDisabled",true)
	SetPlayerCanUseCover(PlayerId(),false)
	SetDeepOceanScaler(0.0)

	while true do
		Citizen.Wait(0)

		SetRandomBoats(false)
		SetGarbageTrucks(false)
		SetCreateRandomCops(false)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetPedHelmet(PlayerPedId(),false)
		DisablePlayerVehicleRewards(PlayerId())
		SetParkedVehicleDensityMultiplierThisFrame(0.50)
		SetVehicleDensityMultiplierThisFrame(0.50)
		SetRandomVehicleDensityMultiplierThisFrame(0.50)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,12 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECOIL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedArmed(ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			Citizen.Wait(1)
		else
			Citizen.Wait(1000)
		end

		if IsPedShooting(ped) then
			local cam = GetFollowPedCamViewMode()
			local veh = IsPedInAnyVehicle(ped)
			
			local speed = math.ceil(GetEntitySpeed(ped))
			if speed > 70 then
				speed = 70
			end

			local _,wep = GetCurrentPedWeapon(ped)
			local class = GetWeapontypeGroup(wep)
			local p = GetGameplayCamRelativePitch()
			local camDist = #(GetGameplayCamCoord() - GetEntityCoords(ped))

			local recoil = math.random(110,120+(math.ceil(speed*0.5)))/100
			local rifle = false

			if class == 970310034 or class == 1159398588 then
				rifle = true
			end

			if camDist < 5.3 then
				camDist = 1.5
			else
				if camDist < 8.0 then
					camDist = 4.0
				else
					camDist =  7.0
				end
			end

			if veh then
				recoil = recoil + (recoil * camDist)
			else
				recoil = recoil * 0.1
			end

			if cam == 4 then
				recoil = recoil * 0.6
				if rifle then
					recoil = recoil * 0.1
				end
			end

			if rifle then
				recoil = recoil * 0.6
			end

			local spread = math.random(4)
			local h = GetGameplayCamRelativeHeading()
			local hf = math.random(10,40+speed) / 100

			if veh then
				hf = hf * 2.0
			end

			if spread == 1 then
				SetGameplayCamRelativeHeading(h+hf)
			elseif spread == 2 then
				SetGameplayCamRelativeHeading(h-hf)
			end

			local set = p + recoil
			SetGameplayCamRelativePitch(set,0.8)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(500)
	end
end

local agachar = false
local movimento = false
local ctrl = 0
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(5)
        local ped = PlayerPedId()
		if DoesEntityExist(ped) and not IsEntityDead(ped) then 
            if not IsPauseMenuActive() then 
                if IsPedJumping(ped) then
                    movimento = false
                end
            end
        end
        if DoesEntityExist(ped) and not IsEntityDead(ped) then 
            DisableControlAction(0,36,true)
            if not IsPauseMenuActive() then 
				if IsDisabledControlJustPressed(0,36) and not IsPedInAnyVehicle(ped) and ctrl == 0 then
					ctrl = 1
                    RequestAnimSet('move_ped_crouched')
                    RequestAnimSet('move_ped_crouched_strafing')
                    if agachar == true then 
                        ResetPedMovementClipset(ped,0.30)
                        ResetPedStrafeClipset(ped)
                        movimento = false
                        agachar = false 
                    elseif agachar == false then
                        SetPedMovementClipset(ped,'move_ped_crouched',0.30)
                        SetPedStrafeClipset(ped,'move_ped_crouched_strafing')
                        agachar = true 
                    end 
                end
            end 
		end 
    end
end)

Citizen.CreateThread(function() 
    while true do
        Wait(0)
        if agachar then DisablePlayerFiring(PlayerId(), true) end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if ctrl > 0 then
			ctrl = ctrl - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	LoadInterior(GetInteriorAtCoords(313.36,-591.02,43.29))
	LoadInterior(GetInteriorAtCoords(440.84,-983.14,30.69))
	LoadInterior(GetInteriorAtCoords(1768.09,3327.09,41.45))

	for _,v in pairs(allIpls) do
		loadInt(v.coords,v.interiorsProps)
	end
end)

function loadInt(coordsTable,table)
	for _,v in pairs(coordsTable) do
		local interior = GetInteriorAtCoords(v[1],v[2],v[3])
		LoadInterior(interior)
		for _,i in pairs(table) do
			EnableInteriorProp(interior,i)
			Citizen.Wait(10)
		end
		RefreshInterior(interior)
	end
end

allIpls = {
	{
		interiorsProps = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = {{ -1150.7,-1520.7,10.6 }}
	},{
		interiorsProps = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = {{ -47.1,-1115.3,26.5 }}
	},{
		interiorsProps = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = {{ -802.3,175.0,72.8 }}
	},{
		interiorsProps = {
			"meth_lab_production",
			"meth_lab_upgrade",
			"meth_lab_setup"
		},
		coords = {{ 38.49,3714.1,11.01 }}
	},{
		interiorsProps = {
			"patoche_elevatorb_door"
		},
		coords = {{ -229.3393,-1338.831,32.48326 }}
	},{
		interiorsProps = {
			"patoche_elevatorb_door"
		},
		coords = {{ -229.3393,-1338.831,20.05319 }}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedBeingStunned(ped) then
			timeDistance = 4
			SetPedToRagdoll(ped,7500,7500,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			timeDistance = 4
			TriggerEvent("cancelando",true)
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			Citizen.Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local teleport = {
	{ 936.02,47.23,81.1,1089.69,205.79,-48.99,"ENTRAR" }, --CASINO 1
	{ 1089.69,205.79,-48.99,936.02,47.23,81.1,"SAIR" },

	{ 1139.25,234.4,-50.44,965.03,58.41,112.56,"SUBIR" }, --CASINO 2
	{ 964.99,58.38,112.56,1139.25,234.4,-50.44,"DESCER" },

	{ 332.42,-595.67,43.29,359.56,-584.9,28.82,"DESCER" }, -- HOSPITAL 1
	{ 359.56,-584.9,28.82,332.42,-595.67,43.29,"SUBIR" },

	{ 330.43,-601.17,43.29,338.59,-583.75,74.17,"SUBIR" }, -- HOSPITAL HELI
	{ 338.59,-583.75,74.17,330.43,-601.17,43.29,"DESCER" },

	{ 253.96,225.2,101.88,252.3,220.23,101.69,"ENTRAR" }, -- BANCO CENTRAL
	{ 252.3,220.23,101.69,253.96,225.2,101.88,"SAIR" },

	{ 4.58,-705.95,45.98,-139.85,-627.0,168.83,"ENTRAR" }, -- UNION 
	{ -139.85,-627.0,168.83,4.58,-705.95,45.98,"SAIR" },

	{ -117.29,-604.52,36.29,-74.48,-820.8,243.39,"ENTRAR" }, -- ARCADIUS
	{ -74.48,-820.8,243.39,-117.29,-604.52,36.29,"SAIR" },

	{ -826.9,-699.89,28.06,-1575.14,-569.15,108.53,"ENTRAR" }, --WIWANG
	{ -1575.14,-569.15,108.53,-826.9,-699.89,28.06,"SAIR" },

	{ -935.68,-378.77,38.97,-1386.84,-478.56,72.05,"ENTRAR" }, -- RICHARDS
	{ -1386.84,-478.56,72.05,-935.68,-378.77,38.97,"SAIR" },

	{ 13.24,3732.18,39.68,28.1,3711.62,13.6,"ENTRAR" }, -- META
	{ 28.1,3711.62,13.6,13.24,3732.18,39.68,"SAIR" },

	{ 241.14,-1378.93,33.75,275.8,-1361.48,24.54,"ENTRAR" }, -- 
	{ 275.8,-1361.48,24.54,241.14,-1378.93,33.75,"SAIR" },

	{ 232.89,-411.39,48.12,224.63,-360.7,-98.78,"ENTRAR" }, -- CARTORIO
	{ 224.63,-360.7,-98.78,232.89,-411.39,48.12,"SAIR" },

	{ 234.33,-387.57,-98.78,244.34,-429.14,-98.78,"ENTRAR" }, -- CARTORIO V2
	{ 244.34,-429.14,-98.78,234.33,-387.57,-98.78,"SAIR" }
}

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(teleport) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   "..v[7])
					if IsControlJustPressed(1,38) then
						DoScreenFadeOut(1000)
						Citizen.Wait(2000)
						SetEntityCoords(ped,v[4],v[5],v[6])
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NPC NÂO DROPAR ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetWeaponDrops()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLESUPPRESSED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local SUPPRESSED_MODELS = { "DUMP", }
	while true do
		for _,model in next,SUPPRESSED_MODELS do
			SetVehicleModelIsSuppressed(GetHashKey(model),true)
		end
		Wait(10000)
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