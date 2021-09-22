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
Tunnel.bindInterface("vrp_tattoos", cRP)
vSERVER = Tunnel.getInterface("vrp_tattoos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = nil
local atualShop = {}
local atualTattoo = {}
local old_custom
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETTATTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_tattoos:setTattoos")
AddEventHandler("vrp_tattoos:setTattoos",function(status)
	atualTattoo = status

	for k,v in pairs(atualTattoo) do
		AddPedDecorationFromHashes(PlayerPedId(),GetHashKey(v[1]),GetHashKey(k))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENTATTOOSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function openTattooShop()
	setCameraCoords()
	SetNuiFocus(true,true)

	local ped = PlayerPedId()
	ClearAllPedProps(ped)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		atualShop = Config.tattooList["partsM"]
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		atualShop = Config.tattooList["partsF"]
	end
	SendNUIMessage({ openNui = true, shop = atualShop, tattoo = atualTattoo })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
function updateTattoo()
	ClearPedDecorations(PlayerPedId())

	for k,v in pairs(atualTattoo) do
		AddPedDecorationFromHashes(PlayerPedId(),GetHashKey(v[1]),GetHashKey(k))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCAMERACOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function setCameraCoords()
	if DoesCamExist(cam) then
		RenderScriptCams(false,true,250,1,0)
		DestroyCam(cam,false)
		cam = nil
	end

	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamActive(cam,true)
	RenderScriptCams(true,true,500,true,true)
	pos = GetEntityCoords(PlayerPedId())
	camPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,2.0,0.0)
	SetCamCoord(cam,camPos.x,camPos.y,camPos.z + 0.75)
	PointCamAtCoord(cam,pos.x,pos.y,pos.z + 0.15)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data,cb)
	RenderScriptCams(false,true,250,1,0)
	vSERVER.applyTattow(atualTattoo)
	SetNuiFocus(false,false)
	DestroyCam(cam,false)
	cam = nil
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(Config.coordsSystem) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 5 then
					timeDistance = 4
					DrawMarker(23,v[1],v[2],v[3]-0.95,0,0,0,0,0,0,1.5,1.5,1.5,42,137,255,100,0,0,0,0)

					if distance <= 1 and IsControlJustPressed(1,38) then
						openTattooShop()
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGETATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("changeTattoo",function(data,cb)
	local newAtualTattoo = {}
	local tattooData = atualShop[data.type]["tattoo"][data.id + 1]

	for k,v in pairs(atualTattoo) do
		if k ~= tattooData["name"] then
			newAtualTattoo[k] = v
		end
	end

	if atualTattoo[tattooData["name"]] == nil then
		newAtualTattoo[tattooData["name"]] = { tattooData["part"] }
	end

	atualTattoo = newAtualTattoo
	updateTattoo()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clearTattoo",function(data,cb)
	atualTattoo = {}
	ClearPedDecorations(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(data,cb)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	if data == "left" then
		SetEntityHeading(ped,heading + 10)
	elseif data == "right" then
		SetEntityHeading(ped,heading - 10)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("handsup",function(data,cb)
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) then
		StopAnimTask(ped,"random@mugging3","handsup_standing_base",2.0)
		vRP._stopActived()
	else
		vRP._playAnim(true,{"random@mugging3","handsup_standing_base"},true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
