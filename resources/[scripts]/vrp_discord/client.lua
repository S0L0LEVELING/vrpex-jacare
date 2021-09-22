local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emD = Tunnel.getInterface("vrp_discord")
----------------------------------------------------------------------------------------------------
--[ DISCORD ]---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(COLOQUE SEU ID DO DISCORD)

	    local players = emD.discord()
		
	    SetDiscordRichPresenceAsset("NOME DA LOGO") 
		SetDiscordRichPresenceAssetText("Jacaré Roleplay")
		SetRichPresence(status)
	    --SetRichPresence("Moradores: "..players.." de 128")
		--SetDiscordRichPresenceAction(0, "Entrar no Site", "COLOQUE SEU SITE")
		SetDiscordRichPresenceAction(1, "Entrar no Discord", "https://discord.gg/tQusfM3bre")
		Citizen.Wait(10000)
	end
end)
