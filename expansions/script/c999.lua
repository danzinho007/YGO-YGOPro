--Knight of Conviction, Bors
local s, id=GetID()
function s1.initial_effect(c)
	local el=Effect.CreateEffect(c)
	el: SetCategory(CATEGORY_DRAW)
	el:SetType(EVENT_TYPE_ACTIVATE)
	el:SetCode(EVENT_FREE_CHAIN)
	el:SetCountLimit(1,id,EFFEC_COUNT_CODE_OATH)
	el:SetCondition(s.condition)
	el:
end


--銀河の施し
--Galactic Charity
-- If you control a "Galaxy" Xyz Monster: 
-- Discard 1 card; draw 2 cards, also if you activated this card, any 
-- damage your opponent takes for the rest of this turn is halved. 
-- You can only activate 1 "Galactic Charity" per turn.

-- Definindo 2 variáveis locais : s e id 
-- Que recebem valores do retorno da função GetID
-- s é um objeto de cartão
-- id é a senha do cartão
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
-- Categoria Draw pois puxa 2 cartas
	e1:SetCategory(CATEGORY_DRAW)
-- Efeito que precisa ser ativada
	e1:SetType(EFFECT_TYPE_ACTIVATE)
-- Evento livro, pois a carta pode ser ativada a qualquer hora
	e1:SetCode(EVENT_FREE_CHAIN)
-- Quantidade de vezes que o efeito pode ser usado :
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
-- Condição pra ativar a carta:
	e1:SetCondition(s.condition)
-- Condição pra verificar o custo:
	e1:SetCost(s.cost)
-- Verifica a legalidade da ativação
	e1:SetTarget(s.target)
-- Funlão que opera todos passos quando a carta é resolvida
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
s.listed_series={0x7b}

-- 2- Função que verifica se tem :
-- 1 carta virada pra cima
-- 1 carta do Arquétipo Galaxy
-- 1 carta do Tipo XYZ
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x7b) and c:IsType(TYPE_XYZ)
end

-- 1- Função que verifica se tem pelo menos 1 carta correspondente a função s.cfilter
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end

-- 3- Função que verifica o custo que deve ser pago pra ativação
-- O custo é ter pelo menos 1 carta na mão do jogador que pode ser descartada
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end

-- 4- Função que verifica se o jogador pode comprar 2 cartas
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end

-- 5- Função que finalmente ativa a carta
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
		e1:SetDescription(aux.Stringid(id,1))
		e1:SetTargetRange(0,1)
		e1:SetValue(s.val)
		e1:SetReset(RESET_PHASE+PHASE_END,1)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.val(e,re,val,r,rp,rc)
	return math.floor(val/2)
end
