local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local userlogin = {}

RegisterServerEvent("angra-CharacterSpawn")
AddEventHandler("angra-CharacterSpawn", function(source,user_id) 
	if user_id then
			local data = vRP.getUData(user_id,"spawnController")
			local sdata = json.decode(data) or 0
			if sdata then
				Citizen.Wait(1000)
				processSpawnController(source,sdata,user_id)
		end
	end
end)

function processSpawnController(source,statusSent,user_id)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,true)
		else
			doSpawnPlayer(source,user_id,false)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		local data = vRP.getUserDataTable(user_id)
		if data and data.skin then
			TriggerClientEvent("angra-character:characterCreate",source, data.skin)	
		end
	end
end

RegisterServerEvent("angra-character:finishedCharacter")
AddEventHandler("angra-character:finishedCharacter",function(currentCharacterMode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
		vRP.setUData(user_id,"spawnController",json.encode(2))
		doSpawnPlayer(source,user_id,true)
	end
end)

function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("angra-character:normalSpawn",source,firstspawn)
	TriggerEvent("vrp_barbershop:init",user_id)	
end