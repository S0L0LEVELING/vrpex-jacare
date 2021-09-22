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
Tunnel.bindInterface("vrp_doors",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS 
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = {
	[1] = { ['x'] = 464.1, ["y"] = -996.61, ["z"] = 26.38, ["hash"] = 1830360419, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[2] = { ['x'] = 468.29, ['y'] = -1014.15, ['z'] = 26.38, ["hash"] = -692649124, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 2, },
	[3] = { ['x'] = 468.96, ['y'] = -1014.09, ['z'] = 26.38, ["hash"] = -692649124, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 3, },
	[4] = { ['x'] = 476.71, ["y"] = -1008.14, ["z"] = 26.33, ["hash"] = -53345114, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[5] = { ['x'] = 477.06, ["y"] = -1012.09, ["z"]= 26.33, ["hash"] = -53345114, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[6] = { ['x'] = 471.44, ["y"] = -985.9, ["z"] = 26.38, ["hash"] = -1406685646, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 7, },
	[7] = { ['x'] = 471.59, ["y"] = -986.67, ["z"] = 26.38, ["hash"] = -96679321, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 6, },
	[8] = { ['x'] = 480.05, ["y"] = -1012.32, ["z"] = 26.31, ["hash"] = -53345114, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[9] = { ['x'] = 483.06, ["y"] = -1012.32, ["z"] = 26.31, ["hash"] = -53345114, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[10] = { ['x'] = 486.22, ["y"] = -1012.37, ["z"] = 26.28, ["hash"] = -53345114, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[11] = { ['x'] = 474.78, ["y"] = -991.96, ["z"] = 26.28, ["hash"] = -1258679973, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[12] = { ['x'] = 484.95, ["y"] = -1007.85, ["z"] = 26.33, ["hash"] = -53345114, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[13] = { ['x'] = 481.82, ["y"] = -1004.13, ["z"] = 26.33, ["hash"] = -53345114, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[14] = { ['x'] = 464.13, ["y"] = -975.54, ["z"] = 26.38, ["hash"] = 1830360419, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[15] = { ['x'] = -453.49, ['y'] = 6011.35, ['z'] = 31.72, ["hash"] = 3775898501, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[16] = { ['x'] = -451.63, ['y'] = 6006.86, ['z'] = 31.79, ["hash"] = 452874391, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[17] = { ['x'] = -446.45, ['y'] = 6001.66, ['z'] = 31.72, ["hash"] = 452874391, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[18] = { ['x'] = -436.75, ['y'] = 5991.93, ['z'] = 31.72, ["hash"] = 3283274690, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[19] = { ['x'] = -431.98, ['y'] = 6000.44, ['z'] = 31.72, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[20] = { ['x'] = -428.85, ['y'] = 5997.38, ['z'] = 31.72, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[21] = { ['x'] = -441.78, ['y'] = 6004.28, ['z'] = 31.72, ["hash"] = 3342610948, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[22] = { ['x'] = -438.45, ['y'] = 6007.65, ['z'] = 31.72, ["hash"] = 3342610948, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[23] = { ['x'] = 457.59, ["y"] = -996.31, ["z"] = 30.79, ["hash"] = 149284793, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[24] = { ['x'] = 479.89, ["y"] = -998.73, ["z"] = 30.8, ["hash"] = -692649124, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[25] = { ['x'] = 486.54, ["y"] = -1000.08, ["z"] = 30.8, ["hash"] = -692649124, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[26] = { ['x'] = 464.2, ["y"] = -983.72, ["z"] = 43.78, ["hash"] = -692649124, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[29] = { ["x"] = -14.14, ["y"] = -1441.17, ["z"] = 31.11, ["hash"] = 520341586, ["lock"] = true, ["text"] = false, ["distance"] = 10, ["press"] = 1.5, ["perm"] = "Admin", },
	[28] = { ["x"] = 981.72, ["y"] = -102.78, ["z"] = 74.85, ["hash"] = 190770132, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "TheLost", },
	[29] = { ["x"] = 1846.049, ["y"] = 2604.733, ["z"] = 45.579, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 10, ["press"] = 10.0, ["perm"] = "Police", },
	[30] = { ["x"] = 1819.475, ["y"] = 2604.743, ["z"] = 45.577, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 10, ["press"] = 10.0, ["perm"] = "Police", },
	[31] = { ["x"] = 457.36, ["y"] = -972.36, ["z"] = 30.75, ["hash"] = -1547307588, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 32, },
	[32] = { ["x"] = 456.69, ["y"] = -972.27, ["z"] = 30.71, ["hash"] = -1547307588, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 31, },
	[33] = { ["x"] = 452.22, ["y"] = -1001.26, ["z"] = 25.78, ["hash"] = 2130672747, ["lock"] = true, ["text"] = true, ["distance"] = 10, ["press"] = 10.0, ["perm"] = "Police" },
	[34] = { ["x"] = 431.58, ["y"] = -1001.3, ["z"] = 25.78, ["hash"] = 2130672747, ["lock"] = true, ["text"] = true, ["distance"] = 10, ["press"] = 10.0, ["perm"] = "Police" },
	[35] = { ["x"] = 441.42, ["y"] = -977.66, ["z"] = 30.79, ["hash"] = -1406685646, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police" },
	[36] = { ["x"] = 441.42, ["y"] = -986.04, ["z"] = 30.79, ["hash"] = -96679321, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police" },
	[37] = { ["x"] = 442.29, ["y"] = -998.7, ["z"] = 30.76, ["hash"] = -1547307588, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 38, },
	[38] = { ["x"] = 441.43, ["y"] = -998.67, ["z"] = 30.75, ["hash"] = -1547307588, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 37, },
	[39] = { ["x"] = 481.25, ["y"] = -997.87, ["z"] = 26.38, ["hash"] = 149284793, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 40, },
	[40] = { ["x"] = 480.6, ["y"] = -997.83, ["z"] = 26.38, ["hash"] = 149284793, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 39, },
	[41] = { ["x"] = 471.34, ["y"] = -1008.65, ["z"] = 26.38, ["hash"] = 149284793, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 42, },
	[42] = { ["x"] = 471.35, ["y"] = -1009.28, ["z"] = 26.38, ["hash"] = 149284793, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["other"] = 41, },
	[43] = { ["x"] = 313.16, ["y"] = -596.41, ["z"] = 43.29, ["hash"] = 854291622, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Paramedic", },
	[44] = { ["x"] = 348.96, ["y"] = -587.19, ["z"] = 43.29, ["hash"] = -434783486, ["lock"] = false, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Paramedic", ["other"] = 45, },
	[45] = { ["x"] = 348.73, ["y"] = -587.88, ["z"] = 43.29, ["hash"] = -1700911976, ["lock"] = false, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Paramedic", ["other"] = 44, },
	[46] = { ["x"] = 1785.35, ["y"] = 2600.18, ["z"] = 45.85, ["hash"] = -1033001619, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[47] = { ["x"] = 1782.73, ["y"] = 2597.95, ["z"] = 45.72, ["hash"] = -1033001619, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[48] = { ["x"] = 1779.96, ["y"] = 2597.12, ["z"] = 45.72, ["hash"] = -688867873, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[49] = { ["x"] = 1777.03, ["y"] = 2597.17, ["z"] = 45.72, ["hash"] = -688867873, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[50] = { ["x"] = 1774.07, ["y"] = 2597.16, ["z"] = 45.72, ["hash"] = -688867873, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[51] = { ["x"] = 1772.68, ["y"] = 2598.63, ["z"] = 45.72, ["hash"] = -688867873, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[52] = { ["x"] = 1782.71, ["y"] = 2586.54, ["z"] = 45.71, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[53] = { ["x"] = 1782.72, ["y"] = 2582.43, ["z"] = 45.71, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[54] = { ["x"] = 1782.72, ["y"] = 2578.27, ["z"] = 45.72, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[55] = { ["x"] = 782.7, ["y"] = 2574.16, ["z"] = 45.72, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[56] = { ["x"] = 1782.74, ["y"] = 2570.12, ["z"] = 45.72, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[57] = { ["x"] = 1769.06, ["y"] = 2568.55, ["z"] = 45.73, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[58] = { ["x"] = 1769.07, ["y"] = 2572.62, ["z"] = 45.73, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[59] = { ["x"] = 1769.1, ["y"] = 2580.9, ["z"] = 45.73, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[60] = { ["x"] = 1769.11, ["y"] = 2584.98, ["z"] = 45.72, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[61] = { ["x"] = 1770.99, ["y"] = 2588.45, ["z"] = 45.73, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[62] = { ["x"] = 1769.1, ["y"] = 2590.31, ["z"] = 45.73, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[63] = { ["x"] = 1761.57, ["y"] = 2588.45, ["z"] = 45.73, ["hash"] = -1033001619, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[64] = { ["x"] = 1771.39, ["y"] = 2566.6, ["z"] = 45.74, ["hash"] = -1033001619, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[65] = { ["x"] = 1775.51, ["y"] = 2588.43, ["z"] = 49.72, ["hash"] = -1033001619, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[66] = { ["x"] = 1845.46, ["y"] = 2586.27, ["z"] = 45.9, ["hash"] = -1033001619, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[67] = { ["x"] = 1782.71, ["y"] = 2574.18, ["z"] = 45.72, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[68] = { ["x"] = 1769.07, ["y"] = 2576.79, ["z"] = 45.73, ["hash"] = -1612152164, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[69] = { ["x"] = 1187.86, ["y"] = 2645.35, ["z"] = 38.37, ["hash"] = -1335311341, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mechanic", }, --JACARE MECANICA NORTE
	[70] = { ["x"] = 1182.27, ["y"] = 2645.76, ["z"] = 37.78, ["hash"] = -822900180, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mechanic", }, --JACARE MECANICA NORTE
	[71] = { ["x"] = 1174.72, ["y"] = 2645.55, ["z"] = 37.72, ["hash"] = -822900180, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mechanic", }, --JACARE MECANICA NORTE
	[72] = { ["x"] = -206.25, ["y"] = -1331.98, ["z"] = 34.9, ["hash"] = 1289778077, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "TheLost", },
	[73] = { ["x"] = -206.22, ["y"] = -1341.34, ["z"] = 34.9, ["hash"] = 1289778077, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "TheLost", },
	[74] = { ["x"] = 488.88, ["y"] = -1022.36, ["z"] = 28.14, ["hash"] = -1603817716, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Police", },
	[75] = { ["x"] = -202.5, ["y"] = -1310.69, ["z"] = 31.3, ["hash"] = 1792343474, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Bennys", },
	[76] = { ["x"] = 1407.01, ["y"] = 1127.97, ["z"] = 114.34, ["hash"] = 262671971, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Madrazo", },
	[77] = { ["x"] = 95.3, ["y"] = -1285.57, ["z"] = 29.29, ["hash"] = 668467214, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Vannila", },
	[78] = { ["x"] = -1828.68, ["y"] = 418.79, ["z"] = 121.64, ["hash"] = -1438552720, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Mercenarios", },
	[79] = { ["x"] = -1804.6, ["y"] = 435.97, ["z"] = 128.84, ["hash"] = 2074032093, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Mercenarios", },
	[80] = { ["x"] = -1804.57, ["y"] = 429.01, ["z"] = 128.73, ["hash"] = 1826999110, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Mercenarios", },
	[81] = { ["x"] = -1816.27, ["y"] = 424.27, ["z"] = 128.34, ["hash"] = 451660698, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Mercenarios", ["other"] = 82, },
	[82] = { ["x"] = -1815.58, ["y"] = 424.09, ["z"] = 128.34, ["hash"] = 451660698, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Mercenarios", ["other"] = 81, },
	[83] = { ["x"] = -1787.91, ["y"] = 411.84, ["z"] = 113.59, ["hash"] = -8018117937, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Mercenarios", },
	[84] = { ["x"] = -1792.54, ["y"] = 412.09, ["z"] =  113.46, ["hash"] = 149328230, ["lock"] = true, ["text"] = true, ["distance"] = 8, ["press"] = 1.5, ["perm"] = "Mercenarios", },
	[85] = { ["x"] = 2523.47, ["y"] = -335.4, ["z"] = 101.9, ["hash"] = -2023754432, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[86] = { ["x"] = 2498.04, ["y"] = -353.89, ["z"] = 82.3, ["hash"] = -2023754432 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[87] = { ["x"] = 2517.81, ["y"] = -327.27, ["z"] = 101.9, ["hash"] = -825682688 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[88] = { ["x"] = 2513.14, ["y"] = -328.52, ["z"] = 105.7, ["hash"] = -2051651622 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[89] = { ["x"] = 2510.39, ["y"] = -330.96, ["z"] = 105.7, ["hash"] = -2051651622 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[90] = { ["x"] = 2505.15, ["y"] = -349.26, ["z"] = 105.7, ["hash"] = 395979613 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[100] = { ["x"] = 2504.94, ["y"] = -351.3, ["z"] = 105.7, ["hash"] = 395979613 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[101] = { ["x"] = 2507.17, ["y"] = -348.74, ["z"] = 105.7, ["hash"] = 395979613 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[102] = { ["x"] = 2507.72, ["y"] = -354.05, ["z"] = 105.7, ["hash"] = 395979613 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
	[103] = { ["x"] = 2510.17, ["y"] = -351.84, ["z"] = 105.7, ["hash"] = 395979613 ,["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS -1787.91,411.84,113.59
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("vrp_doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("vrp_sound:source",source,"doorlock",0.1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_doors:doorsStatistics")
AddEventHandler("vrp_doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("vrp_doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_doors:doorsUpdate",source,doors)
end)

