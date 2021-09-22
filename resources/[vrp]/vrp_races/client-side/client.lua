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
Tunnel.bindInterface("vrp_races",cRP)
vSERVER = Tunnel.getInterface("vrp_races")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inRunners = false
local inRace = false
local inSelected = 0
local inCheckpoint = 0
local inLaps = 1
local inTimers = 0
local timeRace = 0
local blipRace = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local runners = {
	[1] = {
		["race"] = 1,
		["laps"] = 1,
		['time'] = 360,
		["init"] = { -342.99,-1087.12,23.03 },
		["coords"] = {
			{ -240.16,-1143.64,22.83 },
			{ -113.26,-1151.99,25.5 },
			{ -84.65,-1261.67,29.22 },
			{ -34.13,-1302.94,29.05 },
			{ 307.71,-1443.61,29.8 },
			{ 536.54,-1434.4,29.35 },
			{ 793.78,-1450.03,27.18 },
			{ 811.71,-1570.38,31.16 },
			{ 698.56,-1679.87,9.71 },
			{ 603.75,-1937.87,19.49 },
			{ 434.07,-2113.07,20.38 },
			{ 258.07,-2224.69,6.95 },
			{ 178.67,-2192.41,6.46 },
			{ 91.59,-2190.92,6.0 },
			{ -112.86,-2188.85,10.28 },
			{ -547.23,-2193.2,6.15 },
			{ -690.53,-2290.07,13.03 },
			{ -848.44,-2612.46,14.89 },
			{ -993.3,-2849.84,13.97 },
			{ -1851.17,-3147.11,13.95 }
		}
	},
	[2] = {
		["race"] = 2,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { 706.71,-1581.33,9.71 },
		["coords"] = {
			{ 614.72,-1066.53,10.3 },
			{ 649.37,-614.09,16.05 },
			{ 771.69,-592.37,29.96 },
			{ 799.27,-525.42,33.46 },
			{ 858.95,-473.45,30.04 },
			{ 1366.96,-949.9,57.31 },
			{ 1902.77,-759.13,97.27 },
			{ 2275.05,-516.1,95.59 },
			{ 2423.29,1093.4,79.54 },
			{ 2021.4,1494.85,75.57 },
			{ 1691.25,1454.64,85.48 },
			{ 1571.04,1310.82,92.56 },
			{ 1407.87,1830.9,101.73 },
			{ 1159.48,2058.13,57.42 },
			{ 1162.88,2138.38,55.8 },
			{ 1159.99,2218.26,51.56 },
			{ 991.47,2258.08,48.01 },
			{ 875.97,2347.27,51.69 }
		}
	},
	[3] = {
		["race"] = 3,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { 853.42,-1356.82,26.1 },
		["coords"] = {
			{ 712.13,-1364.24,25.98 },
			{ 813.47,-1432.74,27.28 },
			{ 971.48,-1560.59,30.68 },
			{ 865.75,-1569.18,30.49 },
			{ 821.82,-1717.63,29.34 },
			{ 753.07,-1899.22,29.1 },
			{ 729.2,-2005.46,29.3 },
			{ 866.91,-2100.03,30.36 },
			{ 889.47,-2183.29,30.52 },
			{ 972.91,-2236.41,30.56 },
			{ 1041.9,-2376.63,30.43 },
			{ 1099.21,-2401.71,30.72 },
			{ 1291.52,-2202.61,50.29 },
			{ 1274.07,-2022.11,44.19 },
			{ 1355.22,-1803.66,58.57 },
			{ 1405.88,-1625.43,58.51 },
			{ 1837.27,-1058.29,79.44 },
			{ 2582.41,-591.26,66.75 },
			{ 2502.59,-279.74,93.0 }
		}
	},
	[4] = {
		["race"] = 4,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { -2180.27,-383.17,13.28 },
		["coords"] = {
			{ -3046.18,226.47,16.12 },
			{ -3057.92,661.33,10.19 },
			{ -3171.08,909.98,14.44 },
			{ -2554.38,2331.13,33.07 },
			{ -1968.51,2283.72,53.77 },
			{ -1879.07,1988.63,142.88 },
			{ -2114.32,1997.75,190.55 },
			{ -2647.57,1522.67,118.07 },
			{ -2927.71,1334.78,44.47 },
			{ -3172.28,1267.31,12.23 },
			{ -3096.65,777.37,19.48 },
			{ -3077.55,336.47,7.34 },
			{ -2142.25,-275.72,13.78 },
			{ -1856.48,-406.23,46.2 },
			{ -1663.9,-243.63,54.91 }
		}
	},
	[5] = {
		["race"] = 5,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { -351.35,-738.57,53.25 },
		["coords"] = {
			{ -136.05,-909.24,29.35 },
			{ -165.53,-1034.71,27.28 },
			{ -224.08,-1173.99,22.98 },
			{ -111.62,-1120.9,25.63 },
			{ 44.09,-1045.27,29.63 },
			{ 176.15,-1087.02,29.25 },
			{ 285.91,-1055.23,29.22 },
			{ 478.7,-1111.31,29.2 },
			{ 225.51,-1165.6,38.16 },
			{ -0.39,-1037.82,38.16 },
			{ 2.07,-815.22,41.7 },
			{ 111.64,-396.03,41.27 },
			{ -25.99,-453.32,40.47 },
			{ -106.19,-609.58,36.07 },
			{ -6.66,-685.39,32.34 },
			{ 103.33,-587.71,31.64 },
			{ 427.02,-609.44,28.5 },
			{ 459.14,-655.74,27.72 },
			{ 476.75,-838.68,26.04 },
			{ 442.47,-1288.18,30.33 },
			{ 444.91,-1372.09,43.56 },
			{ 1147.0,-1468.75,34.67 },
			{ 1189.19,-1565.97,39.41 },
		}
	},
	[6] = {
		["race"] = 6,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { 619.38,650.21,128.92 },
		["coords"] = {
			{ 896.24,422.52,118.88 },
			{ 611.09,359.8,117.17 },
			{ 468.61,401.49,138.49 },
			{ 279.71,638.63,156.84 },
			{ 268.87,732.5,184.04 },
			{ -160.91,515.79,138.29 },
			{ -326.52,464.28,108.59 },
			{ -404.59,403.87,108.24 },
			{ -548.41,470.66,102.21 },
			{ -616.4,504.48,106.76 },
			{ -857.86,418.46,86.63 },
			{ -907.9,380.9,81.61 },
			{ -934.68,346.03,71.24 },
			{ -1021.35,339.59,68.92 },
			{ -1186.51,357.09,71.33 },
			{ -1303.75,400.42,70.91 },
			{ -1569.6,260.22,57.97 },
			{ -1815.82,74.57,71.58 },
			{ -2211.82,572.69,163.65 },
			{ -2332.09,264.0,169.09 }
		}
	},
	[7] = {
		["race"] = 7,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { 1377.14,-739.26,67.24 },
		["coords"] = {
			{ 1245.6,-718.2,62.49 },
			{ 1197.85,-653.37,61.79 },
			{ 1111.66,-508.29,63.58 },
			{ 1114.73,-366.35,67.07 },
			{ 890.73,-580.41,57.38 },
			{ 1081.5,-734.78,56.75 },
			{ 1102.63,-956.99,46.83 },
			{ 773.78,-1040.32,26.49 },
			{ 693.87,-1142.87,23.94 },
			{ 849.72,-1192.1,25.28 },
			{ 1011.9,-1185.61,26.82 },
			{ 1054.77,-1120.99,25.36 },
			{ 1113.57,-1043.26,34.95 },
			{ 1070.82,-856.78,49.68 },
			{ 899.42,-693.4,42.62 },
			{ 671.74,-552.77,41.37 },
			{ 379.46,-269.35,53.84 },
			{ 358.41,-194.81,58.16 },
			{ 273.78,-95.58,70.18 },
			{ 222.62,-32.8,69.72 },
			{ 160.42,-178.77,54.14 },
			{ 201.47,-216.71,54.09 },
			{ -52.92,-781.35,44.24 },
			{ -75.33,-746.38,44.12 },
			{ 146.44,-811.34,31.19 },
			{ 423.11,-826.2,29.06 },
			{ 461.83,-648.61,28.15 },
			{ 447.55,-582.12,28.5 }
		}
	},
	[8] = {
		["race"] = 8,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { -779.39,-1334.07,5.01 },
		["coords"] = {
			{ -711.47,-1252.1,9.58 },
			{ -567.67,-1222.4,16.42 },
			{ -514.65,-1315.18,28.52 },
			{ -321.63,-1437.56,30.93 },
			{ -152.31,-1514.83,33.99 },
			{ -159.86,-1709.52,30.83 },
			{ 32.98,-1879.24,22.68 },
			{ 193.76,-1905.13,23.71 },
			{ 456.21,-1678.25,29.29 },
			{ 468.34,-1713.14,28.96 },
			{ 417.04,-1809.08,28.67 },
			{ 209.57,-2028.97,18.24 },
			{ 84.78,-2008.08,17.89 },
			{ -401.96,-1589.48,6.02 },
			{ -528.33,-1506.69,9.45 },
			{ -701.83,-1500.56,11.9 },
			{ -1013.52,-2099.53,13.33 },
			{ -738.04,-2375.61,14.85 },
			{ -428.52,-2156.68,10.34 },
			{ -252.79,-2164.12,10.1 },
			{ -126.72,-2013.65,18.41 },
			{ -238.68,-1852.97,29.08 },
			{ -205.04,-1743.1,31.27 },
			{ -353.32,-1600.42,21.38 },
			{ -313.83,-1523.8,27.57 },
			{ -232.34,-1397.97,31.29 }
		}
	},
	[9] = {
		["race"] = 9,
		["laps"] = 1,
		['time'] = 380,
		["init"] = { -1620.7,-921.86,8.72 },
		["coords"] = {
			{ -1563.98,-837.19,9.9 },
			{ -1577.08,-791.86,12.29 },
			{ -1456.19,-776.01,23.35 },
			{ -1595.72,-1022.44,12.73 },
			{ -1538.74,-943.82,11.28 },
			{ -1507.02,-938.95,9.13  },
			{  -1420.46,-928.12,10.63 },
			{  -1269.96,-986.22,1.37 },
			{ -1203.33,-1050.01,1.85 },
			{ -1120.98,-1063.32,1.81 },
			{ -1081.38,-1072.73,1.87 },
			{ -1050.24,-1062.36,1.96 },
			{ -986.1,-984.55,1.76 },
			{ -953.51,-966.96,1.87 },
			{ -853.07,-1057.38,8.84 },
			{ -756.48,-1100.88,10.43 },
			{ -771.26,-991.2,14.17 },
			{ -624.98,-892.08,24.55 },
			{ -468.18,-839.2,30.26 },
			{ -449.97,-734.0,28.22 }
		}
	}
}

