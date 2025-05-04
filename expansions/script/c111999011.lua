local s,id=GetID()
function s.initial_effect(c)
	-- Ativar normalmente (caso venha na mão)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

	-- Boost de ATK/DEF na zona central (posição 2)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.vanguard_target)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)

	-- Comprar 1 se a Vanguarda destruir em batalha
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(s.drawcon)
	e4:SetTarget(s.drawtg)
	e4:SetOperation(s.drawop)
	c:RegisterEffect(e4)

	-- Permitir apenas 1 Vanguarda (zona central)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_SUMMON)
	e5:SetRange(LOCATION_FZONE)
	e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e5:SetTarget(s.vanguard_limit)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e6)

	-- Bloquear zonas laterais de monstro e magia (ambos os lados)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_DISABLE_FIELD)
	e7:SetRange(LOCATION_FZONE)
	e7:SetOperation(s.disable_zones)
	c:RegisterEffect(e7)

	-- Ativação automática no início do duelo
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_PREDRAW)
	e8:SetCountLimit(1,id+100)
	e8:SetRange(LOCATION_DECK)
	e8:SetCondition(s.startup_condition)
	e8:SetOperation(s.startup_operation)
	c:RegisterEffect(e8)
end

-- Apenas zona central (posição 2) recebe boost
function s.vanguard_target(e,c)
	return c:GetSequence()==2 and c:IsControler(e:GetHandlerPlayer())
end

-- Comprar se Vanguarda destruir em batalha
function s.drawcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:GetSequence()==2 and tc:IsRelateToBattle()
end
function s.drawtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.drawop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end

-- Limita a invocação se já houver carta na zona central
function s.vanguard_limit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_MZONE) and c:GetSequence()~=2 and Duel.GetFieldCard(c:GetControler(),LOCATION_MZONE,2)
end

-- Desativa zonas laterais (monstros e magias) dos dois lados
--function s.disable_zones(e,tp)
	-- Zonas laterais: 0, 1, 3, 4
	--local zone = 0x00000011 + 0x11000000 -- 0x11 (0 e 4) | 0x11000000 (24 e 28)
	--local spell_zone = 0x000011 -- zonas 5 e 7 (MZone) + 0x110000 (37 e 39)
	--return zone + spell_zone
--end

-- Desativa zonas laterais (monstros e magias) dos dois lados
function s.disable_zones(e,tp)
	local zone = 0
	-- Monstro: zonas 0 e 4 (Player 1), 24 e 28 (Player 2)
	zone = zone | (1<<0) | (1<<4) | (1<<24) | (1<<28)
	-- Spell/Trap: zonas 5 e 7 (Player 1), 37 e 39 (Player 2)
	zone = zone | (1<<5) | (1<<7) | (1<<37) | (1<<39)
	return zone
end


-- Ativa do deck no turno 1
function s.startup_condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==1 and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0
end
function s.startup_operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetFieldCard(tp,LOCATION_FZONE,0)==nil then
		Duel.MoveToField(c,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	end
end


