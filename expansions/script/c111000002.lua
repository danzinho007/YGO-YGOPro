--スケルエンジェル
--Vira: Compre 2 cartas, sendo 1 do oponente
local s,id=GetID()
function s.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_REMOVE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.IsPlayerCanDraw(tp,1)
			and Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>0
	end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
end

function s.operation(e,tp,eg,ep,ev,re,r,rp)
	-- Você compra 1 carta
	Duel.Draw(tp,1,REASON_EFFECT)

	-- Pega o topo do deck do oponente
	local g=Duel.GetDecktopGroup(1-tp,1)
	if #g>0 then
		local tc=g:GetFirst()
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 and tc:IsAbleToHand() then
			-- Envia para sua mão (do lado do jogador que ativou o efeito)
			Duel.SendtoHand(tc,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