Citizen.CreateThread(function()
	while true do
		if inRace then
			if timeRace > 0 then
				timeRace = timeRace - 1
				if timeRace <= 0 or not IsPedInAnyVehicle(GetPlayerPed(-1)) then
					inRace = false
					SetTimeout(3000,function()
						timeRace = 0
						vSERVER.finishRaces(nil,nil,false)
						AddExplosion(GetEntityCoords(GetPlayersLastVehicle()),1,1.0,true,true,true)
						RemoveBlip(blipRace)
					end)
				end
			elseif timeRace == 0 then
				if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
					inRace = false
					timeRace = 0
					vSERVER.finishRaces(nil,nil,false)
					RemoveBlip(blipRace)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRUNNERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			if inRunners then
				timeDistance = 4

				if timeRace > 0 then
					dwText("VOLTAS~w~ ",0.40,0.40,0.68,0.85,180)
					dwText(inLaps.."  /  "..runners[inSelected]["laps"],0.50,0.50,0.725,0.847,240,true)
					dwText("CHECKPOINT~w~ ",0.45,0.45,0.66,0.88,180)
					dwText(inCheckpoint.."  /  "..#runners[inSelected]["coords"],0.50,0.50,0.725,0.877,240,true)
					dwText("PONTOS~w~ ",0.40,0.40,0.679,0.91,180)
					dwText2(inTimers,0.50,0.50,0.725,0.907,240,true)
					dwText("TEMPO ~b~",0.40,0.40,0.684,0.94,180)
					dwText(timeRace,0.50,0.50,0.725,0.937,240,true)

				else
					dwText("VOLTAS~w~ ",0.40,0.40,0.68,0.88,180)
					dwText(inLaps.."  /  "..runners[inSelected]["laps"],0.50,0.50,0.725,0.877,240,true)
					dwText("CHECKPOINT~w~ ",0.45,0.45,0.66,0.91,180)
					dwText(inCheckpoint.."  /  "..#runners[inSelected]["coords"],0.50,0.50,0.725,0.907,240,true)
					dwText("PONTOS~w~ ",0.40,0.40,0.68,0.94,180)
					dwText2(inTimers,0.50,0.50,0.725,0.937,240,true)
				end

				local distance = #(coords - vector3(runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3]))
				if distance <= 200 then
					DrawMarker(1,runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3]-3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,25,0,0,0,0)
					DrawMarker(21,runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3]+1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,42,137,255,50,1,0,0,1)

					if distance <= 10 then
						if inCheckpoint >= #runners[inSelected]["coords"] then
							if inLaps >= runners[inSelected]["laps"] then
								PlaySoundFrontend(-1,"RACE_PLACED","HUD_AWARDS",false)
								vSERVER.paymentMethod(runners[inSelected]["race"],inTimers,true)
								inRunners = false
								inRace = false
								RemoveBlip(blipRace)
							else
								inCheckpoint = 1
								inLaps = inLaps + 1
								RemoveBlip(blipRace)
								createBlipsRace()
							end
						else
							inCheckpoint = inCheckpoint + 1
							RemoveBlip(blipRace)
							createBlipsRace()
						end
					end
				end
			else
				for k,v in pairs(runners) do
					local distance = #(coords - vector3(v["init"][1],v["init"][2],v["init"][3]))
					if distance <= 50 then
						timeDistance = 4
						DrawMarker(23,v["init"][1],v["init"][2],v["init"][3]-0.95,0,0,0,0,0,0,10.5,10.5,1.5,42,137,255,100,0,0,0,0)						

						if IsControlJustPressed(1,38) and distance <= 5 then
								if vSERVER.checkTicket() then
									inSelected = parseInt(k)
									inRunners = true
									inCheckpoint = 1
									inTimers = 0
									inLaps = 1
									inRace = true
									timeRace = parseInt(runners[inSelected].time)

									createBlipsRace()
									vSERVER.startRace()
							end
						end						
					end
				end
			end
		else
			if inRunners then
				inRunners = false
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
		local timeDistance = 500
		if inRunners then
			timeDistance = 10
			inTimers = inTimers + 1
		end
		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------

function dwText(text,s1,s2,x,y,alpha,shadow)
	SetTextFont(6)
	SetTextScale(s1,s2)
	SetTextColour(255,255,255,alpha)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	if shadow then
		SetTextDropShadow(1)
	end
	DrawText(x,y)
end

function dwText2(text,s1,s2,x,y,alpha,shadow)
	SetTextFont(6)
	SetTextScale(s1,s2)
	SetTextColour(255,255,255,alpha)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentFormattedInteger(text, true)
	if shadow then
		SetTextDropShadow(1)
	end
	
	if parseInt(text) < 999  then
		DrawText(x,y)
	elseif parseInt(text) > 999 and parseInt(text) < 9999 then
		DrawText(x-0.003,y)
	elseif parseInt(text) > 9999 and parseInt(text) < 99999 then
		DrawText(x-0.006,y)
	elseif parseInt(text) > 99999 and parseInt(text) < 999999 then
		DrawText(x-0.009,y)
	elseif parseInt(text) > 999999 and parseInt(text) < 9999999 then
		DrawText(x-0.012,y)
	end
	
end

function createBlipsRace()
	blipRace = AddBlipForCoord(runners[inSelected]["coords"][inCheckpoint][1],runners[inSelected]["coords"][inCheckpoint][2],runners[inSelected]["coords"][inCheckpoint][3])
	SetBlipSprite(blipRace,1)
	SetBlipColour(blipRace,3)
	SetBlipScale(blipRace,0.4)
	SetBlipAsShortRange(blipRace,false)
	SetBlipRoute(blipRace,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Checkpoint")
	EndTextCommandSetBlipName(blipRace)
end