-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_farm",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO 
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Verdes") or vRP.hasPermission(user_id,"Azul") or vRP.hasPermission(user_id,"Roxos") or vRP.hasPermission(user_id,"Vermelhos") or vRP.hasPermission(user_id,"Mafia") or vRP.hasPermission(user_id,"Mercenarios") or vRP.hasPermission(user_id,"Madrazo") or vRP.hasPermission(user_id,"TheLost") or vRP.hasPermission(user_id,"Bahamas") or vRP.hasPermission(user_id,"Vannila") or vRP.hasPermission(user_id,"Sport") or vRP.hasPermission(user_id,"Bennys") then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem acesso.")
			return false
		end						
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PAGAMENTO 
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Verdes") then
			local itens = math.random(100)
			local quantidade = math.random(5,10)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  	end
					vRP.giveInventoryItem(user_id,"lean",parseInt(quantidade),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end

		elseif vRP.hasPermission(user_id,"Azul") then
			local itens = math.random(100)
			local quantidade = math.random(5,10)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  	end
					vRP.giveInventoryItem(user_id,"ecstasy",parseInt(quantidade),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end	


		elseif vRP.hasPermission(user_id,"Roxos") then
			local itens = math.random(100)
			local quantidade = math.random(5,10)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  	end
					vRP.giveInventoryItem(user_id,"cocaine",parseInt(quantidade),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end

		elseif vRP.hasPermission(user_id,"Vermelhos") then
			local itens = math.random(100)
			local quantidade = math.random(5,10)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  	end
					vRP.giveInventoryItem(user_id,"analgesic",parseInt(quantidade),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end

		elseif vRP.hasPermission(user_id,"Mafia") then
			local itens = math.random(100)
			local quantidade = math.random(15,25)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  	end
					vRP.giveInventoryItem(user_id,"aco",parseInt(quantidade),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end

		elseif vRP.hasPermission(user_id,"TheLost") then
			local itens = math.random(100)
			local quantidade = math.random(15,25)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  	end
					vRP.giveInventoryItem(user_id,"aco",parseInt(quantidade),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end	

		elseif vRP.hasPermission(user_id,"Mercenarios") then
			local itens = math.random(100)
			local quantidade = math.random(20,28)
			local quantidadeCopper = math.random(35,50)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  end
				  vRP.giveInventoryItem( user_id,"gunpowder",parseInt(quantidade),true)
				  vRP.giveInventoryItem( user_id,"copper",parseInt(quantidadeCopper),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end

		elseif vRP.hasPermission(user_id,"Madrazo") then
			local itens = math.random(100)
			local quantidade = math.random(20,28)
			local quantidadeCopper = math.random(35,50)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  end
					vRP.giveInventoryItem( user_id,"gunpowder",parseInt(quantidade),true)
					vRP.giveInventoryItem( user_id,"copper",parseInt(quantidadeCopper),true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end

		elseif vRP.hasPermission(user_id,"Vannila") then
			local itens = math.random(100)
			local quantidade = math.random(10,15)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  end
					vRP.giveInventoryItem( user_id,"eletronics",parseInt(quantidade),true)
					vRP.giveInventoryItem( user_id,"aco",1,true)
					vRP.giveInventoryItem( user_id,"cloth",2,true)
					vRP.giveInventoryItem( user_id,"plastic",1,true)
					vRP.giveInventoryItem( user_id,"aluminum",1,true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
				
		elseif vRP.hasPermission(user_id,"Bahamas") then
			local itens = math.random(100)
			local quantidade = math.random(10,15)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  end
					vRP.giveInventoryItem( user_id,"eletronics",parseInt(quantidade),true)
					vRP.giveInventoryItem( user_id,"aco",1,true)
					vRP.giveInventoryItem( user_id,"cloth",2,true)
					vRP.giveInventoryItem( user_id,"plastic",1,true)
					vRP.giveInventoryItem( user_id,"aluminum",1,true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
		
		elseif vRP.hasPermission(user_id,"Sport") then
			local itens = math.random(100)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
				  end
				  vRP.giveInventoryItem( user_id,"plastic",1,true)
				  vRP.giveInventoryItem( user_id,"aluminum",1,true)
				  vRP.giveInventoryItem( user_id,"aco",2,true)
				  vRP.giveInventoryItem( user_id,"paper",2,true)
				  vRP.giveInventoryItem( user_id,"ink",1,true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end

		elseif vRP.hasPermission(user_id,"Bennys") then
			local itens = math.random(100)
			if itens <= 100 then
				if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
					TriggerClientEvent("Notify",source,"negado","A sua Mochila está cheia.",5000)
					return
					end
					vRP.giveInventoryItem( user_id,"plastic",1,true)
					vRP.giveInventoryItem( user_id,"aluminum",1,true)
					vRP.giveInventoryItem( user_id,"aco",2,true)
					vRP.giveInventoryItem( user_id,"paper",2,true)
					vRP.giveInventoryItem( user_id,"ink",1,true)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end
		end
	return true			
end