--Golden Pot of Greed
--Magia Normal
--Compra 4 cartas, sendo 2 do inimigo
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		return Duel.IsPlayerCanDraw(tp,2) and Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0) >= 2
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end

function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d = Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT) -- Jogador compra 2 cartas

	local g = Duel.GetDecktopGroup(1-tp,2) -- Pega 2 do deck do oponente
	if #g > 0 then
		Duel.ConfirmCards(tp,g) -- Revela
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(g,tp,REASON_EFFECT) -- Envia pra mão do jogador
	end
end
