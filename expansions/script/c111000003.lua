--Golden Jar of Greed
--Armadilha Normal
--Compre 2 cartas, sendo 1 do oponente
local s,id=GetID()
function s.initial_effect(c)
	--Ativação
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
		return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) 
	end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d= Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
    local p2,d2 = 1-tp,1
    if Duel.Draw(p2,d2,REASON_EFFECT) > 0 then
        local g = Duel.GetOperatedGroup()
        Duel.ConfirmCards(tp,g)
        Duel.SendtoHand(g,tp,REASON_EFFECT)
    end
end

