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
Tunnel.bindInterface("vrp_notepad",cnVRP)
vSERVER = Tunnel.getInterface("vrp_notepad")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local notePad = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATENOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_notepad:createNotepad")
AddEventHandler("vrp_notepad:createNotepad",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNotepad" })
	vRP.createObjects("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",49,60309)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("escape",function()
	SetNuiFocus(false)
	vRP.removeObjects("one")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITNOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("editNote",function(data)
	SetNuiFocus(false)
	vRP.removeObjects("one")
	SendNUIMessage({ action = "hideNotepad" })
	vSERVER.editNotepad(data.id,data.text)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPNOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropNote",function(data)
	SetNuiFocus(false)
	vRP.removeObjects("one")
	SendNUIMessage({ action = "hideNotepad" })
	vSERVER.createNotepad(data.text)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_notepad:removePlayers")
AddEventHandler("vrp_notepad:removePlayers",function(id)
	if notePad[id] ~= nil then
		notePad[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_notepad:sendPlayers")
AddEventHandler("vrp_notepad:sendPlayers",function(id,status)
	notePad[id] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATENOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateNotepad(status)
	notePad = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADNOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(notePad) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= 5 then
					timeDistance = 4
					DrawText3Ds(v.x,v.y,v.z-0.8,"~g~G~w~   LER     ~r~H~w~   DESTRUIR")
					if distance <= 1.2 then
						if IsControlJustPressed(1,38) then
							SetNuiFocus(true,true)
							SendNUIMessage({ action = "showNotepad2", text = v.text, id = v.id })
							vRP.createObjects("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",49,60309)
						elseif IsControlJustPressed(1,47) then
							vSERVER.destroyNotepad(v.id)
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
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