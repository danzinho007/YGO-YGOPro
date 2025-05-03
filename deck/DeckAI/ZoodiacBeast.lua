function ZoodiacBeastStartup(deck)
  print("ZoodiacBeast v2.0.2 by neftalimich.")
  deck.Init					= ZoodiacBeastInit
  deck.Card					= ZoodiacBeastCard
  deck.Chain				= ZoodiacBeastChain
  deck.EffectYesNo			= ZoodiacBeastEffectYesNo
  deck.YesNo				= ZoodiacBeastYesNo
  deck.Position				= ZoodiacBeastPosition
  deck.Option				= ZoodiacBeastOption
  deck.BattleCommand		= ZoodiacBeastBattleCommand
  deck.Material				= ZoodiacBeastMaterial
  --[[
  deck.Sum
  deck.Tribute
  deck.BattleCommand
  deck.AttackTarget
  deck.AttackBoost
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]

  deck.ActivateBlacklist    = ZoodiacBeastActivateBlacklist
  deck.SummonBlacklist      = ZoodiacBeastSummonBlacklist
  deck.SetBlacklist			= ZoodiacBeastSetBlacklist
  deck.Unchainable			= ZoodiacBeastUnchainable
  --[[
  deck.RepositionBlacklist
  ]]

  deck.PriorityList         = ZoodiacBeastPriorityList

  -- Debug Mode
  --[[
  local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	Duel.RegisterEffect(e2,0)
  local e3=Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_PUBLIC)
  e3:SetTargetRange(LOCATION_HAND,0)
  Duel.RegisterEffect(e3,player_ai)
  --]]
end

ZoodiacBeastIdentifier = {73881652} -- add the card(s) identifying your deck here

DECK_ZoodiacBeast = NewDeck("ZoodiacBeast",ZoodiacBeastIdentifier,ZoodiacBeastStartup)

------------------------
--------- LIST ---------
------------------------
ZoodiacBeastActivateBlacklist={
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
--98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
}
ZoodiacBeastSummonBlacklist={
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
}
ZoodiacBeastSetBlacklist={
46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
--98918572, -- ZBXiangke
98954106, -- ZBJAvarice
}
ZoodiacBeastUnchainable={
73881652, -- ZBDirection
--98918572, -- ZBXiangke
98954106, -- ZBJAvarice
}

------------------------
--------- COND ---------
------------------------
function ZBThroughbladeCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  if (
	    not NormalSummonCheck()
		or HasID(AIHand(),10719350,true) and OPTCheck(10719350) -- ZBTensu
	  )
	  and (
	    not HasID(AIHand(),c.id,true)
	    or PriorityCheck(AIHand(),PRIO_DISCARD,2,ZBFilter) > 2
	  )
	  and #AIMon() < 5
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	 return PriorityCheck(AIHand(),PRIO_DISCARD,1) > 2
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if GlobalZBEffectId == 41375811 then -- ZBLayca
	    return true
	  end
	  return PriorityCheck(AIHand(),PRIO_DISCARD,1) > 2
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 16
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  if not NormalSummonCheck() then
	    return 3
	  else
	    return 4
	  end
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBWhiptailCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if GlobalZBEffectId == 41375811 then -- ZBLayca
	    return 10
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 15
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 3
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBCluckleCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 20
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 5
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBRabbinaCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 19
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 5
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBRamCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 18
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 5
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBRatpierCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return
	    CardsMatchingFilter(AIDeck(),FilterID,c.id) == 3
	    and CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return CardsMatchingFilter(AIDeck(),FilterID,c.id) == 3
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return
	    CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
		and not HasID(AIMon(),c.id,true)
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if GlobalZBEffectId == 41375811 then -- ZBLayca
	    return false
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return 10
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 17
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 2
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBBearmanCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) then
	  local bwMon = SubGroup(AIMon(),FilterRace,RACE_BEASTWARRIOR)
	  if CardsMatchingFilter(bwMon,FilterLevel,4) == 2
	  and not BattlePhaseCheck()
	  --and Duel.GetCurrentPhase == PHASE_MAIN1
	  and (
	    not NormalSummonCheck()
	    or HasID(UseLists({AIHand(),AIST()}),10719350,true) -- ZBTensu
	  )
	  then
	    return 10
	  end
	end
  end
  return true
end

function ZBBarrageCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBTenkiCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return not HasID(UseLists({AIHand(),AIST()}),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBTensuCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  local zbMonHand = SubGroup(AIHand(),ZBMonFilter)
	  return
	    not HasID(UseLists({AIHand(),AIST()}),c.id,true)
		and CardsMatchingFilter(zbMonHand,FilterLevelMax,4) > 0
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBDridentCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if CardsMatchingFilter(AIExtra(),FilterID,c.id) == 0
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBBoarbowCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if CardsMatchingFilter(AIExtra(),FilterID,c.id) == 0
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBLaycaCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if CardsMatchingFilter(AIExtra(),FilterID,c.id) == 0
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBBroadbullCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if CardsMatchingFilter(AIExtra(),FilterID,c.id) == 0
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBTigermortarCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if CardsMatchingFilter(AIExtra(),FilterID,c.id) == 0
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

function ZBHammerkongCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if CardsMatchingFilter(AIExtra(),FilterID,c.id) == 0
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  return true
end

ZoodiacBeastPriorityList={
[77150143] = {8,1,8,1,4,1,3,1,1,1,ZBThroughbladeCond},	-- ZBThroughblade
[31755044] = {7,1,7,1,3,1,4,1,1,1,ZBWhiptailCond},		-- ZBWhiptail
[20155904] = {6,1,6,1,2,1,2,1,1,1,ZBCluckleCond},		-- ZBCluckle
[04367330] = {6,1,6,1,2,1,2,1,1,1,ZBRabbinaCond},		-- ZBRabbina
[04145852] = {6,1,6,1,2,1,2,1,1,1,ZBRamCond},			-- ZBRam
[78872731] = {9,1,9,1,5,1,5,1,1,1,ZBRatpierCond},		-- ZBRatpier
[67136033] = {1,1,1,1,1,1,3,1,1,1,ZBBearmanCond},		-- ZBBearman

[46060017] = {1,1,1,1,1,1,1,1,1,1,ZBBarrageCond},		-- ZBBarrage
[57103969] = {8,1,1,1,1,1,1,1,1,1,ZBTenkiCond},			-- ZBTenki
[10719350] = {9,1,1,1,1,1,1,1,1,1,ZBTensuCond},			-- ZBTensu
[73881652] = {1,1,1,1,1,1,1,1,1,1,nil},					-- ZBDirection
[98918572] = {1,1,1,1,1,1,1,1,1,1,nil},					-- ZBXiangke

[48905153] = {1,1,1,1,9,1,19,9,1,1,ZBDridentCond},		-- ZBDrident
[74393852] = {1,1,1,1,8,1,16,6,1,1,ZBBoarbowCond},		-- ZBBoarbow
[41375811] = {1,1,1,1,7,1,18,8,1,1,ZBLaycaCond},		-- ZBLayca
[85115440] = {1,1,1,1,6,1,15,5,1,1,ZBBroadbullCond},	-- ZBBroadbull
[11510448] = {1,1,1,1,5,1,17,7,1,1,ZBTigermortarCond},	-- ZBTigermortar
[14970113] = {1,1,1,1,4,1,14,4,1,1,ZBHammerkongCond},	-- ZBHammerkong

[00581014] = {1,1,1,1,1,1,1,1,1,1,nil},					-- ZBDaigusto
}
--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
function ZoodiacBeastInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards

  -- GLOBAL RESET
  GlobalZBSummonId = 0
  GlobalZBBarrage = 0
  GlobalZodiacSign = 0
  GlobalZBEffectId = 0

  -- REPOSITION
  if CardsMatchingFilter(Rep,FilterPosition,POS_FACEDOWN_DEFENSE) > 0
  then
    for i=1,#Rep do
	  local c = Rep[i]
	  if FilterPosition(c,POS_FACEDOWN_DEFENSE)
	  and ZBXyzFilter(c)
	  then
	    return {COMMAND_CHANGE_POS,i}
	  end
	end
  end

  -- ACTIVE 0
  if HasIDNotNegated(Act,43898403,UseZBTwinTwisters) then -- TwinTwisters
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,17626381) then -- Supply Squad
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,73628505) then -- Terraforming
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00675319) -- ZodiacSign
  and not HasID(AIST(),00675319,true)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00581014,UseZBDaigusto) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,04423206,UseZBInvoker) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,96381979,false,(96381979*16+1),UseZBTigerKing) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ZBMolmorat EFFECT
  if CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ) <= 3 then
    for i=1, #Act do
      local c = Act[i]
	  if NotNegated(c) and c.description == (78872731*16+1)
	  then
	    return {COMMAND_ACTIVATE,i}
	  end
    end
  end
  -- Tensu
  if HasIDNotNegated(Act,10719350) then -- Tensu
    OPTSet(10719350)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ACTIVE 1
  if HasIDNotNegated(Act,48905153,false,(48905153*16+1),UseZBDrident) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,41375811,false,(41375811*16+1),UseZBLayca) then
    local auxCurrentIndex = CurrentIndex
	if CardsMatchingFilter(AIMon(),FilterLevel,4) > 0 then
	  if HasIDNotNegated(Sum,77150143,SummonZBThroughblade) then
        return {COMMAND_SUMMON,CurrentIndex}
      end
      if HasIDNotNegated(Sum,20155904) then -- ZBCluckle
        return {COMMAND_SUMMON,CurrentIndex}
      end
      if HasIDNotNegated(Sum,04367330) then -- ZBRabbina
        return {COMMAND_SUMMON,CurrentIndex}
      end
      if HasIDNotNegated(Sum,04145852) then -- ZBRam
        return {COMMAND_SUMMON,CurrentIndex}
      end
	  if HasIDNotNegated(Sum,77150143) then -- ZBThroughblade
        return {COMMAND_SUMMON,CurrentIndex}
      end
      if HasIDNotNegated(Sum,31755044) then -- ZBWhiptail
        return {COMMAND_SUMMON,CurrentIndex}
      end
	end
    return {COMMAND_ACTIVATE,auxCurrentIndex}
  end
  if HasIDNotNegated(Act,85115440,false,(85115440*16+1),UseZBBullhorn) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,11510448,false,(11510448*16+1),UseZBTigermortar) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ACTIVE 2
  if HasIDNotNegated(Act,67136033) then -- ZBBearman
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,30741334) then -- ZBGiantrainer
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if MaxxCheck() then
    -- ZBTerrortop
    if HasIDNotNegated(SpSum,81275020,SummonZBTerrortop) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	if HasIDNotNegated(Sum,81275020,SummonZBTerrortop) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
	if HasIDNotNegated(SpSum,53932291,SummonZBTaketomborg) then -- STaketomborg
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBInvoker
    if HasIDNotNegated(SpSum,04423206) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end

	-- ZB SPECIAL SUMMON
	if HasIDNotNegated(Sum,78872731,SummonZBRatpier) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
	-- ZBTenki
    if HasIDNotNegated(Act,57103969) then -- Tenki
      OPTSet(57103969)
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
	-- ZBHammerkong
	if HasIDNotNegated(SpSum,14970113,SummonZBHammerkong) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBTigermortar
    if HasIDNotNegated(SpSum,11510448,SummonZBTigermortar) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBBullhorn
    if HasIDNotNegated(SpSum,85115440,SummonZBBroadbull) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	if HasIDNotNegated(SpSum,85115440,SummonZBBroadbull2) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBGiantrainer
    if HasIDNotNegated(Sum,67136033,SummonZBBearman) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    if HasIDNotNegated(SpSum,30741334,SummonZBGiantrainer) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    if HasIDNotNegated(Sum,77150143,SummonZBThroughblade) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
	-- ZBTigerKing
    if HasIDNotNegated(SpSum,96381979,SummonZBTigerKing) then
      return XYZSummon(nil,96381979)
    end
	if HasIDNotNegated(Act,31755044,UseZBWhiptail) then
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
	-- ZBDaigusto
	if HasIDNotNegated(SpSum,00581014,SummonZBDaigusto) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBTigermortar2
	if HasIDNotNegated(SpSum,11510448,SummonZBTigermortar2) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBLayca
    if HasIDNotNegated(SpSum,41375811,SummonZBLayca) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBBarrage
	if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_HAND,ActiveZBBarrage)
    then
	  local auxCurrentIndex = CurrentIndex
	  if HasIDNotNegated(Sum,04145852) -- ZBRam
	  and CardsMatchingFilter(AIGrave(),ZBMonFilterWithAttack,04145852) > 0
	  then
       return {COMMAND_SUMMON,CurrentIndex}
      end
	  if HasIDNotNegated(Sum,04367330) -- ZBRabbina
	  and CardsMatchingFilter(AIGrave(),ZBFilter,04367330) > 0
	  then
        return {COMMAND_SUMMON,CurrentIndex}
      end
	  if HasIDNotNegated(Sum,20155904) -- ZBCluckle
	  and CardsMatchingFilter(AIGrave(),ZBFilter,20155904) > 0
	  then
        return {COMMAND_SUMMON,CurrentIndex}
      end
      return {COMMAND_ACTIVATE,auxCurrentIndex}
    end
	if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_SZONE,UseZBBarrage)
    then
      GlobalZBBarrage = 1
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
	-- ZBBoarbow
    if HasIDNotNegated(SpSum,74393852,SummonZBBoarbow) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	 -- ZBDrident
    if HasIDNotNegated(SpSum,48905153,SummonZBDrident) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
  end
  -- ZBDaigusto
  if HasIDNotNegated(SpSum,00581014,SummonZBDaigusto) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  -- ZBTenki
  if HasIDNotNegated(Act,57103969) then -- Tenki
    OPTSet(57103969)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ZBBarrage
  if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_HAND,ActiveZBBarrage)
  and MaxxCheck()
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_SZONE,UseZBBarrage)
  and MaxxCheck()
  then
    GlobalZBBarrage = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- SUMMON 2
  if HasIDNotNegated(Sum,77150143,SummonZBThroughblade) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,20155904) then -- ZBCluckle
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,04367330) then -- ZBRabbina
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,04145852) then -- ZBRam
    return {COMMAND_SUMMON,CurrentIndex}
  end

  -- SUMMON 3
  if HasIDNotNegated(Sum,77150143) then -- ZBThroughblade
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,31755044) then -- ZBWhiptail
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,31755044,UseZBWhiptail2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end

  -- Utopia
  if MaxxCheck() then
    if HasIDNotNegated(SpSum,56832966) then
      return XYZSummon()
    end
    if HasIDNotNegated(SpSum,84013237) then
      return XYZSummon()
    end
  end

  if HasIDNotNegated(Act,00581014) then -- ZBDaigusto
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if TurnEndCheck() then
    if HasIDNotNegated(SetST,98918572) then
      return {COMMAND_SET_ST,CurrentIndex}
    end
	if HasIDNotNegated(SetST,73881652) then
      return {COMMAND_SET_ST,CurrentIndex}
    end
	if HasIDNotNegated(SetST,98954106) then
      return {COMMAND_SET_ST,CurrentIndex}
    end
	if HasIDNotNegated(SetST,40605147) then
      return {COMMAND_SET_ST,CurrentIndex}
    end
	if HasIDNotNegated(SetST,84749824) then
      return {COMMAND_SET_ST,CurrentIndex}
    end

	-- ZBRatpier EFFECT
    for i=1, #Act do
      local c = Act[i]
	  if NotNegated(c) and c.description == (78872731*16+1)
	  then
	    return {COMMAND_ACTIVATE,i}
	  end
    end
  end

  return nil
