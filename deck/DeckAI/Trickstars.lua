--[[ Para a definição das cartas que serão usadas:
61283655 Candina 80%
35199656 Lycoris 80%
98700941 Lilybell 40%
14558127 Ash Blossom 40% (ativa na primeira oportunidade, sempre em resposta a algo do oponente)
59438930 Ghost Ogre 40% (ativa na primeira oportunidade, sempre em resposta a algo do oponente)
94145021 Droll & Lock 40%
12580477 Raigeki 90%
73628505 Terraforming 90%
08267140 Cosmic Cyclone 90% (handled by generic AI, returns an error)
74519184 Hand Destruction 60%
85562745 Dark Room of Nightmare 90%
35371948 Light Stage 80%
09952083 Chain Summoning 50%
21076084 Reincarnation 40%
36468556 Ceasefire 40%
77561728 Disturbance Strategy 60%
40605147 Solemn Strike 0% (não está mas presente no deck)

essa porcentagem é um parametro que eu uso para mensurar quao proximo de um implementação total a carta e está

]]
function TrickstarsStartup(deck) --Para definição da inicialização da AI
AI.Chat("AI_Trickstars Burn v 0.1 (11 Feb 2018)")
AI.Chat("Scripted by Steelren")
AI.Chat("Good Luck and get ready to burn!")
  deck.Init                 = TrickstarsInit  --função de inicialização do deck, comtém os comandos executados na Main Phase
  deck.ActivateBlacklist    = TrickstarsActivateBlacklist --matriz com cartas que não podem ser ativadas pela Ai genérica
  deck.SummonBlacklist      = TrickstarsSummonBlacklist --matriz com monstros que não podem ser invocados pela Ai genérica
  deck.PriorityList         = TrickstarsPriorityList --qual a prioridade para uma carta ir para um dado local
  deck.Card                 = TrickstarsCard
  deck.Chain                = TrickstarsChain  --decide quando uma carta pode ser usada em chain
  deck.ChainOrder           = TrickstarsChainOrder --Não implementada corretamente
 -- deck.BattleCommand        = TrickstarsBattleCommands --não implementada corretamente
  deck.Unchainable          = TrickstarsUnchainable --cartas que a Ai não vai dar chain, a menos que eu tenha uma função
  deck.SetBlacklist         = TrickstarsSetBlacklist --cartas que a Ai nunca vai setar, a menos que eu  tenha uma função
  deck.EffectYesNo          = TrickstarsEffectYesNo --função usada quando um efeito faz a AI decidir Sim ou Não
  deck.Position             = TrickstarsPosition   --define em que posição um monstro deve ser invocado
end
TrickstarsIdentifier = 61283655 -- Trickstar Candina
DECK_Trickstars = NewDeck("Trickstars",TrickstarsIdentifier,TrickstarsStartup)

function TrickstarsInit(cards)
	local Act = cards.activatable_cards
	local Sum = cards.summonable_cards
	local SpSum = cards.spsummonable_cards
	local Rep = cards.repositionable_cards
	local SetMon = cards.monster_setable_cards
	local SetST = cards.st_setable_cards
	--durante a main phase, a Ai tenta ativar as cartas na ordem abaixo
	--então tente colocar primeiro o que você quer que vá primeiro
	if HasIDNotNegated(Act,12580477,UseRaigeki) then --ativar raigeki na main phase
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,73628505,UseTerra) then --ativar terraformin na main phase
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,74519184,UseHandDes) then --ativar hand destruction na main phase
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,35371948,UseLightStage,1) then --activate from hand
	GlobalCardMode = 1
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,35371948,UseLightStage,2) then --activate from field
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,35371948,UseLightStage,3) then --activate from field facedown
	GlobalCardMode = 1
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,85562745,UseDarkRoom,1) then --ativar dark room
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Sum,61283655,SummonCandina,1) then --ns candina
		return COMMAND_SUMMON,CurrentIndex
	end
	if HasIDNotNegated(Act,35199656,ActivateLyco,1) then --usar Lyco na main phase
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Sum,98700941,SummonLily,1) then --ns lily
		return COMMAND_SUMMON,CurrentIndex
	end
	if HasIDNotNegated(Sum,35199656,SummonLyco,1) then --ns lyco
		return COMMAND_SUMMON,CurrentIndex
	end
	if HasIDNotNegated(Act,21076084,UseReincarnationOrDisturbance) then --ativar reincarnation na main phase
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,77561728,UseReincarnationOrDisturbance) then --ativar disturbance na main phase
		return COMMAND_ACTIVATE,CurrentIndex
	end
