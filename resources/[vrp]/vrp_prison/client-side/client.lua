-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_prison", cRP)
vSERVER = Tunnel.getInterface("vrp_prison")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = nil
local prison = false
local inSelect = 1
local inTimer = 0
local timeDeath = 0
local enX,enY,enZ = 1680.12,2512.95,45.56
local exX,exY,exZ = 1847.2,2585.74,45.66
local emX,emY,emZ = 1841.68,2585.89,45.9
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local inLocates = {
	{ 1760.66,2541.37,45.56,272.13 },
	{ 1760.66,2519.02,45.56,257.96 },
	{ 1737.34,2504.68,45.56,167.25 },
	{ 1706.97,2481.05,45.56,229.61 },
	{ 1700.18,2474.75,45.56,229.61 },
	{ 1679.62,2480.31,45.56,133.23 },
	{ 1643.85,2490.77,45.56,195.6 },
	{ 1622.41,2507.77,45.56,99.22 },
	{ 1609.84,2539.68,45.56,138.9 },
	{ 1608.97,2567.06,45.56,48.19 },
	{ 1624.54,2577.39,45.56,274.97 },
	{ 1629.93,2564.33,45.56,0.0 },
	{ 1652.58,2564.35,45.56,5.67 },
	{ 1624.75,2567.13,45.56,260.79 },
	{ 1624.82,2567.86,45.56,274.97 },
	{ 1639.93,2565.13,45.56,0.0 },
	{ 1642.12,2565.17,45.56,0.0 },
	{ 1643.98,2565.12,45.56,34.02 },
	{ 1665.12,2567.66,45.56,0.0 },
	{ 1715.97,2567.15,45.56,87.88 },
	{ 1715.95,2567.97,45.56,85.04 },
	{ 1716.02,2568.8,45.56,93.55 },
	{ 1769.52,2565.61,45.56,357.17 },
	{ 1772.75,2536.82,45.56,246.62 },
	{ 1758.18,2509.01,45.56,260.79 },
	{ 1757.85,2507.75,45.56,257.96 },
	{ 1719.87,2502.68,45.56,255.12 },
	{ 1698.89,2472.74,45.56,232.45 },
	{ 1698.49,2472.36,45.56,209.77 },
	{ 1635.63,2490.22,45.56,189.93 },
	{ 1634.64,2490.12,45.56,181.42 },
	{ 1618.45,2521.55,45.56,138.9 },
	{ 1607.12,2541.79,45.56,138.9 },
	{ 1606.29,2542.63,45.56,133.23 },
	{ 1627.85,2543.56,45.56,229.61 },
	{ 1630.42,2527.15,45.56,235.28 },
	{ 1649.74,2538.41,45.56,59.53 },
	{ 1657.56,2549.39,45.56,141.74 },
	{ 1648.29,2536.11,45.56,325.99 },
	{ 1636.19,2553.61,45.56,2.84 },
	{ 1699.35,2532.14,45.56,90.71 },
	{ 1699.64,2534.6,45.56,85.04 },
	{ 1699.27,2535.83,45.56,130.4 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEMTREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if prison then
            local coords = GetEntityCoords(ped)
            local distance = #(coords - vector3(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3]))

            if distance <= 150 then
                timeDistance = 4
                DrawText3D(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3],"~g~E~w~   VASCULHAR")
                if distance <= 1 and inTimer <= 0 and IsControlJustPressed(1,38) then

                        inTimer = 4
                        TriggerEvent("cancelando",true)
                        SetEntityHeading(ped,inLocates[inSelect][4])
                        vRP._playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
                        SetEntityCoords(ped,inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3] - 1)

                        Citizen.Wait(10000)
                        
                        TriggerEvent("cancelando",false)
                        vSERVER.reducePrison()
                        vRP.removeObjects()

					if math.random(1000) > 975 then
						vSERVER.giveKey()
					end
				end
			end

			if GetEntityHealth(ped) <= 101 and timeDeath <= 0 then
				timeDeath = 60
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - SYSTEM
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
				DrawText3D(emX,emY,emZ,"~g~E~w~   FUGIR")

				if distance <= 1 and inTimer <= 0 and IsControlJustPressed(1,38) then
					inTimer = 4

					if vSERVER.checkKey() then
						vRP.teleport(exX,exY,exZ)

						if vSERVER.callPolice() then
							vSERVER.stopPrison()
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
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
-- THREAD - DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if inPrison and timeDeath > 0 then
			timeDeath = timeDeath - 1

			if timeDeath <= 0 then
				vRP.revivePlayer(110)
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startPrison(status)
    prison = true
    inSelect = 1
    inSelect = math.random(#inLocates)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopPrison()
    prison = false
    DoScreenFadeOut(1000)
    Wait(1350)
    vRP.teleport(exX,exY,exZ)
    DoScreenFadeIn(1000)
end

function cRP.stopPrison2()
    DoScreenFadeOut(1000)
    Wait(1350)
    vRP.teleport(exX,exY,exZ)
    DoScreenFadeIn(1000)
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
	local factor = (string.len(text) / 400) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end