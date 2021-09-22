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
Tunnel.bindInterface("vrp_colheita",cRP)
vSERVER = Tunnel.getInterface("vrp_colheita")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inService = false
local inSelect = 1
local inTimer = 0
local timeDeath = 0
local emX,emY,emZ = 406.08,6526.17,27.75
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local inLocates = {
	{ 364.26,6483.13,29.23,93.7 },
	{ 364.25,6479.87,29.52,92.98 },
	{ 363.97,6475.65,30.02,96.15 },
	{ 364.24,6469.59,30.18,99.79 },
	{ 364.15,6466.56,30.28,96.31 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD-START
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(emX,emY,emZ))
			if distance <= 1.5 then
				timeDistance = 4

				if inService then
					DrawText3D(emX,emY,emZ,"~g~E~w~   FINALIZAR")
				else
					DrawText3D(emX,emY,emZ,"~g~E~w~   INICIAR")
				end

				if IsControlJustPressed(1,38) then
					inService = not inService
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEMTREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if inService then
            local coords = GetEntityCoords(ped)
            local distance = #(coords - vector3(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3]))

            if distance <= 150 then
                timeDistance = 4
                DrawText3D(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3],"~g~E~w~   COLHER")
                if distance <= 1 and inTimer <= 0 and IsControlJustPressed(1,38) then

                    inTimer = 4
                    TriggerEvent("cancelando",true)
                    SetEntityHeading(ped,inLocates[inSelect][4])
                    vRP._playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
                    SetEntityCoords(ped,inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3] - 1)

                    Citizen.Wait(10000)
                        
                    TriggerEvent("cancelando",false)
                    vSERVER.colletPayment()
                    vRP.removeObjects()
					startCollet(k)
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if inTimer > 0 then
            inTimer = inTimer - 1
        end
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startCollet(i)
    inSelect = 1
    inSelect = math.random(#inLocates)
end
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