end

TrickstarsActivateBlacklist={
61283655, --Candina
35199656, --Lycoris
98700941, --Lilybell
12580477, --Raigeki
14558127, --Ash Blossom
59438930, --Ghost Ogre
94145021, --Droll & Lock
73628505, --Terra
85562745, --Dark Room
--08267140, --Cosmic Cyclone
74519184, --Hand Destruction
09952083, --Chain Summoning
35371948, --Lightstage
21076084, --Reincarnation
36468556, --Ceasefire
77561728, --Disturbance Strategy
--40605147, --Solemn Strike
}
TrickstarsSummonBlacklist={
61283655, --Candina
35199656, --Lycoris
98700941, --Lilybell
14558127, --Ash Blossom
59438930, --Ghost Ogre
94145021, --Droll & Lock
}
TrickstarsUnchainable={
35199656, --Lycoris
94145021, --Droll
21076084, --Reincarnation
77561728, --Disturbance Strategy
36468556, --Ceasefire

09952083, --Chain Summoning
74519184, --Hand Destruction
}
TrickstarsSetBlacklist={
09952083, --Chain Summoning
}

function TrickstarsPosition(id,available)
	local battletargets = OppMon()
	local result
	if id==35199656 then --TRICKSTAR LYCO
		if Duel.GetTurnPlayer()==player_ai then --TURNO da AI
			if Duel.GetTurnCount()==1
			then 
			Debug.Message("Teste posicao lico 1") 
			result=POS_FACEUP_ATTACK
			elseif CanWinBattle(c,battletargets) then --pode vencer na batalha
			Debug.Message("Teste posicao lico 2") 
			result=POS_FACEUP_ATTACK
			elseif CardsMatchingFilter(OppMon())==0 then --oponente nao controla monstros
			Debug.Message("Teste posicao lico 3") 
			result=POS_FACEUP_ATTACK
			else
			Debug.Message("Teste posicao lico 4")
			result=POS_FACEUP_DEFENSE
			end
		else  --TURNO do oponente
			if Duel.GetCurrentPhase()>PHASE_BATTLE then --se já passou a Battle Phase
			Debug.Message("Teste posicao lico 5")
			result=POS_FACEUP_ATTACK
			else
			result=POS_FACEUP_DEFENSE
			end
		end
	elseif  id==98700941 then --TRICKSTAR LILYBELL
		if Duel.GetTurnPlayer()==player_ai then --TURNO da AI
			if Duel.GetCurrentPhase()<PHASE_MAIN2 and GlobalBPAllowed
			then
			Debug.Message("Teste posicao lily 1")
			result=POS_FACEUP_ATTACK
			else
			Debug.Message("Teste posicao lily 2")
			result=POS_FACEUP_DEFENSE
			end
		else 	--TURNO do oponente
			if Duel.GetCurrentPhase()<PHASE_MAIN2 then
			Debug.Message("Teste posicao lily 3")
			result=POS_FACEUP_DEFENSE
			else
			Debug.Message("Teste posicao lily 4")
			result=POS_FACEUP_ATTACK
			end
		end
	elseif  id==61283655 then --TRICKSTAR CANDINA
		if Duel.GetTurnPlayer()==player_ai then  --TURNO da AI
			if Duel.GetTurnCount()==1
			then 
			Debug.Message("Teste posicao Candina 1") 
			result=POS_FACEUP_ATTACK
			elseif CanWinBattle(c,battletargets) then --pode vencer na batalha
			Debug.Message("Teste posicao CANDINA 2") 
			result=POS_FACEUP_ATTACK
			elseif CardsMatchingFilter(OppMon())==0 then --oponente nao controla monstros
			Debug.Message("Teste posicao Candina 3") 
			result=POS_FACEUP_ATTACK
			end
		else		--TURNO do oponente
			if  Duel.GetCurrentPhase()>PHASE_BATTLE then
			Debug.Message("Teste posicao Candina 4") 
			result=POS_FACEUP_ATTACK
			elseif OppHasFaceupMonster(1800) then --verifica se oponente não tem um monstro com ataque maior ou igual que
			Debug.Message("Teste posicao Candina 5") 
			result=POS_FACEUP_ATTACK
			else
			Debug.Message("Teste posicao Candina 6") 
			result=POS_FACEUP_DEFENSE
			end
		end
	end
	return result
