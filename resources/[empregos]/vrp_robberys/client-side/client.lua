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
Tunnel.bindInterface("vrp_robberys",cnVRP)
vSERVER = Tunnel.getInterface("vrp_robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local startRobbery = false
local robberyTimer = 0
local robberyId = 0
local vars = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(vars) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= v.distance then
					timeDistance = 4

					if not startRobbery then
						if distance <= 2 then
							DrawText3D(v.x,v.y,v.z-0.4,"~g~E~w~   ROUBAR",400)
							if distance <= 1 and IsControlJustPressed(1,38) and vSERVER.checkPolice(k,coords) then
								robberyId = k
								startRobbery = true
								robberyTimer = v.time
							end
						end
					else
						SendNUIMessage({ show = true, timer = "AGUARDE "..robberyTimer.." SEGUNDOS" })
					end
				end
			end

			if startRobbery then
				local distance = #(coords - vector3(vars[robberyId].x,vars[robberyId].y,vars[robberyId].z))
				if distance > vars[robberyId].distance or GetEntityHealth(ped) <= 101 then
					SendNUIMessage({ show = false })
					startRobbery = false
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if startRobbery then
			if robberyTimer > 0 then
				robberyTimer = robberyTimer - 1
				SendNUIMessage({ timer = "AGUARDE "..robberyTimer.." SEGUNDOS" })

				if robberyTimer <= 0 then
					vSERVER.paymentMethod(robberyId)
					SendNUIMessage({ show = false })
					startRobbery = false
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVARS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateVars(status)
	vars = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,height)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 375) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end