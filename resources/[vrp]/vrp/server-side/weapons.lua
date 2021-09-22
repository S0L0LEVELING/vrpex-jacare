local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET WEAPONS ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getWeaponsId(user_id)
    local infos = vRP.query("vRP/get_weapon",{ user_id = user_id })
	return infos
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD WEAPONS ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addWeaponId(user_id,weapon,ammo)
    local data = vRP.getWeaponsId(user_id)
    if data then
	    for k, v in pairs(data) do
	    	if v.weapon == weapon then
                local newammo = v.ammo + ammo
                vRP.execute("vRP/del_weapon", { user_id = user_id, weapon = weapon })
                vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = newammo })
            elseif not v.weapon then
                vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
            end
        end
    end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM AMMO ID
-----------------------------------------------------------------------------------------------------------------------------------------

local weapon_types = {
	"WEAPON_KNIFE",
	"WEAPON_HATCHET",
	"WEAPON_BAT",
	"WEAPON_BATTLEAXE",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_DAGGER",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_MACHETE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_SWITCHBLADE",
	"WEAPON_WRENCH",
	"WEAPON_KNUCKLE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_APPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_REVOLVER",
	"WEAPON_COMBATPISTOL",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_MILITARYRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GUSENBERG",
	"WEAPON_PETROLCAN",
	"GADGET_PARACHUTE",
	"WEAPON_STUNGUN",
	"WEAPON_FIREEXTINGUISHER"
}

function vRP.remAmmoWeaponId(user_id,weapon,ammo)
    local data = vRP.getWeaponsId(user_id)
    local wps = vRP.getWeaponsId(user_id)
    if data then
        for k, v in pairs(data) do
            if v.weapon == weapon then
                for k2, v2 in pairs(weapon_types) do
					if vRP.itemAmmoList(v2) == vRP.itemAmmoList(v.weapon) then
						for k3, v3 in pairs(wps) do
							if vRP.itemAmmoList(v.weapon) == vRP.itemAmmoList(v3.weapon) then
								vRP.execute("vRP/del_weapon", { user_id = user_id, weapon = v3.weapon })
								vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = v3.weapon, ammo = ammo })
							end							
						end
					end
				end
            elseif not v.weapon then
                vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
            end
        end
    end
	return true
end