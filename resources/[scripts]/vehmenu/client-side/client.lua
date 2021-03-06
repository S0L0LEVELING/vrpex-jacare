-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehMenu = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vehControl",function(source,args)
	if not vehMenu then
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) and GetEntityHealth(ped) > 101 then
			local vehicle = vRP.vehList(7)
			if vehicle then
				SendNUIMessage({ show = true })
				SetCursorLocation(0.5,0.8)
				SetNuiFocus(true,true)
				vehMenu = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("vehControl","Abrir o menu rapido.","keyboard","f5")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	SendNUIMessage({ show = false })
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	vehMenu = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENUACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("menuActive",function(data)
	local vehicle = vRP.vehList(7)
	-- if data["active"] == "trunk" then
	-- 	TriggerServerEvent("trytrunk",VehToNet(vehicle))
	if data["active"] == "door1" then
		TriggerServerEvent("vehmenu:doors","1")
	elseif data["active"] == "door2" then
		TriggerServerEvent("vehmenu:doors","2")
	elseif data["active"] == "door3" then
		TriggerServerEvent("vehmenu:doors","3")
	elseif data["active"] == "door4" then
		TriggerServerEvent("vehmenu:doors","4")
	elseif data["active"] == "trunk" then
		TriggerServerEvent("vehmenu:doors","5")
	elseif data["active"] == "hood" then
		TriggerServerEvent("vehmenu:doors","6")
	elseif data["active"] == "hood" then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	elseif data["active"] == "vtuning" then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)
		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "N??vel 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "N??vel 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "N??vel 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "N??vel 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "N??vel 5 / "..GetNumVehicleMods(vehicle,11)
		end
		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "N??vel 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "N??vel 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "N??vel 3 / "..GetNumVehicleMods(vehicle,12)
		end
		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "N??vel 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "N??vel 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "N??vel 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "N??vel 4 / "..GetNumVehicleMods(vehicle,13)
		end
		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "N??vel 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "N??vel 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "N??vel 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "N??vel 4 / "..GetNumVehicleMods(vehicle,15)
		end
		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "N??vel 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "N??vel 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "N??vel 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "N??vel 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "N??vel 5 / "..GetNumVehicleMods(vehicle,16)
		end
		TriggerEvent("Notify","amarelo","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmiss??o:</b> "..transmissao.."<br><b>Suspens??o:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",15000)
	end
end)