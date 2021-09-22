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
Tunnel.bindInterface("vrp_dismantle",cnVRP)
vSERVER = Tunnel.getInterface("vrp_dismantle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inService = false
local timeDismantle = 0
local disX,disY,disZ = 2379.19,3048.56,48.18
local listX,listY,listZ = 2340.92,3128.05,48.21
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreaddesmanche()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)
					local distance = #(coords - vector3(disX,disY,disZ))
					if distance <= 10 then
						timeDistance = 4
						dwText("~g~E~w~  DESMANCHAR UM VEÍCULO",0.93)
						DrawMarker(23,disX,disY,disZ-1,0,0,0,0,0,0,14.0,14.0,1.0,0,255,0,30,0,0,0,0)
						if IsControlJustPressed(1,38) and timeDismantle <= 0 then
							timeDismantle = 3
							local status,vehicle = vSERVER.checkVehlist()
							if status then
								TaskTurnPedToFaceEntity(ped,vehicle,1000)
								Citizen.Wait(2000)
								FreezeEntityPosition(ped,true)
								TriggerEvent("cancelando",true)
								FreezeEntityPosition(vehicle,true)
								vRP._playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

								for i = 0,5 do
									Citizen.Wait(10000)
									SetVehicleDoorBroken(vehicle,i,false)
								end

								for i = 0,7 do
									Citizen.Wait(10000)
									SetVehicleTyreBurst(vehicle,i,1,1000.01)
								end

								vRP.removeObjects()
								---SetEntityInvincible(ped,false)
								FreezeEntityPosition(ped,false)
								TriggerEvent("cancelando",false)
								vSERVER.paymentMethod(vehicle)
							end
						end
					end
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if timeDismantle > 0 then
			timeDismantle = timeDismantle - 1
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLIST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(listX,listY,listZ))
			if distance <= 2.5 then
				timeDistance = 4
				DrawText3D(listX,listY,listZ,"~g~E~w~   PEGAR LISTA",400)
				if IsControlJustPressed(1,38) and distance <= 1.1 then
					startthreaddesmanche()
					vSERVER.acessList()
					inService = true
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

function dwText(text,height)
	SetTextFont(4)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5,height)
end