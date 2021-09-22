local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:clear')
RegisterNetEvent('__cfx_internal:serverPrint')
RegisterNetEvent('_chat:messageEntered')

AddEventHandler('chatMessage', function(author, color, text)
	local args = { text }
	if author ~= "" then
		table.insert(args, 1, author)
	end
	SendNUIMessage({ type = 'ON_MESSAGE', message = { color = color, multiline = true, args = args } })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
	SendNUIMessage({ type = 'ON_MESSAGE', message = { templateId = 'print', multiline = true, args = { msg } } })
end)

AddEventHandler('chat:addMessage', function(message)
	SendNUIMessage({ type = 'ON_MESSAGE', message = message })
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
	SendNUIMessage({ type = 'ON_SUGGESTION_ADD', suggestion = suggestion })
end)

AddEventHandler('chat:removeSuggestion', function(name)
	SendNUIMessage({ type = 'ON_SUGGESTION_REMOVE', name = name })
end)

AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({ type = 'ON_TEMPLATE_ADD',template = { id = id, html = html } })
end)

AddEventHandler('chat:clear', function(name)
	SendNUIMessage({ type = 'ON_CLEAR' })
end)

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)

	if not data.canceled then
		local id = PlayerId()
		local r, g, b = 0, 0x99, 255

		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
		end
	end

	cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
	local themes = {}

	for resIdx = 0, GetNumResources() - 1 do
		local resource = GetResourceByFindIndex(resIdx)

		if GetResourceState(resource) == 'started' then
			local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

			if numThemes > 0 then
				local themeName = GetResourceMetadata(resource, 'chat_theme')
				local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

				if themeName and themeData then
					themeData.baseUrl = 'nui://' .. resource .. '/'
					themes[themeName] = themeData
				end
			end
		end
	end
	SendNUIMessage({ type = 'ON_UPDATE_THEMES', themes = themes })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

