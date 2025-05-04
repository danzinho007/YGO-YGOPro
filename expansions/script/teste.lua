local s,id=GetID()
function s.initial_effect(c)
    -- Chama cartaTerreno no início do duelo
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_STARTUP)
    e1:SetOperation(s.cartaTerreno)
    Duel.RegisterEffect(e1,0)

    -- Aumento de ATK ao atacar
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_ATTACK_ANNOUNCE)
    e2:SetOperation(s.atkup)
    c:RegisterEffect(e2)
    
    -- Verificar se pode ser usado como material
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_SUMMON_SUCCESS)
    e3:SetOperation(s.check_material)
    c:RegisterEffect(e3)
end

-- Função que ativa um terreno aleatório no início do duelo
function s.cartaTerreno(e,tp,eg,ep,ev,re,r,rp)
    local terrenos = {100000001, 100000002, 100000003, 100000004, 100000005}
    local terrenoID = terrenos[math.random(#terrenos)]
    local tc = Duel.CreateToken(tp, terrenoID)
    Duel.MoveToField(tc, tp, tp, LOCATION_FZONE, POS_FACEUP, true)
    tc:AddCounter(0x109, 6)
end

-- Aumenta o ATK em 5000 ao atacar
function s.atkup(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsFaceup() then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(5000)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e1)
    end
end

-- Verifica se pode ser usado como material após a invocação
function s.check_material(e,tp,eg,ep,ev,re,r,rp)
    local allowed_level = s.can_be_used_as_material(tp)
    if allowed_level then
        Duel.Hint(HINT_MESSAGE, tp, "Esta carta pode ser usada para invocar um monstro de nível " .. allowed_level .. "!")
    end
end

-- Função para verificar se pode ser usado como material
function s.can_be_used_as_material(tp)
    local tc = Duel.GetFieldCard(tp, LOCATION_MZONE, 2)
    if tc and tc:IsFaceup() and tc:IsPosition(POS_FACEUP_ATTACK) then
        local lvl = tc:GetLevel()
        local next_level = {[1]=4, [4]=6, [6]=8, [8]=10, [10]=12}
        return next_level[lvl] or nil
    end
    return nil
end


====================
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
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,2) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,2)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
    local p2,d2 = 1-tp,2
    if Duel.Draw(p2,d2,REASON_EFFECT) > 0 then
        local g = Duel.GetOperatedGroup()
        Duel.ConfirmCards(tp,g)
        Duel.SendtoHand(g,tp,REASON_EFFECT)
    end
end

=========================
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
--Verifica se pode comprar 4 cartas:
	if chk==0 then 
		return Duel.IsPlayerCanDraw(tp,2) and Duel.IsPlayerCanDraw(1-tp,2)
	end
--Quem vai comprar carta ?
--tp = jogador e 1-p oponente
	Duel.SetTargetPlayer(tp)
--Quantas cartas serão compradas ?
	Duel.SetTargetParam(2)
--Informações auxiliares sobre a compra:
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,2)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
--O oponente "compra" 2 cartas, mas elas irão para a mão do jogador
    local p2,d2 = 1-tp,2
    if Duel.Draw(p2,d2,REASON_EFFECT) > 0 then
--Obtem as cartas compradas pelo oponente
        local g = Duel.GetOperatedGroup()
--Revela as cartas ao jogador
        Duel.ConfirmCards(tp,g)
-- Move as cartas para a mão do jogador
        Duel.SendtoHand(g,tp,REASON_EFFECT) 
    end
end
--30 ate 43 = 13, sendo 4 comentarios
--entao 13 - 4 = 9