end

function TrickstarsBattleCommands(cards,activatable)
  for i=1,#cards do
    cards[i].index = i
  end
  local targets = OppMon()  --define quem são os alvos
  local attackable = {}		--inicializa esse vetor vazio
  local mustattack = {} 	--inicializa esse vetor vazio
	for i=1,#targets do
		if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then --checkar se pode ser atacado
		attackable[#attackable+1]=targets[i]
		end
		if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then --checkar se esse deve ser atacado
		mustattack[#mustattack+1]=targets[i]
		end
	end
	if #mustattack>0 then --se tem um monstro que devo atacar
	Debug.Message("Ha algo que deve ser atacado")
		targets = mustattack --atacar ele
	else
		targets = attackable --senao, atacar os outros
  end
  if CanWinBattle(cards[CurrentIndex],targets,true,false) then
  Debug.Message("Teste de batalha")
    return Attack(IndexByID(cards))
  end
  return nil
end

function TrickstarsChain(cards)
	if HasIDNotNegated(cards,35199656,LycoChain,1) then
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,21076084,ReincarnationRegular) then --general usage of Reincarnation
	GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,21076084,ReincarnationGraveChain) then --Using Reincarnation from the graveyard
	GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,77561728,DisturbanceChain) then
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,36468556,CeasefireChain) then
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,09952083,ChainSummonChain) then
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,74519184,HandDesChain) then
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,94145021,DrollRegularChain) then --droll regular
		GlobalCardMode = 1
		return {1,CurrentIndex}	
	end
	if HasIDNotNegated(cards,59438930,GhostOgreChain) then --ghost ogre
		GlobalCardMode = 1
		return {1,CurrentIndex}	
	end
	if HasIDNotNegated(cards,14558127,AshBlossomChain) then --ash ogre
		GlobalCardMode = 1
		return {1,CurrentIndex}	
	end
	if HasIDNotNegated(cards,21076084,ReincarnationInitializateDroll) then --reincarnation inicial do droll combo
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,21076084,ReincarnationCL1Droll) then --reincarnation da proxima etapa do combo
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,94145021,DrollForReincarnation) then --droll do loop
		GlobalCardMode = 1
		return {1,CurrentIndex}	
	end
	
end
TrickstarsChainlinks={
21076084, --Reincarnation
94145021, --Droll
}

function TrickstarsChainOrder(TrickstarsChainlinks)
end

function TrickstarsEffectYesNo(id,card)
  local result
	if id==61283655 then
		GlobalCardMode = 1
		return 1
	end
	if id==35371948 then
		GlobalCardMode = 1
		return 1
	end
	if id==98700941 then
	OPTSet(98700941)
		GlobalCardMode = 1
		--if Duel.GetCurrentPhase()<PHASE_MAIN2 and Duel.GetTurnPlayer()==player_ai then
		return 1
		--end
	end	