end
------------------------
-------- FILTER --------
------------------------
function ZBFilter(c, exceptId)
  if exceptId == nil then exceptId = 0 end
  return
    FilterSet(c,0xf1)
	and c.id ~= exceptId
end
function ZBMonFilter(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return
    FilterSet(c,0xf1)
	and FilterType(c,TYPE_MONSTER)
	and c.id ~= exceptId
end
function ZBXyzFilter(c)
  if c == nil then return false end
  return
    FilterSet(c,0xf1)
	and FilterType(c,TYPE_XYZ)
end
function ZBNonXyzFilter(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return
    IsSetCode(c.setcode,0xf1)
	and FilterType(c,TYPE_MONSTER)
	and not FilterType(c,TYPE_XYZ)
	and c.id ~= exceptId
end
function ZBMonFilterWithAttack(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return
    IsSetCode(c.setcode,0xf1)
	and FilterType(c,TYPE_MONSTER)
	and c.attack > 0
	and c.id ~= exceptId
end

function ZBBestDetachFilter(c)
  return
    not ZBFilter(c)
	or c.base_attack <= 0
end

function ZBBarrageFilter(c)
  return
    c.id == 57103969 -- ZBTenki
	and FilterLocation(c,LOCATION_SZONE)
	and FilterPosition(c,POS_FACEUP)
	or
	(
	  c.id == 04367330 -- ZBRabbina
	  or c.id == 20155904 -- ZBCluckle
	  or c.id == 04145852 -- ZBRam
	  or c.id == 81275020 -- STerrotop
	  or c.id == 53932291 -- STaketomborg
	)
	and FilterLocation(c,LOCATION_MZONE)
end

function ZBDridentDestroyFilter(c)
  return (
    Targetable(c,TYPE_MONSTER)
    and Affected(c,TYPE_MONSTER)
	and DestroyFilterIgnore(c)
  )
end

------------------------
--------- USE ----------
------------------------
function UseZBThroughblade(c)
  return true
end
function UseZBWhiptail(c)
  return
	FilterLocation(c,LOCATION_ONFIELD)
	and #AIMon() == 5
	and not NormalSummonCheck()
end
function UseZBWhiptail2(c)
  return
	FilterLocation(c,LOCATION_HAND)
	and BattlePhaseCheck()
end

function UseZBDrident(c)
  local xyzmat = c.xyz_materials
  local countMatDetach = CardsMatchingFilter(xyzmat,ZBBestDetachFilter)
  local oppMonFaceUp = SubGroup(OppField(),FilterPosition,POS_FACEUP)
  local prio = SubGroup(oppMonFaceUp,FilterPriorityTarget)
  if countMatDetach > 0
  and DestroyCheck(oppMonFaceUp,false,false,false,ZBDridentDestroyFilter) > 0
  and #prio > 0
  then
    return true
  end
  return false
end
function UseZBLayca(c)
  OPTSet(c.id)
  return true
end
function UseZBBroadbull(c)
  OPTSet(c.id)
  return true
end
function UseZBTigermortar(c)
  OPTSet(c.id)
  return true
end

function ActiveZBBarrage(c)
  if OPTCheck(c.id)
  and not HasIDNotNegated(AIST(),c.id,true)
  then
    return true
  end
  return false
end
function UseZBBarrage(c)
  if CardsMatchingFilter(AIField(),ZBBarrageFilter) > 0
  and OPTCheck(c.id)
  then
    OPTSet(c.id)
    return true
  elseif #AIMon() <= 4
  and OPTCheck(c.id)
  then
    OPTSet(c.id)
    return true
  end
  return false
end
function UseZBTwinTwisters(c)
  local targets = DestroyCheck(OppST())
  local facedown = DestroyCheck(OppST(),nil,nil,nil,FilterPosition,POS_FACEDOWN)
  local prio = HasPriorityTarget(OppST(),true)
  if facedown>0 then
    GlobalTwinTwisterTarget = function(c) return FilterPosition(c,POS_FACEDOWN) end
    return true
  end
  if prio and targets>1 then
    return true
  end
  if PriorityCheck(AIHand(),PRIO_TOGRAVE)>3
  and targets>1 then
    return true
  end
end

function UseZBDaigusto(c)
  if CardsMatchingFilter(AIGrave(),FilterID,48905153) > 0 -- ZBDrident
  then
    OPTSet(c.id)
    return true
  end
  return false
end
function UseZBInvoker(c)
  OPTSet(c.id)
  return true
end
function UseZBTigerKing(c)
  local oppMonFaceUp = SubGroup(OppMon(),FilterPosition,POS_FACEUP)
  if #oppMonFaceUp > CardsMatchingFilter(oppMonFaceUp,FilterRace,RACE_BEASTWARRIOR)
  then
    OPTSet(c.id)
    return true
  end
  return false
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
function ZoodiacBeastEffectYesNo(id,card)
  print("EffectYesNo",id)
  local result = nil
  if id == 81275020 then -- STerrotop
    result = 1
  end

  if id == 77150143 then -- ZBThroughblade
    result = 1
  end
  if id == 20155904 then -- ZBCluckle
    result = 1
  end
  if id == 04367330 then -- ZBRabbina
    result = 1
  end
  if id == 04145852 then -- ZBRam
    result = 1
  end
  if id == 78872731 then -- ZBRatpier
    result = 1
  end
  
  if id == 74393852 then -- ZBBoarbow
    result = 1
  end

  if id == 96381979 then -- ZBTigerKing
    result = 1
  end

  if id == 46060017 then -- ZBBarrage
    GlobalZBBarrage = 2
    result = 1
  end

  if result then
    if result == 1 then
      OPTSet(id)
	end
  end

  return result
end

function ZoodiacBeastYesNo(description_id)
  -- Example implementation: continue attacking, let the ai decide otherwise
  if (description_id/16) > 99999 then
    print("YesNo - id: "..(description_id/16).." - desc: "..description_id)
    if description_id/16 == 00675319 then -- ZodiacSign
	  if GlobalZBBarrage == 0 then
	    GlobalZodiacSign = 1
	    return 1
	  else
	    return 0
	  end
	end
  else
    print("YesNo - desc: "..description_id)
  end
end

function ZoodiacBeastOption(options)
  print("Options:")
  for i=1,#options do
    local op = options[i]
    print(op)
	if op == (48905153*16) -- ZBDrident
	or op == (74393852*16) -- ZBBoarbow
	or op == (41375811*16) -- ZBLayca
	or op == (85115440*16) -- ZBBroadbull
	or op == (11510448*16) -- ZBTigermortar
	or op == (14970113*16) -- ZBHammerkong
	then
	  OPTSet((op/16) + 1)
	  return i -- ZBXyzEffect
	end
    if op == (67136033*16) then -- ZBBearman
	  return i
	end
  end
  return nil
end

------------------------
-------- SUMMON --------
------------------------
function SummonZBThroughblade(c)
  if PriorityCheck(AIHand(),PRIO_DISCARD,1,ZBFilter) > 2
  then
    OPTSet(c.id)
	return true
  end
  return false
end
function SummonZBRatpier(c)
  if HasID(AIDeck(),c.id,true)
  and not HasID(AIMon(),c.id,true)
  and CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
  then
    return true
  end
  return false
end
function SummonZBTerrortop(c)
  if CardsMatchingFilter(AIExtra(),FilterRank,3) > 0 -- ZBInvoker
  and (
    HasID(UseLists({AIDeck(),AIHand()}),53932291,true) -- ZBTaketomborg
	or CardsMatchingFilter(AIMon(),FilterLevel,3) > 0
  )
  then
    return true
  end
  return false
end
function SummonZBTaketomborg(c)
  if CardsMatchingFilter(AIExtra(),FilterRank,3) > 0 -- ZBInvoker
  and CardsMatchingFilter(AIMon(),FilterLevel,3) > 0 
  then
    return true
  end
  return false
end

function SummonZBHammerkong(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
  and HasID(AIMon(),78872731,true) -- ZBRatpier
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBTigermortar(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and OPTCheck(c.id + 1)
  and not HasID(AIMon(),c.id,true)
  and HasID(AIGrave(),78872731,true) -- ZBRatpier
  and HasID(UseLists({AIHand(),AIDeck()}),78872731,true)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBTigermortar2(c)
  local zbMon = SubGroup(AIGrave(),ZBMonFilter)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and OPTCheck(c.id + 1)
  and CardsMatchingFilter(zbMon,FilterAttackMin,1) > 0
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBBroadbull(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBBroadbull2(c)
  if CardsMatchingFilter(AIMon(),FilterLevel,4) > 1
  and CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
  then
    GlobalZBSummonId = c.id
    return true
  elseif CardsMatchingFilter(AIMon(),ZBMonFilter) > 0
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  else
    return false
  end
end
function SummonZBLayca(c)
  local zbMon = SubGroup(AIGrave(),ZBMonFilter)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  and CardsMatchingFilter(zbMon,FilterAttackMin,1) > 0
  and OPTCheck(48905153 + 1) -- ZBDrident
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBBoarbow(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBBoarbow2(c)
  return false
end
function SummonZBDrident(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end

function SummonZBBearman(c)
  local bwMon = SubGroup(AIMon(),FilterRace,RACE_BEASTWARRIOR)
  return
    CardsMatchingFilter(bwMon,FilterLevel,4) == 2
    and not BattlePhaseCheck()
	and #AIMon() < 5
end

function SummonZBGiantrainer(c)
  return not BattlePhaseCheck()
end

function SummonZBTigerKing(c)
  return
    OPTCheck(57103969) -- ZBTenki
	and not HasID(UseLists({AIHand(),AIST()}),57103969,true)
	or
	OPTCheck(10719350) -- ZBTensu
	and not HasID(UseLists({AIHand(),AIST()}),10719350,true)
end
function SummonZBDaigusto(c)
  return
    CardsMatchingFilter(AIGrave(),FilterType,TYPE_MONSTER) >= 3
	and (
	  not BattlePhaseCheck()
	  or CardsMatchingFilter(AIMon(),FilterPosition,POS_FACEUP_DEFENSE) > 0
	  or TotalATK(AIMon(),2,FilterLevel,4) < 1800
	)
end

------------------------
-------- TARGET --------
------------------------
function ZBCluckleTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOHAND,max)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBRabbinaTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOHAND,max)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBRamTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    --CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"ZBRamTarget")
    return Add(cards,PRIO_TOFIELD,max,ZBNonXyzFilter)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBRatpierTarget(cards,min,max)
  if LocCheck(cards,LOCATION_DECK) then
    --print("ZBRatpier - DECK TO FIELD")
    return Add(cards,PRIO_TOGRAVE,max)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBRatpier - OVERLAY TO GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
end

function ZBMaterialTarget(cards,min,max)
  print("ZBMaterialTarget: "..GlobalZBSummonId)
  local result = Add(cards,PRIO_TOGRAVE,max,ZBXyzFilter)
  local xyzmat = cards[1].xyz_materials
  local ZBMon = SubGroup(xyzmat,ZBFilter)
  GlobalZBAttackSum = 0
  for i=1,#ZBMon do
    local c = ZBMon[i]
	--print(c.id.." - attack: "..c.base_attack)
	if c.base_attack > 0 then
      GlobalZBAttackSum = GlobalZBAttackSum + c.base_attack
	end
  end
  return result
end
function ZBAttachTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    --CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"ZBAttachTarget")
	if OPTCheck(00581014)
	and HasIDNotNegated(cards,00581014)
	then -- ZBDaigusto
	  return {CurrentIndex}
	end
    return Add(cards,PRIO_TOFIELD,max)
  end
end

-- ZBXyzTarget
function ZBHammerkongTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBHammerkong - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBTigermortarTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBTigermortarTarget - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    --print("ZBTigermortarTarget - GRAVE to OVERLAY")
    return ZBAttachTarget(cards,min,max)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    --print("ZBTigermortarTarget - MON")
    return FindID(11510448,cards,true) -- Own
  end
end
function ZBBroadbullTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBBroadbullTarget - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_DECK) then
    CountPrioTarget(cards,PRIO_TOHAND,1,nil,nil,nil,"ZBBroadbullTarget")
    return Add(cards,PRIO_TOHAND,max)
  end
end
function ZBLaycaTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBLayca - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    --print("ZBLayca - GRAVE to FIELD")
	GlobalZBEffectId = c.id
    return Add(cards,PRIO_TOFIELD,max)
  end
end
function ZBBoarbowTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBBoarbow - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBDridentTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return BestTargets(cards,max,TARGET_DESTROY,ZBDridentDestroyFilter,nil,nil,c)
end

GlobalZodiacSign = 0
function ZodiacSignTarget(cards,min,max,c)
  --print("ZodiacSignTarget")
  --CountPrioTarget(cards,PRIO_TOGRAVE,1,nil,nil,nil,"ZodiacSignTarget")
  return Add(cards,PRIO_TOGRAVE,max)
end
GlobalZBBarrage = 0
function ZBBarrageTarget(cards,min,max)
  if LocCheck(cards,LOCATION_DECK)
  then
    print("ZBBarrageTarget - DECK to FIELD")
    return Add(cards,PRIO_TOFIELD,max)
  end
  if GlobalZBBarrage == 1 then
    print("ZBBarrageTarget - DESTROY")
	if HasID(cards,57103969,true) -- Tenki
	then
      return FindID(57103969,cards,true)
	elseif HasID(cards,53932291,true) -- STaketomborg
	then
	  return FindID(53932291,cards,true)
	elseif HasID(cards,81275020,true) -- STerrotop
	then
	  return FindID(81275020,cards,true)
	elseif PriorityCheck(cards,PRIO_TOGRAVE) > 10 -- Negated
	then
	  return Add(cards,PRIO_TOGRAVE,1,ZBNonXyzFilter)
	elseif HasID(cards,78872731,true) -- ZBMolmorat
	then
	  return FindID(78872731,cards,true)
	elseif HasID(cards,20155904,true) -- ZBCluckle
	and CardsMatchingFilter(AIGrave(),ZBFilter,20155904) > 0
	then
	  return FindID(20155904,cards,true)
	elseif HasID(cards,04367330,true) -- ZBRabbina
	and CardsMatchingFilter(AIGrave(),ZBFilter,04367330) > 0
	then
	  return FindID(04367330,cards,true)
	elseif HasID(cards,04145852,true) -- ZBRam
	and CardsMatchingFilter(AIGrave(),ZBMonFilter,04145852) > 0
	then
	  return FindID(04145852,cards,true)
	elseif HasID(cards,46060017,true) -- ZBBarrage
	then
	  return FindID(46060017,cards,true)
	else
	  return Add(cards,PRIO_TOGRAVE,1,ZBNonXyzFilter)
	end
  end
  if GlobalZBBarrage == 2 then
    print("ZBBarrageTarget - to MON")
    return Add(cards,PRIO_TOGRAVE,max)
  end
end
function ZBDirectionTarget(cards,min,max,source)
  if FilterLocation(source,LOCATION_SZONE) then
    if LocCheck(cards,LOCATION_DECK) then
	  --print("ZBDirectionTarget - DECK")
	  return Add(cards,PRIO_TOGRAVE,max)
	end
	if LocCheck(cards,LOCATION_MZONE) then
	  --print("ZBDirectionTarget - MON")
	  local result = {}
	  for i=1, #cards do
	    local c = cards[i]
	    result[i] = c
		result[i].index = i
	  end
	  table.sort(result,function(a,b)return a.attack>b.attack end)
	  return {result[1].index}
	end
  end
  if FilterLocation(source,LOCATION_GRAVE) then
    --print("ZBDirectionTarget - GRAVE to DECK")
    return Add(cards,PRIO_TODECK,max)
  end
end
-- ZBOther
function ZBInvokerTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return Add(cards,PRIO_TOFIELD,max)
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]

GlobalZBSummonId = 0
function ZoodiacBeastCard(cards,min,max,id,c)
  if c then
    --print("Card - CardId: ".. c.id .." - cards: "..#cards.." - min: "..min.." - max: "..max)
  end
  if id == 77150143 then -- ZBThroughblade
    return Add(cards,PRIO_DISCARD,min)
  end
  if id == 31755044 then -- ZBWhiptail
    return Add(cards,PRIO_TOGRAVE,min)
  end
   if id == 20155904 then -- ZBCluckle
    return ZBCluckleTarget(cards,min,max)
  end
  if id == 04367330 then -- ZBRabbina
    return ZBRabbinaTarget(cards,min,max)
  end
  if id == 04145852 then -- ZBRam
    return ZBRamTarget(cards,min,max)
  end
  if id == 78872731 then -- ZBRatpier
    return ZBRatpierTarget(cards,min,max)
  end

  if id == 14970113 then -- ZBHammerkong
    return ZBHammerkongTarget(cards,min,max)
  end
  if id == 11510448 then -- ZBTigermortar
    return ZBTigermortarTarget(cards,min,max)
  end
  if id == 85115440 then -- ZBBroadbull
    return ZBBroadbullTarget(cards,min,max)
  end
  if id == 41375811 then -- ZBHammerkong
    return ZBLaycaTarget(cards,min,max,c)
  end
  if id == 74393852 then -- ZBBoarbow
    return ZBBoarbowTarget(cards,min,max)
  end
  if id == 48905153 then -- ZBDrident
    return ZBDridentTarget(cards,min,max,c)
  end

  if id == 04423206 then -- ZBInvoker
    return ZBInvokerTarget(cards,min,max)
  end
  if id == 96381979 then -- ZBTigerKing
    return Add(cards,PRIO_TOHAND,max)
  end
  if id == 00581014 then -- ZBDaigusto
    return Add(cards,PRIO_TODECK,max)
  end

  if id == 46060017 then -- ZBBarrage
    return ZBBarrageTarget(cards,min,max,c)
  end
  if id == 73881652 then -- ZBDirection
    return ZBDirectionTarget(cards,min,max,c)
  end

  if id == 57103969 then -- ZBTenki
    return Add(cards,PRIO_TOHAND,max)
  end

  if id == 98954106 then -- ZBJAvarice
    return Add(cards,PRIO_TODECK,max)
  end

  if not c
  and GlobalZBSummonId ~= 0 then
    local result = ZBMaterialTarget(cards,min,max)
	GlobalZBSummonId = 0
    return result
  end

  return nil
end

function ZoodiacBeastMaterial(cards,min,max,id)
  print("ZoodiacBeastMaterial")
  if id then
    return Add(cards,PRIO_TOGRAVE,max)
  end

  return nil
end
------------------------
-------- CHAIN ---------
------------------------
function ChainZBWhiptail(c,aiTurn)
  --print("ChainZBWhiptail")
  if NegateCheckCard(c)
  or ZBRemovalCheckCard(c)
  or CardsMatchingFilter(OppMon(),ArmadesCheck) > 0
  then
    return true
  end
  if IsBattlePhase() then
    local aimon,oppmon=GetBattlingMons()
	local cc = nil
	if aimon
	then
	  cc = GetCardFromScript(aimon)
	  --print(aimon:GetCode(),oppmon:GetCode())
	  if CardsEqual(c,aimon)
	  and aiTurn
	  then
	    return false
	  elseif ZBXyzFilter(cc) and aiTurn
	  then
	    return true
	  elseif WinsBattle(oppmon,aimon)
	  and (
	    CardsEqual(c,aimon)
	    or ZBXyzFilter(cc)
 	  )
	  then
	    return true
	  end
	end
  end
  return false
end
function ChainZBDrident(c,aiTurn)
  local oppFieldFaceUp = SubGroup(OppField(),FilterPosition,POS_FACEUP)
  if (RemovalCheckCard(c) or NegateCheckCard(c))
  and #oppFieldFaceUp > 0
  then
    OPTSet(c.id)
    return true
  end

  local targets = SubGroup(oppFieldFaceUp,ZBDridentDestroyFilter)
  local prio = SubGroup(targets,FilterPriorityTarget)
  if DestroyCheck(oppFieldFaceUp,false,false,false,ZBDridentDestroyFilter) > 0
  then
    local xyzmat = c.xyz_materials
	if xyzmat == nil then xyzmat = {} end

	if IsBattlePhase() then
	  local aimon,oppmon=GetBattlingMons()
      if WinsBattle(oppmon,aimon)
      and CardsEqual(c,aimon)
      then
        OPTSet(c.id)
        return true
      end
	end
	if #prio>0
	and aiTurn == false
	then
	  OPTSet(c.id)
      return true
	end
	if Duel.CheckTiming(TIMING_END_PHASE)
	and CardsMatchingFilter(xyzmat,ZBBestDetachFilter) > 0
    then
	  OPTSet(c.id)
      return true
    end
  end
  return false
end

function ChainZBDirection(c)
  if Duel.GetCurrentPhase() == PHASE_END
  or ZBRemovalCheckCard(c)
  then
    OPTSet(c.id)
    return true
  end
  if IsBattlePhase() then
    if CardsMatchingFilter(OppMon(),ArmadesCheck) > 0
	then
	  return true
	end
	local aimon,oppmon=GetBattlingMons()
	if aimon then
	  if ZBXyzFilter(GetCardFromScript(aimon))
	  and WinsBattle(oppmon,aimon)
	  then
	    OPTSet(c.id)
        return true
	  end
	end
  end
  return false
end

function ChainZBJAvarice(c,aiTurn)
  if (Duel.GetCurrentPhase() == PHASE_END or aiTurn)
  and CardsMatchingFilter(AIGrave(),ZBMonFilter) >= 5
  and Duel.GetCurrentChain() == 0
  or ZBRemovalCheckCard(c)
  then
    OPTSet(c.id)
    return true
  end
end

function ZBRemovalCheckCard(c)
  return
    RemovalCheckCard(c,CATEGORY_DESTROY)
    or RemovalCheckCard(c,CATEGORY_REMOVE)
	or RemovalCheckCard(c,CATEGORY_TOGRAVE)
	or RemovalCheckCard(c,CATEGORY_TOHAND)
	or RemovalCheckCard(c,CATEGORY_REMOVE)
end

GlobalRabbinaRam = 0
function ChainZBRabbinaRam(target)
  local result = false
  return result
end

GlobalDimensionalBarrier = nil
function ZBChainDimensionalBarrier(source,negateOwn)
  if negateOwn == nil then negateOwn = true end
  print("ZBChainDimensionalBarrier")
  if not UnchainableCheck(source.id)
  and not RemovalCheckCard(source)
  then
    return false
  end
  local c,link = ChainCardNegation(source,false,0,nil,nil,true)
  if c and Duel.GetOperationInfo(link,CATEGORY_SPECIAL_SUMMON)
  and CanSpecialSummon(2)
  then
    local e = Duel.GetChainInfo(link, CHAININFO_TRIGGERING_EFFECT)
    if FilterType(c,TYPE_SPELL+TYPE_TRAP)
    and FilterType(c,TYPE_RITUAL)
	and (
	  negateOwn
	  or CardsMatchingFilter(AIMon(),FilterType,TYPE_RITUAL) == 0
	)
    then
      GlobalDimensionalBarrier = TYPE_RITUAL -- Ritual summon
      SetNegated(link)
      return true
    end
    if FilterSet(c,0x95) -- Rank-Up Magic
	and (
	  negateOwn
	  or CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ) == 0
	)
    then
      GlobalDimensionalBarrier = TYPE_XYZ -- Rank-Up XYZ summon
      SetNegated(link)
      return true
    end
    if e:IsHasCategory(CATEGORY_FUSION_SUMMON)
	and (
	  negateOwn
	  or CardsMatchingFilter(AIMon(),FilterType,TYPE_FUSION) == 0
	)
    then
      GlobalDimensionalBarrier = TYPE_FUSION -- Fusion summon
      SetNegated(link)
      return true
    end
  end
  if Duel.GetCurrentChain()==0
  and CanSpecialSummon(2)
  and Duel.GetTurnPlayer()==1-player_ai
  or RemovalCheckCard(source)
  then
    local cards = SubGroup(OppMon(),FilterPosition,POS_FACEUP)
	local oppSynchro = SubGroup(OppExtra(),FilterType,TYPE_SYNCHRO)
	if CardsMatchingFilter(cards,FilterTuner)>0
    and CardsMatchingFilter(cards,FilterNonTuner)>0
	and #oppSynchro > 0
	and (
	  negateOwn
	  or CardsMatchingFilter(AIMon(),FilterType,TYPE_SYNCHRO) == 0
	)
    then
	  local tuners = SubGroup(cards,FilterTuner)
	  local nonTuners = SubGroup(cards,FilterNonTuner)
	  local posSynchro = {}
      for i=1,#tuners do
	    local tuner = tuners[i]
	    for j=1,#nonTuners do
		  local nonTuner = nonTuners[j]
		  posSynchro[#posSynchro+1] = (tuner.level + nonTuner.level)
		end
	  end
	  for s=1,#posSynchro do
	    local l = posSynchro[s]
		if CardsMatchingFilter(oppSynchro,FilterLevel,l) then
		  GlobalDimensionalBarrier = TYPE_SYNCHRO -- Synchro summon
          return true
		end
	  end
    end
	if (
	  negateOwn
	  or CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ) == 0
	)
	then
      cards=SubGroup(cards,FilterInvert,{FilterType,TYPE_TOKEN})
	  local oppXyz = SubGroup(OppExtra(),FilterType,TYPE_XYZ)
      for i,c in pairs(cards) do
        if CardsMatchingFilter(cards,FilterLevel,c.level) > 1
	    and CardsMatchingFilter(oppXyz,FilterRank,c.level) > 1
	    and c.level <= 5
        then
          GlobalDimensionalBarrier = TYPE_XYZ -- XYZ summon
          return true
        end
      end
	end
    if CanPendulumSummon(2)
    and CardsMatchingFilter(OppExtra(),FilterPosition,POS_FACEUP)+#OppHand()>1
	and (
	  negateOwn
	  or CardsMatchingFilter(AIMon(),FilterType,TYPE_PENDULUM) == 0
	)
    then
      GlobalDimensionalBarrier = TYPE_PENDULUM -- Pendulum summon
      return true
    end
  end
  local c,link = ChainCardNegation(source,false,4,nil,nil,true)
  if c and FilterType(c,TYPE_MONSTER)
  and Affected(c,TYPE_TRAP)
  then
    local types={TYPE_RITUAL,TYPE_FUSION,TYPE_SYNCHRO,TYPE_XYZ,TYPE_PENDULUM}
    for i,v in pairs(types) do
      if FilterType(c,v)
      and FilterLocation(c,LOCATION_ONFIELD)
      and NotNegated(c)
      then
        GlobalDimensionalBarrier = v
        SetNegated(link)
        return true
      end
    end
  end
  if RemovalCheckCard(source) then
    GlobalDimensionalBarrier = true
    return true
  end
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
function ZoodiacBeastChain(cards)
  if HasID(cards,4145852)
  and EffectCheck(player_ai) == nil
  then
    print("CHAIN RAM")
	GlobalZBSummonId = 1 -- For DettachTargets
    return {1,CurrentIndex}
  end
  if HasID(cards,4367330)
  and EffectCheck(player_ai) == nil
  then
    print("CHAIN RABBINA")
	GlobalZBSummonId = 1 -- For DettachTargets
    return {1,CurrentIndex}
  end
  if HasID(cards,20155904)
  and EffectCheck(player_ai) == nil
  then
    print("CHAIN CLUCKLE")
	GlobalZBSummonId = 1 -- For DettachTargets
    return {1,CurrentIndex}
  end

  if HasIDNotNegated(cards,83326048,ZBChainDimensionalBarrier,false) then
    return Activate()
  end
  if HasIDNotNegated(cards,40605147,ChainNegation,4) and AI.GetPlayerLP(1)>1500 then -- Solemn Notice
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,84749824,ChainNegation,4) and AI.GetPlayerLP(1)>2000 then -- Solemn Warning
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,73881652,false,nil,LOCATION_GRAVE)  -- ZBDirection
  and Duel.GetCurrentChain() == 0
  and CardsMatchingFilter(AIGrave(),ZBMonFilter) >= 7
  then
    return {1,CurrentIndex}
  end

  -- TURN CHAIN
  local aiTurn = Duel.GetTurnPlayer() ~= (1 - player_ai)

  if HasIDNotNegated(cards,31755044,ChainZBWhiptail,aiTurn)
  then
    return {1,CurrentIndex}
  end

  -- OppTurn
  if not aiTurn
  then
    if HasIDNotNegated(cards,73881652,false,nil,LOCATION_SZONE,ChainZBDirection) then
      return {1,CurrentIndex}
    end
    if HasIDNotNegated(cards,48905153,ChainZBDrident,false)
	then
      return {1,CurrentIndex}
    end
	if HasIDNotNegated(cards,98954106,ChainZBJAvarice,false) then
      return {1,CurrentIndex}
    end
  else
    if HasIDNotNegated(cards,48905153,ChainZBDrident,true)
	then
      return {1,CurrentIndex}
    end
	if HasIDNotNegated(cards,98954106,ChainZBJAvarice,true) then
      return {1,CurrentIndex}
    end
  end

  return nil
