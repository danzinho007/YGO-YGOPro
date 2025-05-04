--Golden Gift of Greed
--Armadilha Normal
--Compre 2 cartas, sendo 2 do oponente
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	-- Apenas verifica se o oponente tem pelo menos 2 cartas no deck
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0) >= 2 end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,2)
end

function s.activate(e,tp,eg,ep,ev,re,r,rp)
	-- Compra 2 cartas do deck do oponente e envia para a mão do jogador
	local g=Duel.GetDecktopGroup(1-tp,2)
	if #g>0 then
		Duel.ConfirmCards(tp,g) -- revela as cartas para você
		Duel.DisableShuffleCheck() -- não embaralha
		Duel.SendtoHand(g,tp,REASON_EFFECT) -- envia pra mão
	end
end
