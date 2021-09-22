-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_atm",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local atmTimers = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(atmTimers) do
			if v[1] > 0 then
				v[1] = v[1] - 10
				if v[1] <= 0 then
					atmTimers[k] = nil
				end
			end
		end
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSALDO
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getSaldo()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getBank(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SACARVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.sacarValor(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(valor) > 5000 then
			TriggerClientEvent("Notify",source,"amarelo","O valor máximo de uma retirada é <b>$5.000</b> dólares.",5000)
			return vRP.getBank(user_id)
		end

		if parseInt(valor) > 0 then
			if atmTimers[user_id] then
				if atmTimers[user_id][1] > 0 and atmTimers[user_id][2] >= 5000 then
					TriggerClientEvent("Notify",source,"amarelo","Aguarde "..vRP.getTimers(parseInt(atmTimers[user_id][1])).."</b>.",5000)
					return vRP.getBank(user_id)
				end

				if (atmTimers[user_id][2] + parseInt(valor)) <= 5000 then
					if vRP.withdrawCash(user_id,parseInt(valor)) then
						atmTimers[user_id][2] = atmTimers[user_id][2] +  parseInt(valor)
					else
						TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de retiradas.",5000)
				end
			else
				if vRP.withdrawCash(user_id,parseInt(valor)) then
					atmTimers[user_id] = { 600,parseInt(valor) }
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			end
		end

		return vRP.getBank(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERIRVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.transferirValor(valor,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,valor) then
			vRP.addBank(target,valor)

			local nSource = vRP.getUserSource(target)
			if nSource then
				TriggerClientEvent("itensNotify",nSource,{ "+","dollars",vRP.format(valor),"Dólares" })
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",3000)
		end

		return vRP.getBank(user_id)
	end
end