end
------------------------
-------- BATTLE --------
------------------------

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
ZoodiacBeastAtt={
48905153, -- ZBDrident
74393852, -- ZBBoarbow
--41375811, -- ZBLayca
--85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
--14970113, -- ZBHammerkong
31755044, -- ZBWhiptail
}
ZoodiacBeastDef={
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
}
function ZoodiacBeastPosition(id,available)
  result = nil
  for i=1,#ZoodiacBeastAtt do
    if ZoodiacBeastAtt[i]==id
    then
      result=1
    end
  end
  for i=1,#ZoodiacBeastDef do
    if ZoodiacBeastDef[i]==id
    then
      result=4
    end
  end
  if id == 41375811 -- ZBLayca
  or id == 85115440 -- ZBBroadbull
  or id == 14970113 -- ZBHammerkong
  then
    --print("GlobalZBAttackSum: "..GlobalZBAttackSum)
    if GlobalZBAttackSum >= 1200
	and #OppMon() == 0
	or
	GlobalZBAttackSum >= OppGetStrongestAttack()
	and #OppMon() > 0
    or HasID(UseLists({AIHand(),AIMon()}),31755044,true)
    then
      result = 1
    else
      result = 4
    end
  end
  return result
end

function ZoodiacBeastBattleCommand(cards, activatable)
  local targets = OppMon()
  local attackable = {}
  local mustattack = {}
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
  end
  if #mustattack>0 then
    targets = mustattack
  else
    targets = attackable
  end

  if HasIDNotNegated(cards,31755044) -- ZBWhiptail
  and (
    CanWinBattle(cards[CurrentIndex],targets)
	or #OppMon() == 0
  )
  then
    return Attack(CurrentIndex)
  end
  if HasIDNotNegated(cards,48905153) -- ZBDrident
  and CanWinBattle(cards[CurrentIndex],targets)
  then
    return Attack(CurrentIndex)
  end

  return nil
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBWhiptail
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBRatpier
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBBarrage
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrident
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigermortar
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