Citizen.CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false)

	while true do
		Citizen.Wait(1)
		if not chatInputActive then
			if IsControlPressed(0,245) then
				chatInputActive = true
				chatInputActivating = true

				SendNUIMessage({ type = 'ON_OPEN' })
			end
		end

		if chatInputActivating then
			if not IsControlPressed(0,245) then
				SetNuiFocus(true)
				chatInputActivating = false
			end
		end

		if chatLoaded then
			local shouldBeHidden = false

			if IsScreenFadedOut() or IsPauseMenuActive() then
				shouldBeHidden = true
			end

			if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
				chatHidden = shouldBeHidden
				SendNUIMessage({ type = 'ON_SCREEN_STATE_CHANGE', shouldHide = shouldBeHidden })
			end
		end
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/add', 'Adicionar mais funcionarios na organização.', {{ name="organização"},{ name="passaporte"}})
	TriggerEvent('chat:addSuggestion', '/rem', 'Remover funcionarios da organização.', {{ name="organização"},{ name="passaporte"}})
	TriggerEvent('chat:addSuggestion', '/trunkin', 'Entrar dentro do porta malas de um carro.')
	TriggerEvent('chat:addSuggestion', '/checktrunk', 'Checar se alguém tem dentro do porta malas.')
	TriggerEvent('chat:addSuggestion', '/enter', 'Entrar ou comprar casa.')
	TriggerEvent('chat:addSuggestion', '/premium', 'Ver quanto tempo de premium ainda tem.')
	TriggerEvent('chat:addSuggestion', '/tow', 'Colocar veiculos no reboque.')
	TriggerEvent('chat:addSuggestion', '/comprar', 'Comprar em maquinas.')
	TriggerEvent('chat:addSuggestion', '/trancar', 'Para abrir/fechar a porta da casa.')
	TriggerEvent('chat:addSuggestion', '/toogle', 'Para Entrar/Sair de serviço.')
    TriggerEvent('chat:addSuggestion', '/re', 'Para reanimar o paciente em coma.')
    TriggerEvent('chat:addSuggestion', '/tratamento', 'Para curar o paciente.')
    TriggerEvent('chat:addSuggestion', '/impound', 'Registrar o carro no dmv.')
	TriggerEvent('chat:addSuggestion', '/cv', 'Para colocar dentro do veículo.', {{ name="assento"}})
	TriggerEvent('chat:addSuggestion', '/rv', 'Para tirar do veículo.')
	TriggerEvent('chat:addSuggestion', '/lenhador', 'Iniciar o emprego de lenhador.')
	TriggerEvent('chat:addSuggestion', '/motorista', 'Iniciar o emprego de motorista.')
	TriggerEvent('chat:addSuggestion', '/lixeiro', 'Iniciar o emprego de lixeiro.')
	TriggerEvent('chat:addSuggestion', '/attachs', 'Para fazer melhorias no armamento.')
	TriggerEvent('chat:addSuggestion', '/rg', 'Para ver o passaporte da pessoa.', {{ name="passaporte"}})
	TriggerEvent('chat:addSuggestion', '/revistar', 'Para revistar um civil.')
    TriggerEvent('chat:addSuggestion', '/defuse', 'Defusar a bomba do veículo.')
    TriggerEvent('chat:addSuggestion', '/placa', 'Mostra a placa do veículo mais próximo.')
	TriggerEvent('chat:addSuggestion', '/multar', 'Aplicar multa no jogador destinado.')
	TriggerEvent('chat:addSuggestion', '/detido', 'Deixa o veículo na detenção.')
	TriggerEvent('chat:addSuggestion', '/procurado', 'Saber se você está sendo procurado pela policia.')
	TriggerEvent('chat:addSuggestion', '/seat', 'Para você trocar de assento em um veículo.')
	TriggerEvent('chat:addSuggestion', '/trunk', 'Abrir o porta malas é o porta luvas.')
	TriggerEvent('chat:addSuggestion', '/hood', 'Para abrir/fechar o capo.')
	TriggerEvent('chat:addSuggestion', '/doors', 'Para abrir/fechar as portas.')
	TriggerEvent('chat:addSuggestion', '/wins', 'Abrir e fechar os vidros do veículo.')
	TriggerEvent('chat:addSuggestion', '/garmas', 'Para desequipar todas as armas do inventário.')
	TriggerEvent('chat:addSuggestion', '/hud', 'Para você desabilitar a hud.')
	TriggerEvent('chat:addSuggestion', '/vtuning', 'Ver a porcentagem do veículo.')
    TriggerEvent('chat:addSuggestion', '/e', 'Executa uma animação', {{ name="nome"}})
	TriggerEvent('chat:addSuggestion', '/e2', 'Executa uma animação no jogador mais próximo.', {{ name="nome"}})
	TriggerEvent('chat:addSuggestion', '/cr', 'Travar/Destravar velecidade do veículo.', {{ name="velocidade"}})
    TriggerEvent('chat:addSuggestion', '/me', 'Falar no pensamento.', {{ name="texto"}})
    TriggerEvent('chat:addSuggestion', '/wecolor', 'Trocar as cores das armas.', {{ name="número"}})
	TriggerEvent('chat:addSuggestion', '/welux', 'Colocar estampas de luxo na arma.')
	TriggerEvent('chat:addSuggestion', '/diagnostic', 'Verificar o paciente.')
	TriggerEvent('chat:addSuggestion', '/setrepouso', 'Colocar o paciente de repouso.',{{ name="tempo"}})
	TriggerEvent('chat:addSuggestion', '/carregar2', 'Carregar uma pessoa no ombro.')
	TriggerEvent('chat:addSuggestion', '/faturas', 'Para fazer suas faturas.')
	TriggerEvent('chat:addSuggestion', '/hr', 'Chat interno entre os paramedicos.', {{ name="texto"}})
	TriggerEvent('chat:addSuggestion', '/pr', 'Chat interno entre os policiais.', {{ name="texto"}})
	TriggerEvent('chat:addSuggestion', '/carta', 'Mostrar uma carta para jogadores próximos.')
	TriggerEvent('chat:addSuggestion', '/mascara', 'Colocar ou tirar mascara.')
    TriggerEvent('chat:addSuggestion', '/chapeu', 'Colocar ou tirar chapeu.')
	TriggerEvent('chat:addSuggestion', '/oculos', 'Colocar ou tirar oculos.')
	TriggerEvent('chat:addSuggestion', '/vehs', 'Para você ver sua lista de veículos.')
	TriggerEvent('chat:addSuggestion', '/servico', 'Verificar quantos trabalhadores estão em seu expediente.')
	TriggerEvent('chat:addSuggestion', '/setrepouso', 'Colocar um civil em repouso.')
	TriggerEvent('chat:addSuggestion', '/andar', 'Mudar o jeito de andar', {{ name="número"}})
	TriggerEvent('chat:addSuggestion', '/livery', 'Muda o livery dos veiculos.', {{ name="número"}})
	TriggerEvent('chat:addSuggestion', '/extras', 'Muda o extras dos veiculos.', {{ name="número"}})
	TriggerEvent('chat:addSuggestion', '/preset', 'Colocar roupas do serviço.', {{ name="número"}})
	TriggerEvent('chat:addSuggestion', '/enter', 'Caso a casa esteja disponível aparece o valor para comprar.')
	TriggerEvent('chat:addSuggestion', '/homes add', 'Adiciona a permissão da residência para o passaporte escolhido.', {{ name="residência"},{ name="passaporte"}})
	TriggerEvent('chat:addSuggestion', '/homes check', 'Mostra todas as permissões da residência.', {{ name="residência"}})
	TriggerEvent('chat:addSuggestion', '/homes transfer', 'Transfere a residência ao passaporte escolhido.', {{ name="residência"},{ name="passaporte"}})
	TriggerEvent('chat:addSuggestion', '/homes rem', 'Remove a permissão da residência do passaporte escolhido.', {{ name="residência"},{ name="passaporte"}})
	TriggerEvent('chat:addSuggestion', '/homes tax', 'Efetua o pagamento da Property Tax da residência.', {{ name="residência"}})
	TriggerEvent('chat:addSuggestion', '/homes sell', 'Vender a casa para a prefeitura.', {{ name="residência"}})
	TriggerEvent('chat:addSuggestion', '/homes vault', 'comprar mais Kg para seu bau.', {{ name="residência"}})
    TriggerEvent('chat:addSuggestion', '/casas', 'Mostra no mapa todas as residências disponíveis a venda na cidade.')
    TriggerEvent('chat:addSuggestion', '/wardrobe', 'Mostra todos os outfits.')
	TriggerEvent('chat:addSuggestion', '/wardrobe save', 'Para adicionar um outfit ao seu Guarda-Roupas.', {{ name="nome"}})
	TriggerEvent('chat:addSuggestion', '/wardrobe rem', 'Para remover um outfit ao seu Guarda-Roupas.', {{ name="nome"}})
	TriggerEvent('chat:addSuggestion', '/wardrobe apply', 'Para colocar um outfit do seu Guarda-Roupas.', {{ name="nome"}})
	TriggerEvent('chat:addSuggestion', '/outfit save', 'Para salvar um outfit.')
	TriggerEvent('chat:addSuggestion', '/outfit', 'Aplicar o outfit.')
	TriggerEvent('chat:addSuggestion', '/premiumfit save', 'Para salvar um outfit premium.')
	TriggerEvent('chat:addSuggestion', '/premiumfit', 'Aplicar o outfit premium.')
	TriggerEvent('chat:addSuggestion', '/debug', 'Recarrega todas as configuraçôes do personagem.')
end)