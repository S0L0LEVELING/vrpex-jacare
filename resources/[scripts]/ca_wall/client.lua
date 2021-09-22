local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = Tunnel.getInterface("dt_wall")
Config = {}


local mostrando = false
local players = {}

local staff = false


RegisterCommand("wall",function()
	if src.getPermissao() then					
		if mostrando then
			mostrando = false
		else
			mostrando = true
		end
	end
end)

Citizen.CreateThread(
	function()
	    while true do
	    	Citizen.Wait(1)
			if mostrando then
				timeDistance = 5
				for k, id in ipairs(GetActivePlayers()) do
					local pos = GetEntityCoords(GetPlayerPed(id))
					local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos)
					local name = GetPlayerName(id)

					local pPed = GetPlayerPed(id)
                    local padraox, padraoy, padraoz = table.unpack(GetEntityCoords(PlayerPedId()))
                    local difx, dify, difz = table.unpack(GetEntityCoords(pPed))

					local cx, cy, cz = table.unpack(GetEntityCoords(id))
					local distanciaentre = math.floor(distance, cx, cy, cz + 0.5)

					if name == nil or name == "" or name == -1 then
						name = "Steam indisponível"
					end
					local health = (GetEntityHealth(GetPlayerPed(id)) - 100)
					if health == 1 then
						health = 0
					end
					local healthpercent = health / 1
					healthpercent = math.floor(healthpercent)
					if distance <= Config.DistanciaWall then
						DrawLine(padraox, padraoy, padraoz, difx, dify, difz, 129, 61, 138, 255)
					    DrawText3D(pos.x,pos.y,pos.z+1.20,"~g~"..name.." ~b~Vida: ~w~" ..healthpercent.. "% \n~b~ID: ~w~"..players[id].."\n~b~Distância:~w~ "..distanciaentre.."m")
					end 
				end
			end
	    end
	end
)

Citizen.CreateThread(function()
	while true do
	    for _, id in ipairs(GetActivePlayers()) do
	    	if id == -1 or id == nil then return end
			local pid = src.getId(GetPlayerServerId(id))
			if pid == -1 then
				return
			end
			if players[id] ~= pid or not players[id] then
				players[id] = pid
			end
		end
		Citizen.Wait(1400)
	end
end)

Citizen.CreateThread(function()
	while true do
		staff = src.isAdmin() 
		Citizen.Wait(12000)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO 3D
----------------------------------------------------------------------------------------------------------------------------------------

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.25)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
		    for _, id in ipairs(GetActivePlayers()) do
				local pid = src.getId(GetPlayerServerId(id))
				players[id] = pid
			end
		end
	end
)