end
function LycoChain()
	if	Duel.GetTurnCount()==1 and Duel.GetCurrentPhase()==PHASE_END then
	Debug.Message("Teste Lyco turn 1")
	--teste se é o primeiro turno
		return true
	end
	if RemovalCheck(61283655) then
			Debug.Message("Teste Lyco: candina leaving the field")
	--teste se candina vai deixar o campo
	return true
	end
	if Duel.GetTurnPlayer()==player_ai and Duel.GetCurrentPhase()==PHASE_MAIN2 then
	--teste pra ver se AI já passou sua Battle fase (quando a candina pode atacar)
		Debug.Message("teste lyco chain: passed battle phase")
			if (HasID(AIMon(),61283655,true) and CardsMatchingFilter(AIHand(),FilterID,35199656)>2)
					--verifica se tem 1 candina no campo e  mais que 2 lycos na mao
					or
					(HasID(AIMon(),61283655,true) and CardsMatchingFilter(AIHand(),FilterID,35199656)>0 and HasID(AIST(),35371948,true))
					--verifica se tem 1 candina no campo e  mais que 1 lycos na mao e lighstage no campo
					then
					Debug.Message("candina no campo e  mais que 1 lycos na mao e lighstage no campo")
					return true
			end
	end
	if Duel.GetCurrentPhase()==PHASE_MAIN1 then
			local e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
		if e and e:GetHandler():GetCode()==09952083
		--se chain summoning foi ativado neste chain link, ativar, lyco
			then return true
		end
	end
	if Duel.GetTurnPlayer()==player_ai or Duel.GetTurnPlayer()==1-player_ai then 
		local e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
		if e and e:GetHandler():GetCode()==35199656
		--se Lyco foi ativado neste chain link, ativar, lyco
			then return true
		end
	end
return false
end
function UsableSetReincarnation(c)
	return c.id==21076084 and FilterLocation(c,LOCATION_SZONE) and not FilterStatus(c,STATUS_SET_TURN)
end
function ReincarnationRegular(c)
	if FilterLocation(c,LOCATION_GRAVE) then return false
	else
	return UnchainableCheck(21076084)
	and (Duel.GetCurrentPhase()==PHASE_STANDBY	and CardsMatchingFilter(AIMon(),FilterID,35199656)>0) --lycos no campo
	or RemovalCheck(21076084)
	--and not ReincarnationForDroll()
	end
end
function ReincarnationGraveChain(c)
	if FilterLocation(c,LOCATION_GRAVE) then
	Debug.Message("ReincarnationNo Grave: okay")
		if	UnchainableCheck(21076084) then
				if RemovalCheck(21076084) then
					Debug.Message("Reincar grave: removalcheck")
					return true
				elseif	Duel.GetTurnPlayer()==1-player_ai then --TURNO DO OPONENTE
						if Duel.GetCurrentPhase()==PHASE_BATTLE
						or Duel.GetCurrentPhase()==PHASE_END
						then
						Debug.Message("Reincar grave: fase de batalha")
						return true	end
				else--TURNO DA AI
						return NormalSummonCount(player_ai)>0 and Duel.GetCurrentPhase()<PHASE_MAIN2 and (HasID(AIHand(),35199656,true) or 
						(CardsMatchingFilter(AIGrave(),FilterID,61283655)>1 and HasID(AIGrave(),98700941,true)))
						--or CardsMatchingFilter(OppMon())==0 and Duel.GetCurrentPhase()==PHASE_BATTLE
				end
		end
	else return false --se não está no grave, não ativará
	end
end
function DrollRegularChain()
	if
	UnchainableCheck(94145021) and	Duel.GetTurnPlayer()==1-player_ai and (not HasID(AIST(),74519184,true))
	--só ativar o droll, se nao tiver no seu turno e nao tiver hand destruction setada
	and not DrollForReincarnation()
	then
	Debug.Message("Droll: regular, sem loop")
	return true
	end
	--	and HasID(AIHand(),35371948,true) --se Droll está na mao
end
function ReincarnationSameChain()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==21076084 then
	 return true
	end
  end
 return false
