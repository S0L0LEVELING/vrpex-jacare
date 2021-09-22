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
Tunnel.bindInterface("vrp_crafting",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
	["mafiaCrafting"] = {
		["perm"] = "Mafia",
		["list"] = {
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 400,
					["copper"] = 200,
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 200,
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 280,
					["copper"] = 150,
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100,
				}
			},
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100,
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100,
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 150
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 150
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 100
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 150
					}
				}
			}
		},
		["MechanicCrafting"] = {
		["perm"] = "Mechanic",
		["list"] = {
			["tires"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 32
				}
			},
			["toolbox"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 14,
					["aluminum"] = 6,
					["copper"] = 6
				}
			}
		}
	},
	["BennysCrafting"] = {
		["perm"] = "Bennys",
		["list"] = {
			["tires"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 16
				}
			},
			["toolbox"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 17,
					["copper"] = 12
				}
			}
		}
	},
	["thelostCrafting"] = {
		["perm"] = "TheLost",
		["list"] = {
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 400,
					["copper"] = 200,
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 200,
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 280,
					["copper"] = 150,
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100,
				}
			},
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100,
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100,
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 150
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 150
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 100
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 150
					}
				}
			}
		},
		["MercenariosMuni"] = {
			["perm"] = "Mercenarios",
			["list"] = {
				["WEAPON_PISTOL_AMMO"] = {
					["amount"] = 50,
					["destroy"] = true,
					["require"] = {
						["aluminum"] = 12,
						["copper"] = 8
					}
				},
				["WEAPON_SMG_AMMO"] = {
					["amount"] = 50,
					["destroy"] = true,
					["require"] = {
						["aluminum"] = 40,
						["copper"] = 45
					}
				},
				["WEAPON_RIFLE_AMMO"] = {
					["amount"] = 50,
					["destroy"] = true,
					["require"] = {
						["aluminum"] = 50,
						["copper"] = 55
					}
				}
			}
		},
		["MadrazoMuni"] = {
		["perm"] = "Madrazo",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 50,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 8
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 50,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 40,
					["copper"] = 45
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 50,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 50,
					["copper"] = 55
				}
			}
		}
	},
	["moneyWashfree"] = {
		["perm"] = "Vannila",
		["list"] = {
			["dollars"] = {
				["amount"] = 100000,
				["destroy"] = true,
				["require"] = {
					["dollars2"] = 100000,
					["notebook"] = 1
				}
			}
		}
	},
	["YellowCraft"] = {
		["perm"] = "Amarelos",
		["list"] = {
			["backpackp"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["cloth"] = 15
				}
			},
			["backpackm"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["cloth"] = 25
				}
			},
			["backpackx"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["cloth"] = 35
				}
			},
			["hood"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["cloth"] = 30
				}
			},
			["vest"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 40,
					["cloth"] = 55
				}
			}
		}
	},
	["lester"] = {
		["list"] = {
			["plate"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 50
				}
			}
		}
	},
	["bennysCraft"] = {
		["perm"] = "Bennys2",
		["list"] = {
			["fueltech"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["cpuchip"] = 25
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["plastic"] = 10,
					["aluminum"] = 15,
					["copper"] = 10
				}
			}
		}
	},
	["foodMarket"] = {
		["list"] = {
			["hamburger2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["meat"] = 1,
					["bread"] = 3,
					["ketchup"] = 1
				}
			},
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["tomato"] = 10
				}
			},
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["strawberry"] = 3,
					["banana"] = 3,
					["orange"] = 3,
					["water"] = 1
				}
			}
		}
	},
	["recyclingSell"] = {
		["list"] = {
			["glass"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["glassbottle"] = 1 
				}
			},
			["plastic"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["emptybottle"] = 1
				}
			},
			["aluminum"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["copper"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["battery"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["elastic"] = 1
				}
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestPerm(craftType)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if craftList[craftType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,craftList[craftType]["perm"]) then
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestCrafting(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(craftList[craftType]["list"]) do
			local craftList = {}
			for k,v in pairs(v.require) do
				table.insert(craftList,{ name = vRP.itemNameList(k), amount = v })
			end

			table.insert(inventoryShop,{ name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k), list = craftList })
		end

		local inventoryUser = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.functionCrafting(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
				if vRP.getInventoryItemAmount(user_id,k) < parseInt(v*shopAmount) then
					return
				end
				Citizen.Wait(1)
			end

			for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
				vRP.removeInventoryItem(user_id,k,parseInt(v*shopAmount))
				Citizen.Wait(1)
			end

			if string.sub(shopItem,1,9) == "toolboxes" then
				local advAmount = 0

				repeat
					Citizen.Wait(1)
					advAmount = advAmount + 1
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)
					local number = 0

					repeat
						Citizen.Wait(1)
						number = number + 1
					until advDecode[tostring("toolboxes"..number)] == nil

					advDecode[tostring("toolboxes"..number)] = 10
					vRP.giveInventoryItem(user_id,tostring("toolboxes"..number),1,false)
					SaveResourceFile("logsystem","toolboxes.json",json.encode(advDecode),-1)
				until advAmount == shopAmount
			else
				vRP.giveInventoryItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"]*shopAmount,false,slot)
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.functionDestroy(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			if craftList[shopType]["list"][shopItem]["destroy"] then
				if vRP.tryGetInventoryItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"]) then
					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						if parseInt(v) <= 1 then
							vRP.giveInventoryItem(user_id,k,1)
						else
							vRP.giveInventoryItem(user_id,k,v/2)
						end
						Citizen.Wait(1)
					end
				end
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_crafting:populateSlot")
AddEventHandler("vrp_crafting:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			vCLIENT.updateCrafting(source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_crafting:updateSlot")
AddEventHandler("vrp_crafting:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end)