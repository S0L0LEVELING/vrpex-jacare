-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
cRP = Tunnel.getInterface("vrp_farm")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local inicio = 0
local fim = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Coordenadas = {
	{ 1887.4,292.38,164.54 }, -- VERDES
	{ -478.36,1544.41,393.03 }, -- AZUL
	{ 2131.71,3469.79,51.74 }, -- ROXOS
	{ 1260.59,-216.88,99.99 }, -- VERMELHOS
	{ -1865.88,2061.3,135.44 }, -- MAFIA
	{ 989.6,-135.76,74.07 }, -- THELOST
	{ 1401.27,1139.14,109.75 }, -- MERCENARIOS
	{ 1460.73,1085.89,114.34 }, -- MADRAZO
	{ 108.98,-1304.84,28.77 }, -- VANNILA
	{ -1365.72,-616.44,30.32 }, -- BAHAMAS
	{ -1118.36,-1619.1,4.4 }, -- BENNYS
	{ -1148.26,-1999.79,13.19 } -- SPORT
} 
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCS COLETA
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	-- VERDES
		[1] = { ['x'] = 1355.12, ['y'] = -1690.60, ['z'] = 60.49 },
		[2] = { ['x'] = 970.78, ['y'] = -199.50, ['z'] = 73.20 },
		[3] = { ['x'] = 1212.98, ['y'] = -552.92, ['z'] = 69.17 },
		[4] = { ['x'] = -3093.80, ['y'] = 349.27, ['z'] = 7.54 },
		[5] = { ['x'] = -1097.43, ['y'] = -1672.99, ['z'] = 8.39 },
		[6] = { ['x'] = -1613.24, ['y'] = -1028.10, ['z'] = 13.15 },
		[7] = { ['x'] = 196.5, ['y'] = -1690.99, ['z'] = 29.62 },
		[8] = { ['x'] = 818.28, ['y'] = -1375.55, ['z'] = 26.32 },
		[9] = { ['x'] = -688.73, ['y'] = -141.88, ['z'] = 37.84 },
		[10] = { ['x'] = 359.69, ['y'] = 356.52, ['z'] = 104.33 },
		[11] = { ['x'] = 675.21, ['y'] = -2725.68, ['z'] = 7.18 },
	-- AZUL
		[12] = { ['x'] = 191.43, ['y'] = -2226.55, ['z'] = 6.97 },
		[13] = { ['x'] = -903.51, ['y'] = -1005.46, ['z'] = 2.15 },
		[14] = { ['x'] = -3105, ['y'] = 246.82, ['z'] = 12.5 },
		[15] = { ['x'] = 1160.70, ['y'] = -311.57, ['z'] = 69.27 },
		[16] = { ['x'] = 1086.49, ['y'] = -2400.11, ['z'] = 30.57 },
		[17] = { ['x'] = -429.16, ['y'] = -1728.11, ['z'] = 19.78 },
		[18] = { ['x'] = 1082.59, ['y'] = -787.55, ['z'] = 58.33 },
		[19] = { ['x'] = -430.94, ['y'] = 289.01, ['z'] = 86.06 },
		[20] = { ['x'] = -328.41, ['y'] = -2700.41, ['z'] = 7.54 },
		[21] = { ['x'] = -1244.10, ['y'] = -1240.34, ['z'] = 11.02 },
		[22] = { ['x'] = 66.81, ['y'] = -253.46, ['z'] = 52.35 },
	-- ROXOS
		[23] = { ['x'] = 1236.91, ['y'] = -3008.62, ['z'] = 9.31 },
		[24] = { ['x'] = -1102.15, ['y'] = -1492.6, ['z'] = 4.89 },
		[25] = { ['x'] = -1829.21, ['y'] = 801.0, ['z'] = 138.42 },
		[26] = { ['x'] = -3049.84, ['y'] = 474.72, ['z'] = 6.78 },
		[27] = { ['x'] = 1250.56, ['y'] = -1966.17, ['z'] = 44.32 },
		[28] = { ['x'] = 997.08, ['y'] = -729.59, ['z'] = 57.82 },
		[29] = { ['x'] = -43.59, ['y'] = -2520.00, ['z'] = 7.39 },
		[30] = { ['x'] = -1161.52, ['y'] = -1099.59, ['z'] = 2.20 },
		[31] = { ['x'] = 1224.74, ['y'] = 2728.44, ['z'] = 38.00 },
		[32] = { ['x'] = 844.31, ['y'] = -2118.34, ['z'] = 30.52 },
		[33] = { ['x'] = 167.72, ['y'] = -2222.32, ['z'] = 7.23 },
	-- VERMELHOS
		[34] = { ['x'] = 1236.91, ['y'] = -3008.62, ['z'] = 9.31 },
		[35] = { ['x'] = -1102.15, ['y'] = -1492.6, ['z'] = 4.89 },
		[36] = { ['x'] = -1829.21, ['y'] = 801.0, ['z'] = 138.42 },
		[37] = { ['x'] = -3049.84, ['y'] = 474.72, ['z'] = 6.78 },
		[38] = { ['x'] = 1250.56, ['y'] = -1966.17, ['z'] = 44.32 },
		[39] = { ['x'] = 997.08, ['y'] = -729.59, ['z'] = 57.82 },
		[40] = { ['x'] = -43.59, ['y'] = -2520.00, ['z'] = 7.39 },
		[41] = { ['x'] = -1161.52, ['y'] = -1099.59, ['z'] = 2.20 },
		[42] = { ['x'] = 1224.74, ['y'] = 2728.44, ['z'] = 38.00 },
		[43] = { ['x'] = 844.31, ['y'] = -2118.34, ['z'] = 30.52 },
		[44] = { ['x'] = 167.72, ['y'] = -2222.32, ['z'] = 7.23 },
	-- MAFIA
		[45] = { ['x'] = -1621.55, ['y'] = 15.78, ['z'] = 62.55 }, 
		[46] = { ['x'] = -1529.97, ['y'] = -581.05, ['z'] = 33.6 }, 
		[47] = { ['x'] = -1657.05, ['y'] = -982.81, ['z'] = 8.17 }, 
		[48] = { ['x'] = -3203.06, ['y'] = 1206.02, ['z'] = 12.83 }, 
		[49] = { ['x'] = -1928.53, ['y'] = 1779.16, ['z'] = 173.03 }, 
		[50] = { ['x'] = -1126.04, ['y'] = 2694.83, ['z'] = 18.81 }, 
		[51] = { ['x'] = 59.11, ['y'] = 2795.04, ['z'] = 57.88 }, 
		[52] = { ['x'] = 1980.3, ['y'] = 3049.53, ['z'] = 50.44 }, 
		[53] = { ['x'] = 2562.31, ['y'] = 2590.86, ['z'] = 38.09 }, 
		[54] = { ['x'] = 2461.14, ['y'] = 1574.95, ['z'] = 33.12 }, 
		[55] = { ['x'] = 2546.22, ['y'] = 385.56, ['z'] = 108.62 }, 
		[56] = { ['x'] = -169.25, ['y'] = -1027.11, ['z'] = 27.28 }, 
		[57] = { ['x'] = 68.85, ['y'] = -114.28, ['z'] = 57.3 }, 
		[58] = { ['x'] = -580.91, ['y'] = 181.42, ['z'] = 71.07 },
		[59] = { ['x'] = -1051.99, ['y'] = 432.42, ['z'] = 77.26 },
	-- THELOST
		[60] = { ['x'] = 751.77, ['y'] = 223.72, ['z'] = 87.43 }, 
		[61] = { ['x'] = -596.97, ['y'] = 851.37, ['z'] = 211.48 }, 
		[62] = { ['x'] = -1125.82, ['y'] = 2694.48, ['z'] = 18.81 }, 
		[63] = { ['x'] = 387.53, ['y'] = 3584.72, ['z'] = 33.3 }, 
		[64] = { ['x'] = 1941.72, ['y'] = 3842.36, ['z'] = 35.51 }, 
		[65] = { ['x'] = 2932.33, ['y'] = 4624.19, ['z'] = 48.73 }, 
		[66] = { ['x'] = 1642.67, ['y'] = 4846.09, ['z'] = 45.48 }, 
		[67] = { ['x'] = 1309.4, ['y'] = 4384.49, ['z'] = 42.06}, 
		[68] = { ['x'] = 711.18, ['y'] = 4185.52, ['z'] = 41.09 }, 
		[69] = { ['x'] = 30.79, ['y'] = 3736.18, ['z'] = 40.64 }, 
		[70] = { ['x'] = -35.07, ['y'] = 1950.83, ['z'] = 190.56 }, 
		[71] = { ['x'] = -2554.17, ['y'] = 2301.22, ['z'] = 33.22 }, 
		[72] = { ['x'] = -3203.12, ['y'] = 1206.17, ['z'] = 12.83 }, 
		[73] = { ['x'] = -2989.34, ['y'] = 69.78, ['z'] = 11.61 }, 
		[74] = { ['x'] = -1763.78, ['y'] = -708.03, ['z'] = 14.05 }, 
		[75] = { ['x'] = -1337.67, ['y'] = -1161.47, ['z'] = 4.51 }, 
		[76] = { ['x'] = -1305.74, ['y'] = -1228.93, ['z'] = 8.99 }, 
		[77] = { ['x'] = -725.53, ['y'] = -296.21, ['z'] = 37.05 }, 
		[78] = { ['x'] = -115.83, ['y'] = -373.03, ['z'] = 38.09 }, 
		[79] = { ['x'] = 375.79, ['y'] = -335.73, ['z'] = 48.17 }, 	
	-- MERCENARIOS
		[80] = { ['x'] = 677.94, ['y'] = 74.19, ['z'] = 83.13 },
		[81] = { ['x'] = -460.73, ['y'] = 1080.32, ['z'] = 323.85 },
		[82] = { ['x'] = 152.1, ['y'] = 2280.99, ['z'] = 93.95 },
		[83] = { ['x'] = 1406.99, ['y'] = 3656.05, ['z'] = 34.43 },
		[84] = { ['x'] = 1365.9, ['y'] = 4358.39, ['z'] = 44.51 },
		[85] = { ['x'] = 2193.84, ['y'] = 5593.98, ['z'] = 53.76 },
		[86] = { ['x'] = 1538.84, ['y'] = 6321.93, ['z'] = 25.07 },
		[87] = { ['x'] = 149.06, ['y'] = 6362.54, ['z'] = 31.54 },
		[88] = { ['x'] = -2175.4, ['y'] = 4295.05, ['z'] = 49.06 },
		[89] = { ['x'] = -3191.06, ['y'] = 1219.4, ['z'] = 10.05 },
		[90] = { ['x'] = -1604.61, ['y'] = -832.62, ['z'] = 10.27 },
		[91] = { ['x'] = 1.16, ['y'] = -437.05, ['z'] = 39.74 },
		[92] = { ['x'] = 396.14, ['y'] = 352.36, ['z'] = 102.56 },
		-- MADRAZO
		[93] = { ['x'] = -315.07, ['y'] = -2698.82, ['z'] = 7.55 },
		[94] = { ['x'] = 1080.83, ['y'] = -2412.59, ['z'] = 30.18 },
		[95] = { ['x'] = 1685.54, ['y'] = -1679.46, ['z'] = 112.53 },
		[96] = { ['x'] = 2854.68, ['y'] = 1502.06, ['z'] = 24.73 },
		[97] = { ['x'] = 2521.23, ['y'] = 2628.64, ['z'] = 37.96 },
		[98] = { ['x'] = 1689.06, ['y'] = 3291.66, ['z'] = 41.15 },
		[99] = { ['x'] = 91.79, ['y'] = 3754.02, ['z'] = 40.78 },
		[100] = {['x'] = -1128.04, ['y'] = 2708.05, ['z'] = 18.81 },
		[101] = { ['x'] = -2016.48, ['y'] = 559.65, ['z'] = 108.3 },
		[102] = { ['x'] = -1678.3, ['y'] = -408.69, ['z'] = 43.93 },
		[103] = { ['x'] = -970.5, ['y'] = -1121.17, ['z'] = 2.18 },
		[104] = { ['x'] = -513.75, ['y'] = -1019.0, ['z'] = 23.48 },
		[105] = { ['x'] = 491.72, ['y'] = -506.78, ['z'] = 25.18 },
		[106] = { ['x'] = 558.93, ['y'] = -2204.21, ['z'] = 12.9 },
		-- SPORT
		[107] = { ['x'] = -412.56, ['y'] = -1677.7, ['z'] = 18.51 },
		[108] = { ['x'] = 133.74, ['y'] = -2202.99, ['z'] = 7.19 },
		[109] = { ['x'] = -48.52, ['y'] = -2508.86, ['z'] = 7.4 },
		[110] = { ['x'] = 961.88, ['y'] = -2503.41, ['z'] = 28.46 },
		[111] = { ['x'] = 1430.55, ['y'] = -2317.07, ['z'] = 66.86 },
		[112] = { ['x'] = 1135.91, ['y'] = -1361.9, ['z'] = 34.58 },
		[113] = { ['x'] = 1134.73, ['y'] = -443.08, ['z'] = 66.49 },
		[114] = { ['x'] = 572.28, ['y'] = 114.2, ['z'] = 98.05 },
		[115] = { ['x'] = 114.62, ['y'] = 276.6, ['z'] = 109.98 },
		[116] = { ['x'] = -694.7, ['y'] = -307.91, ['z'] = 36.33 },
		[117] = { ['x'] = -970.58, ['y'] = -1120.91, ['z'] = 2.18 },
		[118] = { ['x'] = -1157.12, ['y'] = -1569.58, ['z'] = 4.43 },
		[119] = { ['x'] = -1124.85, ['y'] = -2162.97, ['z'] = 13.4 },
		[120] = { ['x'] = -458.82, ['y'] = -2275.0, ['z'] = 8.52 },
		-- BENNYS
		[121] = { ['x'] = -458.93, ['y'] = -2275.0, ['z'] = 9.0 },
		[122] = { ['x'] = -1124.99, ['y'] = -2163.0, ['z'] = 14.0 },
		[123] = { ['x'] = -1157.99, ['y'] = -1569.99, ['z'] = 5.0 },
		[124] = { ['x'] = -970.99, ['y'] = -1120.99, ['z'] = 3.0 },
		[125] = { ['x'] = -694.29, ['y'] = -308.21, ['z'] = 36.32 },
		[126] = { ['x'] = 114.62, ['y'] = 276.6, ['z'] = 109.98 },
		[127] = { ['x'] = 572.01, ['y'] = 114.01, ['z'] = 99.0 },
		[128] = { ['x'] = 1134.01, ['y'] = -443.99, ['z'] = 66.96 },
		[129] = { ['x'] = 1135.01, ['y'] = -1361.99, ['z'] = 35.0 },
		[130] = { ['x'] = 1430.01, ['y'] = -2318.0, ['z'] = 67.0 },
		[131] = { ['x'] = 961.75, ['y'] = -2503.5, ['z'] = 28.46 },
		[132] = { ['x'] = -48.99, ['y'] = -2509.0, ['z'] = 7.4 },
		[133] = { ['x'] = 133.01, ['y'] = -2203.0, ['z'] = 7.19 },
		[134] = { ['x'] = -412.99, ['y'] = -1678.01, ['z'] = 19.03 },
	}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL PARA INICIAR COLETA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local TimeDistance = 1000
		if not servico then
			for _,mark in pairs(Coordenadas) do
				local x,y,z = table.unpack(mark)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
				if distance <= 30.0 then
					TimeDistance = 5
					DrawMarker(21,x,y,z,0,0,0,0,0,0,0.5,0.5,0.5,255,255,255,150,1,0,0,1)
					if distance <= 1.2 then
						TimeDistance = 1
						drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR COLETA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and cRP.checkPermission() then
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1887.4,292.38,164.54,true) <= 1.2 then -- VERDES
								servico = true	
								inicio = 1
								fim = 11				
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-478.36,1544.41,393.03,true) <= 1.2 then -- AZUL
								servico = true						
								inicio = 12
								fim = 22			
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2131.71,3469.79,51.74,true) <= 1.2 then -- ROXOS
								servico = true							
								inicio = 23
								fim = 33					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1260.59,-216.88,99.99,true) <= 1.2 then -- VERMELHOS
								servico = true
								inicio = 34
								fim = 44
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1865.88,2061.3,135.44,true) <= 1.2 then -- MAFIA
								servico = true
								inicio = 45
								fim = 59
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 989.6,-135.76,74.07,true) <= 1.2 then -- THELOST
								servico = true							
								inicio = 60
								fim = 79			
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1401.27,1139.14,109.75,true) <= 1.2 then -- MERCENARIOS
								servico = true							
								inicio = 80
								fim = 92				
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1460.73,1085.89,114.34,true) <= 1.2 then -- MADRAZO
								servico = true							
								inicio = 93
								fim = 106			
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),108.98,-1304.84,28.77,true) <= 1.2 then -- VANNILA
								servico = true							
								inicio = 93
								fim = 106			
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1365.72,-616.44,30.32,true) <= 1.2 then -- BAHAMAS
								servico = true							
								inicio = 93
								fim = 106			
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1148.26,-1999.79,13.19,true) <= 1.2 then -- SPORT
								servico = true							
								inicio = 107
								fim = 120			
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1118.36,-1619.1,4.4,true) <= 1.2 then -- BENNYS
								servico = true							
								inicio = 121
								fim = 134			
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.",8000)
							end		
						end
					end
				end
			end
		end
		Citizen.Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETA DE COMPONENTES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
            if distance <= 100.0 then
                timeDistance = 5
                DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,0,0,0,0,0,0,0.5,0.5,0.5,255,255,255,150,1,0,0,1)
                if distance <= 1.6 then
                    timeDistance = 4
                    drawTxt("PRESSIONE ~b~E~w~  PARA COLETAR",4,0.5,0.93,0.50,255,255,255,180)
                    if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                        if cRP.checkPayment() then
                            TriggerEvent("progress",1000,"Colentando")
							TriggerEvent('cancelando',true)
							vRP._playAnim(true,{"pickup_object","pickup_low"},false)
							Citizen.Wait(1000)
							vRP.removeObjects()
							TriggerEvent('cancelando',false)
							RemoveBlip(blips)
							selecionado = selecionado + 1
							if selecionado > fim then
								selecionado = inicio
							end
                            CriandoBlip(locs,selecionado)
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você finalizou o serviço.",8000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,12)
	SetBlipColour(blips,77)
	SetBlipScale(blips,0.7)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Componentes")
	EndTextCommandSetBlipName(blips)
end