end
function ReincarnationInitializateDroll(c)
if FilterLocation(c,LOCATION_GRAVE) then return false
	else
local e
	if (Duel.GetCurrentPhase()==PHASE_STANDBY and Duel.GetTurnPlayer()==1-player_ai) and --verifica se é o turno do oponente
	HasID(AIHand(),94145021,true) and CardsMatchingFilter(AIST(),UsableSetReincarnation)>1
	and not ReincarnationSameChain()
	then return true
	end
end
end
function ReincarnationCL1Droll(c)
	if FilterLocation(c,LOCATION_GRAVE) then return false
	else
	if (Duel.GetCurrentPhase()~=PHASE_DRAW and Duel.GetTurnPlayer()==1-player_ai) and not ReincarnationSameChain()
	and Duel.CheckEvent(EVENT_TO_HAND)
	-- and HasID(AIHand(),94145021,true)
	 then return true
	 end
	end
end
function DrollForReincarnation()
	if ReincarnationSameChain() then
		Debug.Message("Droll do loop")
	return true
	else
		Debug.Message("Droll do loop fallhou")
		return false
end
end
--as quatro funções acima são para lidar com o Droll+Reincarnation loop
--no entanto, a ordem dos chain links ainda é aleatoria
--investigar apenas com as três cartas ou investigar com uma lyco no campo



function DisturbanceChain()
	return UnchainableCheck(77561728) and (CardsMatchingFilter(AIMon(),FilterID,35199656)>0
	or RemovalCheck(c) or RemovalCheck(35199656))
end
function CeasefireChain()
return
	UnchainableCheck(36468556)
	and (RemovalCheck(77561728) 		--se será destruido
	--(RemovalCheck(77561728)
		or RemovalCheck(85562745)	--se Dark Room Será destruido
		or CeasefireDamage()	--se a condição de burn é satisfeita
	)
end


function ChainSummonChain()
return
	UnchainableCheck(09952083)
	and(
	Duel.GetTurnPlayer()==player_ai
	and
	HasID(AIHand(),61283655,true) --verifica candinas
	or (HasID(AiMon(),61283655,true) and HasID(AiHand(),74519184,true)) --candina campo, lyco mao
	)
end
function HandDesChain()
return
	UnchainableCheck(74519184)
	and	((RemovalCheck(74519184) --se vai ser destruido
	or   (HasID(AIMon(),35199656,true) and  RemovalCheck(74519184))  --se vai ser destruido com a lyco no campo
	or 	AI.GetPlayerLP(2) <= CardsMatchingFilter(AIMon(),FilterID,35199656)*400 ) --dano da lyco é sufiente pra vencer
	or (AI.GetPlayerLP(2) <=  CardsMatchingFilter(AIMon(),FilterID,35199656)*400 +  --dano das lycos
	CardsMatchingFilter(AIST(),FilterID,85562745)*300*CardsMatchingFilter(AIMon(),FilterID,35199656) --danos da dark room em funcao da lyco
	)
	or CardsMatchingFilter(AIHand(),TrickstarFilter)==0
	)
end
function AshBlossomChain()
--Este tipo de função funciona verificando todos os elementos da chain atual
--usando um "for", se algum item for verdade, ele retorna true então para.
--Está sendo usado para detectar se o chain link atual é do oponente
--atraves de e:GetHandlerPlayer()==1-player_ai
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandlerPlayer()==1-player_ai and	UnchainableCheck(74519184) then
	--GetHandler():GetCode()==  pegar um carta specifica
	 return true
	end
  end
 return false
end
function GhostOgreChain()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandlerPlayer()==1-player_ai and	UnchainableCheck(59438930) then
	 return true
	end
  end
 return false
end
function SummonCandina()
return true
end
function SummonLyco()
	if	(HasID(AIHand(),61283655,true) --candina in hand
	or HasID(AIHand(),98700941,true)) --lily in hand
	then return false
	else return true
	end
end
function SummonLily()
	return HasID(AIHand(),61283655,false) --candina in hand
	and CardsMatchingFilter(AIGrave(),FilterID,35199656)>0 --lyco no grave
	or (CardsMatchingFilter(AIGrave(),FilterID,61283655)>0 --candina no grave + Chain summoning em ação
	and NormalSummonCount(player_ai)>0)
end


function UseLightStage(c,mode)
  if mode == 1 -- activate from hand
  and FilterLocation(c,LOCATION_HAND)
  and not HasIDNotNegated(AIST(),c.id,true)
  then
    return true
  end
  if mode == 2 -- activate on field
  and FilterLocation(c,LOCATION_ONFIELD) 
  and FilterPosition(c,POS_FACEUP)
  then
    return true
  end
  if mode == 3 -- activate face-down
  and FilterLocation(c,LOCATION_ONFIELD) 
  and FilterPosition(c,POS_FACEDOWN)
  then
    return true
  end
end
function UseHandDes()
local ncardsdraw=2
return	(CardsMatchingFilter(AIHand(),TrickstarFilterAll)==0
	or ncardsdraw*LycoDamage() + LightStageDamage() >= AI.GetPlayerLP(2))
end
function UseReincarnationOrDisturbance()
local ncardsdraw=CardsMatchingFilter(OppHand())
return (ncardsdraw*LycoDamage() + LightStageDamage() >= AI.GetPlayerLP(2))
end

function UseTerra()
	return true
end
function UseRaigeki()
	return true
end
function UseDarkRoom()
return true
end

function ActivateLyco(c,mode)
	if mode == 1 then
		return NormalSummonCount(player_ai)>0
		or Duel.GetTurnCount()==1
	end
end



function TrickstarsCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard)
  if id == 61283655 then --Candina
    return CandinaTarget(cards)
  end
   if id == 35371948 then --Lighstage
    return LightStageTarget(cards)
  end
   if id == 21076084 then --Reincarnation
    return  ReincarnationGraveTargets(cards) --doesnt seem to be working
  end
    if id == 98700941 then --Lily
    return LilyGraveTargets(cards)
  end
    if id == 35199656 then --Licorys
    return LycoTargets(cards)
  end
 return nil
