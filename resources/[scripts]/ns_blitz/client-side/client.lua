-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("ns_blitz", cRP)
vSERVER = Tunnel.getInterface("ns_blitz")

local open = false
local colocando = false
local obstaculo = ""

function closeBlitz()
    open = false
    SetNuiFocus(false, false)
    vRP._DeletarObjeto()
    vRP._stopAnim(false)
    SendNUIMessage({
        type = 'fecharBlitz'
    })
    ClearPedTasks(PlayerPedId())
end

Citizen.CreateThread(function()
    closeBlitz()
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "fecharBlitz" then
        closeBlitz()
    end

    if data.action == "setObstaculo" then
        createObstaculo(data.obstaculo, data.nome)
    end

    if data.action == "clearArea" then
        clearAll()
    end

end)

RegisterCommand('blitz', function(source, args, rawCommand)
    if vSERVER.checkPermission("police") then
        open = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'abrirBlitz'
        })
    end
end)

function clearAll()
    local objeto = nil
    local props = {"prop_mp_cone_02", "prop_barrier_wat_03a", "prop_mp_cone_04", "prop_mp_barrier_02b",
                   "prop_mp_barrier_01", "prop_mp_conc_barrier_01", "prop_mp_arrow_barrier_01", "p_ld_stinger_s"}

    for k, v in pairs(props) do
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.94)
        local prop = v
        local h = GetEntityHeading(PlayerPedId())
        while DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 5.0, GetHashKey(prop), true) do
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 5.0, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end
    end
end

function removeObstaculo()
    local objeto = nil
    if obstaculo == "cone" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.94)
        local prop = "prop_mp_cone_02"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end

    elseif obstaculo == "cone2" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.94)
        local prop = "prop_barrier_wat_03a"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end

    elseif obstaculo == "cone3" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.94)
        local prop = "prop_mp_cone_04"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end

    elseif obstaculo == "barricada" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
        local prop = "prop_mp_barrier_02b"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end

    elseif obstaculo == "barricadab" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
        local prop = "prop_mp_barrier_01"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end

    elseif obstaculo == "barricadac" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
        local prop = "prop_mp_conc_barrier_01"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end

    elseif obstaculo == "barricadas" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
        local prop = "prop_mp_arrow_barrier_01"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end

    elseif obstaculo == "spike" then
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0.0)
        local prop = "p_ld_stinger_s"
        local h = GetEntityHeading(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), true) then
            objeto = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey(prop), false, false, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
            SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(objeto))
            DeleteObject(objeto)
        end
    end
end

function createObstaculo(p_obstaculo, p_nome)
    closeBlitz()

    obstaculo = p_obstaculo
    if p_nome ~= "d" then
        colocando = true
        SendNUIMessage({
            type = 'abrirInfo',
            obj = p_nome
        })
    else
        removeObstaculo()
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if colocando then
            local colocado = false
            if IsControlJustPressed(1, 23) then -- F
                colocado = true
                SendNUIMessage({
                    type = 'fecharInfo'
                })
            end

            if IsControlJustPressed(1, 45) then -- R
                removeObstaculo()
            end

            if IsControlJustPressed(1, 38) then -- E
                local objeto = nil

                if obstaculo == "cone" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.94)
                    local prop = "prop_mp_cone_02"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.5, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h)
                    FreezeEntityPosition(objeto, true)

                elseif obstaculo == "cone2" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.94)
                    local prop = "prop_barrier_wat_03a"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.5, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h)
                    FreezeEntityPosition(objeto, true)

                elseif obstaculo == "cone3" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
                    local prop = "prop_mp_cone_04"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.95, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h - 180)
                    FreezeEntityPosition(objeto, true)

                elseif obstaculo == "barricada" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
                    local prop = "prop_mp_barrier_02b"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.95, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h - 180)
                    FreezeEntityPosition(objeto, true)

                elseif obstaculo == "barricadab" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
                    local prop = "prop_mp_barrier_01"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.95, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h - 180)
                    FreezeEntityPosition(objeto, true)

                elseif obstaculo == "barricadac" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
                    local prop = "prop_mp_conc_barrier_01"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.95, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h - 180)
                    FreezeEntityPosition(objeto, true)

                elseif obstaculo == "barricadas" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, -0.94)
                    local prop = "prop_mp_arrow_barrier_01"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y - 0.95, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h - 180)
                    FreezeEntityPosition(objeto, true)

                elseif obstaculo == "spike" then
                    local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0.0)
                    local prop = "p_ld_stinger_s"
                    local h = GetEntityHeading(PlayerPedId())
                    objeto = CreateObject(GetHashKey(prop), coord.x, coord.y, coord.z, true, true, true)
                    PlaceObjectOnGroundProperly(objeto)
                    SetModelAsNoLongerNeeded(objeto)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, objeto, true, true)
                    SetEntityHeading(objeto, h - 90)
                    FreezeEntityPosition(objeto, true)

                end
            end

            if colocado then
                colocando = false
                open = true
                SetNuiFocus(true, true)
                SendNUIMessage({
                    type = 'abrirBlitz'
                })
            end
        end
    end
end)

-- Verificação para o spike sumir quando alguém passar por cima
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local vcoord = GetEntityCoords(veh)
        local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.94)
        if IsPedInAnyVehicle(PlayerPedId()) then
            if DoesObjectOfTypeExistAtCoords(vcoord.x, vcoord.y, vcoord.z, 0.9, GetHashKey("p_ld_stinger_s"), true) then
                SetVehicleTyreBurst(veh, 0, true, 1000.0)
                SetVehicleTyreBurst(veh, 1, true, 1000.0)
                SetVehicleTyreBurst(veh, 2, true, 1000.0)
                SetVehicleTyreBurst(veh, 3, true, 1000.0)
                SetVehicleTyreBurst(veh, 4, true, 1000.0)
                SetVehicleTyreBurst(veh, 5, true, 1000.0)
                SetVehicleTyreBurst(veh, 6, true, 1000.0)
                SetVehicleTyreBurst(veh, 7, true, 1000.0)
                if DoesObjectOfTypeExistAtCoords(coord.x, coord.y, coord.z, 0.9, GetHashKey("p_ld_stinger_s"), true) then
                    spike = GetClosestObjectOfType(coord.x, coord.y, coord.z, 0.9, GetHashKey("p_ld_stinger_s"), false,
                                false, false)
                    Citizen.InvokeNative(0xAD738C3085FE7E11, spike, true, true)
                    SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(spike))
                    DeleteObject(spike)
                end
            end
        end
    end
end)
