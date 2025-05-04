--Accord of the Pot = Magia Normal
--Compre 2 cartas, essa carta vai pro topo do deck adversário e depois vai ao cemitério do dono original
local s,id=GetID()
function s.initial_effect(c)
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
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end

function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local owner=c:GetOwner() -- dono original da carta
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)

	-- Impede que vá direto pro cemitério após ativação
	c:CancelToGrave()

	-- Compra 2 cartas
	Duel.Draw(p,d,REASON_EFFECT)

	-- Se o jogador atual for o dono, manda pro topo do deck do oponente
	if tp == owner then
		if c:IsAbleToDeck() then
			Duel.SendtoDeck(c,1-tp,SEQ_DECKTOP,REASON_EFFECT)
		end
	else
		-- Se quem ativou for o oponente (ou seja, quem comprou a carta), manda para o cemitério do dono original
		if c:IsAbleToGrave() then
			Duel.SendtoGrave(c,REASON_EFFECT,owner)
		end
	end
end