end
function CandinaAddPriority(card) --Escolhe qual carta é melhor para Candina adicionar
	local id=card.id
		if id==35199656 then
		--Debug.Message("Teste 1 da Candina")
		return 7
		--geralmente adiciona lyco pra mao
		end
		if id==98700941 then
			if CardsMatchingFilter(AIGrave(),FilterID,35199656)>1 then
			--Debug.Message("Teste 2 da Candina")
			return 8
			--lilybell, se tem ao menos 2 lyco no grave
			else
			--Debug.Message("Teste 3 da Candina")
			return 5
			end--]]
		end
		if id==35371948 then
			if HasID(UseLists({AIST(),AIHand()}),35371948,true) then
			--Debug.Message("Teste 4 da Candina")
				return 6
				--se lighstage esta na mao ou no campo, prioridade menor que a lyco
			else
			--Debug.Message("Teste 5 da Candina")
				return 10
			--sem lighstage na mao, lightstage do deck tem maior prioridade que lyco
			end
		end
		if id==61283655 then
		--Debug.Message("Teste 6 da Candina")
		--candina adiconar candina
			return 1
		end
		if id==21076084 then
			if (CardsMatchingFilter(AICards(),FilterID,35199656)>1 and HasID(AICards(),35371948,true)) then
				--reincarnation, se tiver lycos na mao/campo e lighstage mao/campo
				--Debug.Message("Teste 7 da Candina")
				return 11
			else
			--Debug.Message("Teste 8 da Candina")
				return 4
			end
		end
		
return GetPriority(card,PRIO_TOHAND)
end
function CandinaAddAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_HAND then
    func = CandinaAddPriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end
function CandinaAdd(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  CandinaAddAssignPriority(cards,LOCATION_HAND)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end
function CandinaTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return CandinaAdd(cards,1)
  else
   return Add(cards,PRIO_TOHAND)
  end
end

function LightStageAddPriority(card) --Escolhe qual carta é melhor para Lighstage adicionar
	local id=card.id
		if id==61283655 then
			if not HasID(UseLists({AIMon(),AIHand()}),61283655,true) then
			--Debug.Message("Test1 do Lightstage")
			--Lighstage adiciona Candina
				return 10
			else
			--Debug.Message("Test2 do Lightstage")
				return 4
			end
		end
		if id==35199656 then
			if (CardsMatchingFilter(AIHand(),FilterID,35199656)>1 and  HasID(UseLists({AIMon(),AIHand()}),61283655,true)) then
			--Debug.Message("Test3 do Lightstage")
				--Se tiver mais que uma lyco na mao e uma candina, adiciona lyco
				return 11
			elseif  (not (CardsMatchingFilter(AIHand(),FilterID,35199656)>=0)) and HasID(UseLists({AIMon(),AIHand()}),61283655,true) then
			--Debug.Message("Test4 do Lightstage")
				--Se tiver uma Candina, mas nao tem lyco, adicionar lyco
				return 9
			else
			--Debug.Message("Test5 do Lightstage")
				return 7
			end
		end
		if id==98700941 then
			if CardsMatchingFilter(AIGrave(),FilterID,35199656)>0 then
			--Debug.Message("Test6 do Lightstage")
			--lilybell, se tem ao menos 1 lyco no grave
				return 10
			elseif CardsMatchingFilter(AIGrave(),TrickstarFilterM)>0 then
				--lilybell, se tem ao menos 1 trickstar no grave
				--Debug.Message("Test5 do Lightstage")
				return 6
			else
			--Debug.Message("Test8 do Lightstage")
				return 5
			end
		end
return GetPriority(card,PRIO_TOHAND)
end
function LightStageAddAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_HAND then
    func = LightStageAddPriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end
function LightStageAdd(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  LightStageAddAssignPriority(cards,LOCATION_HAND)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end
function LightStageTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return LightStageAdd(cards,1)
  else
   return Add(cards,PRIO_TOHAND)
  end
end
function ReincarnationGraveTargets(cards)
	return Add(cards,PRIO_TOFIELD)
end
function LycoTargets(cards)
	if LocCheck(cards,LOCATION_MZONE)  then
	return Add(cards,PRIO_TOHAND)
	end
	return Add(cards,PRIO_TOHAND)
end
function LilyGraveTargets(cards)
	if LocCheck(cards,LOCATION_GRAVE)  then
	return Add(cards,PRIO_TOHAND)
	end
	return Add(cards,PRIO_TOHAND)
end


function TrickstarFilterM(c)
  return IsSetCode(c.setcode,0xfb) and bit32.band(c.type,TYPE_MONSTER)>0
end
function TrickstarFilterAll(c)
  return IsSetCode(c.setcode,0xfb)
end
function CeasefireFilter(c)
	return  bit32.band(c.type,TYPE_MONSTER+TYPE_EFFECT)
end
function CeasefireDamage()
	return
	AI.GetPlayerLP(2) <= CardsMatchingFilter(AllMon(),CeasefireFilter)*500
		--verificar o dano via Ceasefire é maior que o LP do oponente
	or
	AI.GetPlayerLP(2) <= (CardsMatchingFilter(AIST(),FilterID,85562745)*300 + CardsMatchingFilter(Field(),CeasefireFilter)*500)
		--se Dark Room está no campo e se o dano causado com dark room + Ceasifere  é maior que o LP do oponente
end

function LycoDamage()
	--if HasIDNotNegated(AIST(),35199656,true) then ---why was i even using this (lyco in S/T zone: wtf?)
	return CardsMatchingFilter(AIMon(),FilterID,35199656)*200 --numero de lycos * 200
	--end
end
function LightStageDamage()
	if HasIDNotNegated(AIST(),35371948,true) then --lighstage no campo
	return	CardsMatchingFilter(AIMon(),FilterID,35199656)*200
	else return 0
	end
end

function LycoCond(loc,c)
	if loc == PRIO_TOHAND then
		if FilterLocation(c,LOCATION_GRAVE) then
			return HasID(AIMon(),61283655,true) or (HasID(AIMon(),98700941,true) and not OPTCheck(98700941))
		end
	end
	if	loc == PRIO_TOFIELD then
		if FilterLocation(c,LOCATION_GRAVE) then
			return CardsMatchingFilter(AIMon(),FilterID,35199656)>1
		end
	end
end
function CandinaCond(loc,c)
	if loc == PRIO_TOHAND then
		if FilterLocation(c,LOCATION_GRAVE) then
			return NormalSummonCount(player_ai)>0
		end
	end
	if loc == PRIO_TOFIELD then
			if FilterLocation(c,LOCATION_GRAVE) then
				return HasID(AIHand(),35199656,true)
				or OppHasFaceupMonster(1800)
				or AI.GetPlayerLP(2) <= 1800
		end
	end
end
function LilyCond(loc,c)
	if loc == PRIO_TOHAND then
		return not OPTCheck(98700941)
	end
	if loc == PRIO_TOFIELD then
		if FilterLocation(c,LOCATION_GRAVE) then
			return CardsMatchingFilter(AIGrave(),TrickstarFilterM)>1
		end 
	end
end
function LightStageCond(loc)
  if loc == PRIO_HAND then
	if FilterLocation(c,LOCATION_DECK) then
	return true
	end
end
end
TrickstarsPriorityList={
--[CardId]={hand,hand+,field,field+,grave,grave+,somewhereelse,somewhereelse,banished,banished+,XXXCondition}
[61283655] = {7,4,9,4,1,1,1,1,1,1,CandinaCond}, --Candina
[35199656] = {8,5,7,3,1,1,1,1,1,1,LycoCond}, --Lycoris
[98700941] = {9,3,8,2,1,1,1,1,1,1,LilyCond}, --Lilybell
[35371948] = {9,1,1,1,1,1,1,1,1,1,LightStageCond}, --Lightstage
[21076084] = {1,1,1,1,1,1,1,1,1,1,nil}, --Reincarnation

[14558127] = {1,1,1,1,6,6,1,1,1,1,nil}, --Ash Blossom
[59438930] = {1,1,1,1,6,6,1,1,1,1,nil}, --Ghost Ogre
[94145021] = {1,1,1,1,1,1,1,1,1,1,nil}, --Droll & Lock

[12580477] = {1,1,1,1,1,1,1,1,1,1,nil}, --Raigeki
[73628505] = {1,1,1,1,1,1,1,1,1,1,nil}, --Terraforming
[08267140] = {1,1,1,1,1,1,1,1,1,1,nil}, --Cosmic Cyclone
[74519184] = {1,1,1,1,1,1,1,1,1,1,nil}, --Hand Destruction
[85562745] = {1,1,1,1,1,1,1,1,1,1,nil}, --Dark Room of Nightmare
[09952083] = {1,1,1,1,1,1,1,1,1,1,nil}, --Chain Summoning

[36468556] = {1,1,1,1,1,1,1,1,1,1,nil}, --Ceasefire
[77561728] = {1,1,1,1,1,1,1,1,1,1,nil}, --Disturbance Strategy
[40605147] = {1,1,1,1,1,1,1,1,1,1,nil}, --Solemn Strike
--[CardId]={hand,hand+,field,field+,grave,grave+,banished,banished+,XXXCondition}
--cada local é um par ordenado
--As localizações com "+" são resultantes da função XXXCondition.
--XXXCondition é uma condição para retornar o primeiro elemento
--Se a condição for verdade, pega a primeira opção, digamos, para "hand".
--Se a condição for falso, pega o "hand+"
--se nenhuma condição é dada, retorna sempre o primeiro
}
