function DinomistStartup(deck)
  print("Dinomist v0.1.0.0 by neftalimich.")
  deck.Init					= DinomistInit
  deck.Card					= DinomistCard
  deck.Chain				= DinomistChain
  deck.EffectYesNo			= DinomistEffectYesNo
  deck.YesNo				= DinomistYesNo
  deck.Position				= DinomistPosition
  deck.Option				= DinomistOption
  deck.BattleCommand		= DinomistBattleCommand
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

  deck.ActivateBlacklist    = DinomistActivateBlacklist
  deck.SummonBlacklist      = DinomistSummonBlacklist
  deck.SetBlacklist			= DinomistSetBlacklist
  deck.Unchainable			= DinomistUnchainable
  deck.RepositionBlacklist	= DinomistRepositionBlacklist

  deck.PriorityList         = DinomistPriorityList

  -- Debug Mode
  --[[]]
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

DinomistIdentifier = {41128647} -- add the card(s) identifying your deck here

DECK_Dinomist = NewDeck("Dinomist",DinomistIdentifier,DinomistStartup)

------------------------
--------- LIST ---------
------------------------

DinomistActivateBlacklist={
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos
50485594, -- DRHamster

77116346, -- DCharge
41128647, -- DPowerload
23171610, -- DLRemoval

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation

22638495, -- DPower
}
DinomistSummonBlacklist={
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos
50485594, -- DRHamster

22638495, -- DPower
}
DinomistSetBlacklist={
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos
50485594, -- DRHamster

77116346, -- DCharge
41128647, -- DPowerload
--23171610, -- LRemoval

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation
}
DinomistUnchainable={
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos

77116346, -- DCharge
41128647, -- DPowerload

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation

22638495, -- DPower
}
DinomistRepositionBlacklist={
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos

22638495, -- DPower
}

------------------------
--------- COND ---------
------------------------
function DSpinosCond(loc,c)
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
function DRexCond(loc,c)
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
function DCeratopsCond(loc,c)
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
function DBrachionCond(loc,c)
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
function DPteranCond(loc,c)
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
function DPlesiosCond(loc,c)
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
function DStegosaurCond(loc,c)
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
function DAnkylosCond(loc,c)
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

function DChargeCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return
	    OPTCheck(c.id+1)
		and OPTCheck(c.id)
		and not HasID(AIHand(),c.id,true)
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
function DPowerloadCond(loc,c)
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

function DRushCond(loc,c)
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
function DHowling(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  return not HasID(UseLists({AIHand(),AIST()}),c.id,true)
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

function DPowerCond(loc,c)
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

DinomistPriorityList={
[05067884] = {5,1,6,1,6,1,5,1,1,1,DSpinosCond},		-- DSpinos
[63251695] = {7,1,8,1,3,1,3,1,1,1,DRexCond},		-- DRex
[37752990] = {4,1,5,1,7,1,7,1,1,1,DCeratopsCond},	-- DCeratops
[00368382] = {3,1,4,1,8,1,8,1,1,1,DBrachionCond},	-- DBrachion
[64973287] = {8,1,7,1,5,1,4,1,1,1,DPteranCond},		-- DPteran
[38988538] = {9,1,9,1,1,1,1,1,1,1,DPlesiosCond},	-- DPlesios
[01580833] = {2,1,3,1,9,1,9,1,1,1,DStegosaurCond},	-- DStegosaur
[32134638] = {6,1,6,1,6,1,2,1,1,1,DAnkylosCond},	-- DAnkylos
[50485594] = {1,1,1,1,1,1,1,1,1,1,nil},				-- DRHamster

[77116346] = {11,1,1,1,1,1,1,1,1,1,DChargeCond},		-- DCharge
[41128647] = {1,1,1,1,1,1,1,1,1,1,DPowerloadCond},	-- DPowerload

[41554273] = {1,1,1,1,1,1,1,1,1,1,DRushCond},		-- DRush
[60675348] = {10,1,1,1,1,1,1,1,1,1,DHowling},		-- DHowling (BETA)

[22638495] = {1,1,1,1,1,1,1,1,1,1,DPowerCond},		-- DPower
}
--[[LIST
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos

77116346, -- DCharge
41128647, -- DPowerload

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation

22638495, -- DPower
]]
function DinomistInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards

  -- GLOBAL RESET
  GlobalPendulumSummoning = nil

  -- GLOBAL INIT
  local dinomistMonHand = CardsMatchingFilter(AIHand(),DinomistMonFilter)
  local scalecheck = ScaleCheck()

  -- MAIN
  print("__1.1")
  if HasID(Act,43898403,UseTwinTwister) then
    return Activate()
  end
  if HasIDNotNegated(Act,94937430) then -- DEBuck
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,41128647) -- DPowerload
  and CardsMatchingFilter(AIST(),FilterType,TYPE_FIELD) == 0
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,73628505) then -- Terraforming
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,22123627) then -- MGreed
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,77116346,ActiveDCharge) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,60675348,ActiveDHowling) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,15582767,UseDEOscilation) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,22638495) -- DPower
  and scalecheck == true
  and (
    GlobalPendulum ~= Duel.GetTurnCount()
	or not BattlePhaseCheck()
  )
  then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,60675348,UseDHowling)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("__1.2")
  if HasIDNotNegated(Act,50485594,false,nil,LOCATION_MZONE) then -- DRHamster
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Sum,50485594,SummonDRHamster) then
    return {COMMAND_SUMMON,CurrentIndex}
  end

  print("__1.2")
  -- PENDULUM CHECK
  if dinomistMonHand > 0
  and (
    not (
      not BattlePhaseCheck()
	  and HasID(UseLists({AIHand(),AIST()}),60675348,true) -- DHowling
    )
	or (
	  HasID(UseLists({AIHand(),AIST()}),15582767,true) -- DEOscilation
	  and OPTCheck(15582767)
	  and #AIPendulum() == 0
	)
  )
  then
    local monToPendulumSummon = CardsMatchingFilter(AIExtra(),FilterPosition,POS_FACEUP)
    if scalecheck == false
    then
	  monToPendulumSummon = monToPendulumSummon + math.max(dinomistMonHand - 2,0)
    end
    if scalecheck ~= true and scalecheck ~= false
    then
	  monToPendulumSummon = monToPendulumSummon + math.max(dinomistMonHand - 1,0)
    end

    --print("monToPendulumSummon",monToPendulumSummon)

    if scalecheck ~= true
    and (
      monToPendulumSummon > 1
	  or (
	    dinomistMonHand > 1
	    and not HasID(UseLists({AIHand(),AIST()}),60675348,true) -- DHowling
	  )
    )
    then
	  if scalecheck == false
	  then
	    local actDinomist = Add(Act,PRIO_TOGRAVE,1,DinomistMonFilter)
	    return {COMMAND_ACTIVATE,actDinomist[1]}
	  end
	  if scalecheck == 6
	  and CardsMatchingFilter(Act,DinomistLScaleFilter,3) > 0
	  then
	    local actDinomist = Add(Act,PRIO_TOGRAVE,1,DinomistLScaleFilter,3)
	    return {COMMAND_ACTIVATE,actDinomist[1]}
	  end
	  if scalecheck == 3
	  and CardsMatchingFilter(Act,DinomistLScaleFilter,6) > 0
	  then
	    local actDinomist = Add(Act,PRIO_TOGRAVE,1,DinomistLScaleFilter,6)
	    return {COMMAND_ACTIVATE,actDinomist[1]}
	  end
    end
  end

  -- SPECIAL SUMMON
  print("__1.3")
  if HasIDNotNegated(SpSum,00368382,false,nil,LOCATION_HAND) then -- DBrachion
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,37752990,false,nil,LOCATION_HAND) then -- DCeratops
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end

  -- NORMAL SUMMON
  print("__1.4")
  local sumDinomist = CardsMatchingFilter(Sum,DinomistMonFilter)
  if sumDinomist > 0
  and (
    not HasID(UseLists({AIHand(),AIMon(),AIExtra()}),63251695,true) -- DRex
    or scalecheck ~= true
	or Duel.GetCurrentPhase() == PHASE_MAIN2
  )
  then -- DRex
	local sumDinomist = Add(Sum,PRIO_TOFIELD,1)
	if #Sum > 0
	and CardsMatchingFilter(Sum,FilterLevelMax,4) > 0
	then
	  print("summon",sumDinomist[1])
	  return {COMMAND_SUMMON,sumDinomist[1]}
	end
  end
  
  if HasIDNotNegated(Act,05067884,UseDSpinos) 
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end

  -- PENDULUM SUMMON
  print("__1.5")
  if scalecheck == true then
    local pSummoneable = CardsMatchingFilter(UseLists({AIHand(),AIExtra()}),DPendulumSummonableFilter)
    print("pSummoneable",pSummoneable)
    if pSummoneable > 0
    then
      for i=1,#SpSum do
        if PendulumCheck(SpSum[i]) 
	    then
          GlobalPendulumSummoning = true
          GlobalPendulum = Duel.GetTurnCount()
	      print("PendulumCheck")
          return {COMMAND_SPECIAL_SUMMON,i}
        end
      end
    end
  end
  print("__1.6")
  if HasIDNotNegated(Act,15582767) then
    OPTSet(15582767)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end

  -- TURN END CHECK
  print("__1.7")
  if TurnEndCheck() then
    if HasIDNotNegated(SetST,94937430) then -- DEBuck
      return {COMMAND_SET_ST ,CurrentIndex}
    end
	if HasIDNotNegated(SetST,41554273,SetDRush) then
      return {COMMAND_SET_ST ,CurrentIndex}
    end
	if HasIDNotNegated(SetST,60675348) then -- DHowling
      return {COMMAND_SET_ST ,CurrentIndex}
    end
	if HasIDNotNegated(SetST,15582767,SetGenericST) then -- EOscilation
      return {COMMAND_SET_ST ,CurrentIndex}
    end
  end

  return nil
end
------------------------
-------- FILTER --------
------------------------
function DinomistFilter(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return
    FilterSet(c,0xd8)
	and c.id ~= exceptId
end
function DinomistMonFilter(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return
    FilterSet(c,0xd8)
	and FilterType(c,TYPE_MONSTER)
	and c.id ~= exceptId
end
function DinomistLScaleFilter(c,scale,exceptId)
  if exceptId == nil then exceptId = 0 end
  return
    FilterSet(c,0xd8)
	and FilterType(c,TYPE_MONSTER)
	and c.id ~= exceptId
	and c.lscale == scale
end

function FilterLScale(c,scale)
  return
    FilterType(c,TYPE_PENDULUM)
	and c.lscale == scale
end
function AvailableAttacksFilter(c,attacks)
  return AvailableAttacks(c) == attacks
end
function AvailableAttacksMinFilter(c,attacks)
  return AvailableAttacks(c) >= attacks
end
function AvailableAttacksMaxFilter(c,attacks)
  return AvailableAttacks(c) <= attacks
end

function DHowlingFilter(c)
  return
    Targetable(c,TYPE_TRAP)
    and Affected(c,TYPE_TRAP)
	and not ToHandBlacklist(c.id)
end
function DHowlingFilter2(c)
  return
    DHowlingFilter(c)
	and (
	  c.level > 4
	  or FilterType(c,TYPE_FUSION+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_XYZ)
	)
	and not FilterType(c,TYPE_PENDULUM)
	and not FilterLocation(c,LOCATION_SZONE)
end

function DIgnoreSaveFilter(c)
  return
    c.id == 41554273
	or c.id == 01580833
end

function DPendulumSummonableFilter(c,scalecheck)
  --print("DPendulumSummonableFilter",ScaleCheck())
  if ScaleCheck()~=true then
    return false
  end
  local l,r = GetScales(p)
  --print("GetScales",l.lscale,r.rscale)
  local result = false
  if 
    FilterType(c,TYPE_MONSTER)
    and FilterRevivable(c)
    and (
	  FilterLocation(c,LOCATION_HAND)
      or 
	  FilterLocation(c,LOCATION_EXTRA)
      and FilterPosition(c,POS_FACEUP)
      and FilterType(c,TYPE_PENDULUM)
	)
    and (
	  (c.level > l.lscale and c.level < r.lscale)
	  or
	  (c.level < l.lscale and c.level > r.lscale)
	)
	and not DPendulumSummonableExceptFilter(c)
	then
	  result = true
	end
	--print(c.id,c.level,result)
	return result
end

function DPendulumSummonableExceptFilter(c)
  return
    c.id == 50485594
end
------------------------
-------- CHECK --------
------------------------
function CheckDinomistLScaleDestroy(scale)
  if HasID(AIST(),77116346,true,nil,nil,POS_FACEUP)
  and OPTCheck(77116346) -- DCharge
  then
    return true
  else
    if scale == 3
	then
	  print("CheckDinomistLScaleDestroy",3)
	  print(CardsMatchingFilter(AIHand(),DinomistLScaleFilter,3))
	  return CardsMatchingFilter(AIHand(),DinomistLScaleFilter,3) > 0
	end
    if scale == 6
	then
	  print("CheckDinomistLScaleDestroy",6)
	  print(CardsMatchingFilter(AIHand(),DinomistLScaleFilter,6))
	  return CardsMatchingFilter(AIHand(),DinomistLScaleFilter,6) > 0
	end
  end
  return false
end

------------------------
--------- USE ----------
------------------------
function UseDSpinos(c)
  print("UseDSpinos")
  if not OPTCheck(c.id + 1) and not OPTCheck(c.id + 2)
  then
    return false
  end
  if GlobalPendulum ~= Duel.GetTurnCount()
  and ScaleCheck() == true
  then 
    return true
  end
  -- Double
  if not OPTCheck(c.id + 1) 
  or 
  #OppMon() == 0
  then
    --OPTSet(c.id + 2)
    return true
  end
  -- Direct
  if #OppMon() == 0 then
    return false
  end
  if AI.GetPlayerLP(2) <= c.attack
  or 
  AI.GetPlayerLP(2) <= (c.attack * 2)
  and (
    not OPTCheck(c.id + 2)
	or 
	CardsMatchingFilter(AIMon(),DinomistFilter) >= 3
  )
  then
    --OPTSet(c.id + 1)
    return true
  end
  return false
end
function UseDSpinosDirectAttack()
  if #OppMon() == 0 then
    return false
  end
  OPTSet(05067884 + 1)
  return true
end
function UseDSpinosDoubleAttack()
  if not OPTCheck(05067884 + 1) 
  or 
  #OppMon() == 0
  then
    OPTSet(05067884 + 2)
    return true
  end
  return false
end
function UseDRexShuffle(c)
  if CardsMatchingFilter(AIMon(),AvailableAttacksFilter,0) > 1
  then
    OPTSet(c.id)
    return true
  end
  return false
end
function UseDRexDoubleAttack(c)
  return false
end
function UseDPteran(c)
  return true
end
function UseDStegosaur(c)
  return false
end

function ActiveDCharge(c)
  if OPTCheck(c.id+1) then
    OPTSet(c.id+1)
    return true
  end
  return false
end

function UseDRush(c)
  if Duel.GetTurnPlayer() == (1 - player_ai) -- OppTurn
  then
    if IsBattlePhase() then
      if #AIMon() == 0
	  and CardsMatchingFilter(OppMon(),AvailableAttacksMinFilter,1) > 1
	  then
	    OPTSet(c.id)
	    return true
	  end

	  local aimon,oppmon=GetBattlingMons()
      if WinsBattle(oppmon,aimon)
	  and HasID(AIDeck(),38988538,true) -- DPlesios
      then
	    OPTSet(c.id)
        return true
      end
    end
  else -- AITurn
    OPTSet(c.id)
    return true
  end
  return false
end

function ActiveDHowling(c)
  if FilterPosition(c,POS_FACEUP)
  then
    return false
  end
  if ScaleCheck() ~= true
  then
    return true
  end
  return false
end
function UseDHowling(c)
  if
  HasID(AIST(),77116346,true,nil,nil,POS_FACEUP)
  and OPTCheck(77116346) -- DCharge
  and (#AIMon() > 1 or GlobalPendulum ~= Duel.GetTurnCount())
  or
  ScaleCheck() == true
  and (#AIMon() > 1 or GlobalPendulum ~= Duel.GetTurnCount())
  then
    return true
  end
  return false
end

function UseDEOscilation(c)
  if
  HasID(AIST(),77116346,true,nil,nil,POS_FACEUP)
  and OPTCheck(77116346) -- DCharge
  or
  CardsMatchingFilter(AIHand(),DinomistMonFilter) > 0
  then
    OPTSet(c.id)
    return true
  end
  return false
end

------------------------
--------- SET ----------
------------------------
function SetDRush(c)
  return true
end

function SetGenericST(c)
  if HasID(AIST(),c.id,true) then
    return false
  end
  return true
end

--[[LIST
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos

77116346, -- DCharge
41128647, -- DPowerload

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation

22638495, -- DPower
]]
UseDinomistFunctions = {
[63251695] = UseDRexShuffle,			-- DRex
[63251696] = UseDRexAttack,				-- DRex
[64973287] = UseDPteran,				-- DPteran
[01580833] = UseDStegosaur,				-- DStegosaur

[15582767] = UseDEOscilation,			-- DEOscilation
}

function DinomistEffectYesNo(id,card)
  print("EffectYesNo",id)

  local result = nil

  if id == 63251695 then
    print("REX",card.description)
  end

  for i,v in pairs(UseDinomistFunctions) do
    if id == i then
	  if v(card) then
	    result = 1
	  end
    end
  end

  if result then
    if result == 1 then
      OPTSet(id)
	end
  end

  return result
end

function DinomistYesNo(description_id)
  if (description_id/16) > 99999 then
    print("YesNo - id: "..(description_id/16).." - desc: "..description_id)
	-- 3
	if math.floor(description_id/16) == 05067884 -- DSpinos
	or math.floor(description_id/16) == 37752990 -- DCeratops
	or math.floor(description_id/16) == 64973287 -- DPteran
	or math.floor(description_id/16) == 01580833 -- DStegosaur
	then
	  if EffectCheck(1-player_ai)
	  or Duel.GetCurrentChain() == 0
	  then
	    print("entra")
	    local removeCheckList = RemovalCheckList(AIField())
		local ignoreSave = false
		if removeCheckList ~= false and #removeCheckList > 0 then
		  print("removeCheckList",#removeCheckList)
		  if CardsMatchingFilter(removeCheckList,FilterID,60675348) > 0 -- DHowling
		  then
		    return true
		  end
		  if CardsMatchingFilter(removeCheckList,FilterID,77116346) -- DCharge
		  == CardsMatchingFilter(AIST(),FilterID,77116346) -- DCharge
		  then
		    return true
		  end
		  local dIgnoreSaveCount = CardsMatchingFilter(removeCheckList,DIgnoreSaveFilter)
		  --print("dIgnoreSaveCount",dIgnoreSaveCount)
		  if dIgnoreSaveCount == #removeCheckList then
		    ignoreSave = true
		  end
		end
		print("ignoreSave3",ignoreSave)
	    if (CheckDinomistLScaleDestroy(3) and ignoreSave == false)
		or (removeCheckList ~= false and #removeCheckList >= 3)
		then
		  return 1
		else
		  return 0
		end
	  else
	    return 0
	  end
	end
	-- 6
	if math.floor(description_id/16) == 63251695 -- DRex
	or math.floor(description_id/16) == 00368382 -- DBrachion
	or math.floor(description_id/16) == 38988538 -- DPlesios
	or math.floor(description_id/16) == 32134638 -- DAnkylos
	then
	  if EffectCheck(1-player_ai)
	  or Duel.GetCurrentChain() == 0
	  then
	    local removeCheckList = RemovalCheckList(AIField())
		local ignoreSave = false
		if removeCheckList ~= false and #removeCheckList > 0 then
		  print("removeCheckList",#removeCheckList)
		  if CardsMatchingFilter(removeCheckList,FilterID,60675348) > 0 -- DHowling
		  then
		    return true
		  end
		  if CardsMatchingFilter(removeCheckList,FilterID,77116346) -- DCharge
		  == CardsMatchingFilter(AIST(),FilterID,77116346) -- DCharge
		  then
		    return true
		  end
		  local dIgnoreSaveCount = CardsMatchingFilter(removeCheckList,DIgnoreSaveFilter)
		  --print("dIgnoreSaveCount",dIgnoreSaveCount)
		  if dIgnoreSaveCount == #removeCheckList then
		    ignoreSave = true
		  end
		end
		print("ignoreSave6",ignoreSave)
	    if (CheckDinomistLScaleDestroy(6) and ignoreSave == false)
		or (removeCheckList ~= false and #removeCheckList >= 3)
		then
		  return 1
		else
		  return 0
		end
	  else
	    return 0
	  end
	end
  else
    print("YesNo - desc: "..description_id)
  end
end

function DinomistOption(options)
  print("Options:")
  for i=1,#options do
    print(i, options[i])
	if ((options[i] - 3) / 16) == 63251695 then -- DRex Hand
	  print("DRex Option - Hand")
	  return i
	end
	if ((options[i] - 2) / 16) == 63251695 then -- DRex Field
	  print("DRex Option - Field")
	  return i
	end
	if ((options[i] - 2) / 16) == 05067884  -- DSpinos Double
	and UseDSpinosDoubleAttack()
	then
	  print("DSpinos Option - Double")
	  return i
	end
	if ((options[i] - 1) / 16) == 05067884  -- DSpinos Direct
	and UseDSpinosDirectAttack()
	then
	  print("DSpinos Option - Direct")
	  return i
	end
  end
  return nil
end

------------------------
-------- SUMMON --------
------------------------
function SummonDPlesios(c)
  return true
end

function SummonDRHamster(c)
  print("SummonDRHamster")
  local extraFaceUp = SubGroup(AIExtra(),FilterPosition,POS_FACEUP)
  local pendulumFaceUp = SubGroup(extraFaceUp,FilterType,TYPE_PENDULUM)
  if #pendulumFaceUp > 0 then
    for i=1, #pendulumFaceUp do
	  local c = pendulumFaceUp[i]
	  if c.level <= 5 
	  and CardsMatchingFilter(AIDeck(),FilterID,c.id) == 2 
	  then
	    return true
	  end
	end
  end
  return false
end
------------------------
-------- TARGET --------
------------------------
function DSpinosTarget(cards,c,min,max)
  return Add(cards,PRIO_TOGRAVE,min)
end
function DRexTarget(cards,c,min,max)
  return Add(cards,PRIO_TOGRAVE,min,AvailableAttacksFilter,0)
end
function DPteranTarget(cards,c,min,max)
  if OPTCheck(77116346+1) then
    return Add(cards,PRIO_TOHAND,max)
  end
  return DinomistToHandTarget(cards,c,min,max)
end

function DChargeTarget(cards,c,min,max)
  if LocCheck(cards,LOCATION_EXTRA) then
    OPTSet(c.id)
  end
  return DinomistToHandTarget(cards,c,min,max)
end

function DinomistToHandTarget(cards,c,min,max)
  if ScaleCheck() == false then
    local scaleHand3 = CardsMatchingFilter(AIHand(),FilterLScale,3)
    local scaleHand6 = CardsMatchingFilter(AIHand(),FilterLScale,6)
	local scaleX = 6
	if scaleHand6 > scaleHand3 then scaleX = 3 end
    return Add(cards,PRIO_TOHAND,max,FilterLScale,scaleX)
  end
  if ScaleCheck() == 6 then
    return Add(cards,PRIO_TOHAND,max,FilterLScale,3)
  end
  if ScaleCheck() == 3 then
    return Add(cards,PRIO_TOHAND,max,FilterLScale,6)
  end
  return Add(cards,PRIO_TOHAND,max)
end

function DMGreed(cards,c,min,max)
  return Add(cards,PRIO_DISCARD,min)
end

function DRushTarget(cards,c,min,max)
  return Add(cards,PRIO_TOFIELD,max)
end
function DHowlingTarget(cards,c,min,max)
  if LocCheck(cards,LOCATION_DECK) then
    print("DHowlingTarget")
    if ScaleCheck() == false then
      local result = {}
      local scale3 = CardsMatchingFilter(cards,FilterLScale,3)
      local scale6 = CardsMatchingFilter(cards,FilterLScale,6)
	  local x = 1
	  if scale3 > 0 and scale6 > 0 then
	    x = 2
	  end
      for i=1,#cards do
	    local c = cards[i]
	    if #result < x and c.lscale == 3 and scale3 > 0 then
		  scale3 = 0
	      result[#result+1] = i
	    end
	    if #result < x and c.lscale == 6 and scale6 > 0 then
		  scale6 = 0
	      result[#result+1] = i
	    end
	  end
	  return result
    end
    if ScaleCheck() == 6 then
      return Add(cards,PRIO_TOHAND,max,FilterLScale,3)
    end
    if ScaleCheck() == 3 then
      return Add(cards,PRIO_TOHAND,max,FilterLScale,6)
    end
  end
  -- PRIO_TOHAND
  if LocCheck(cards,LOCATION_ONFIELD) then
    if FilterController(cards[1],1) then
	  print("DHowlingTarget - TRIBUTE")
      local result = nil
      if GlobalCardMode == 2 then
	    print("GlobalTargetID2",GlobalTargetID)
        result = GlobalTargetGet(cards,true)
		print("GlobalTargetGet",result)
      end
      GlobalCardMode = nil
      if result == nil then 
	    result = Add(cards,PRIO_TOGRAVE,1) 
		print("result",result[1])
	  end
      return result
	else
	  print("DHowlingTarget - TO HAND")
      local result = nil
      if GlobalCardMode == 1 then
	    print("GlobalTargetID2",GlobalTargetID)
        result = GlobalTargetGet(cards,true)
		print("GlobalTargetGet",result)
      end
      GlobalCardMode = nil
      if result == nil then 
	    result = BestTargets(cards,1,TARGET_TOHAND) 
		print("result",result[1])
	  end
      return result
	end
  end
  return Add(cards,PRIO_TOHAND,max)
end

function DEOscilationTarget(cards,c,min,max)
  local scaleHand3 = CardsMatchingFilter(AIHand(),FilterLScale,3)
  local scaleHand6 = CardsMatchingFilter(AIHand(),FilterLScale,6)
  if scaleHand3 > 0 and scaleHand6 > 0
  then
    return Add(cards,PRIO_TOHAND,min)
  end
  local scaleX = 3
  if scaleHand6 > scaleHand3 then scaleX = 6 end
  return Add(cards,PRIO_TOHAND,max,FilterLScale,scaleX)
end

--[[LIST
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos

77116346, -- DCharge
41128647, -- DPowerload

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation

22638495, -- DPower
]]

DinomistTargetFunctions = {
[63251695] = DSpinosTarget,			-- DSpinos
[63251695] = DRexTarget,			-- DRex
[64973287] = DPteranTarget,			-- DPteran

[77116346] = DChargeTarget,			-- DCharge
[22123627] = DMGreedTarget,			-- DMGreed

[41554273] = DRushTarget,			-- DRush
[60675348] = DHowlingTarget,		-- DHowling
[15582767] = DEOscilationTarget,	-- DEOscilation
}

function DinomistCard(cards,min,max,id,c)
  if c then
    print("Card - CardId: ".. c.id .." - cards: "..#cards.." - min: "..min.." - max: "..max)
  end

  if GlobalPendulumSummoning and Duel.GetCurrentChain()==0 then
	GlobalPendulumSummoning = nil
	print("PendulumSummoning")
	local exceptCount = CardsMatchingFilter(cards,DPendulumSummonableExceptFilter)
	local x = max - exceptCount
	return Add(cards,PRIO_TOFIELD,max)
  end

  for i,v in pairs(DinomistTargetFunctions) do
    if id == i then
      return v(cards,c,min,max)
    end
  end

  return nil
end
------------------------
-------- CHAIN ---------
------------------------
function ChainDLRemoval(c)
  if Duel.GetTurnPlayer() == (1 - player_ai) -- OppTurn
  then
    return false
  else
    if Duel.CheckTiming(TIMING_BATTLE_START) then
	  print("ChainLRemoval - TIMING_BATTLE_START")
	  local machineMon = SubGroup(AIMon(),FilterRace,RACE_MACHINE)
	  if machineMon then
	    local damage = 0
	    for i=1, #machineMon do
		  local card = machineMon[i]
		  if FilterPosition(card,POS_ATTACK)
		  and AvailableAttacksMinFilter(card,1)
		  then
		    damage = damage + (AvailableAttacks(card) * card.attack * 2)
		  end
		end
		print("ChainLRemoval - Damage:",damage)
		if damage >= AI.GetPlayerLP(2) then
		  return true
		end
	  end
	end
  end
  return false
end

function ChainDRush(c)
  if UseDRush(c)
  or RemovalCheckCard(c,CATEGORY_DESTROY)
  or RemovalCheckCard(c,CATEGORY_REMOVE)
  or RemovalCheckCard(c,CATEGORY_TOGRAVE)
  then
    OPTSet(c.id)
	return true
  end
  return false
end
function ChainActiveDHowling(c)
  if FilterPosition(c,POS_FACEUP)
  then
    return false
  end
  return
    (ActiveDHowling(c)
    and not ChainCheck(15582767)
	and not ChainCheck(c.id))
	or RemovalCheckCard(c,CATEGORY_DESTROY)
    or RemovalCheckCard(c,CATEGORY_REMOVE)
    or RemovalCheckCard(c,CATEGORY_TOGRAVE)
    or NegateCheckCard(c)

end
function ChainUseDHowling(c)
  print("ChainUseDHowling - REMOVE")
  if UseDHowling(c)
  and
  (Duel.CheckTiming(TIMING_END_PHASE)
  or RemovalCheckCard(c,CATEGORY_DESTROY)
  or RemovalCheckCard(c,CATEGORY_REMOVE)
  or RemovalCheckCard(c,CATEGORY_TOGRAVE)
  or NegateCheckCard(c))
  then
    print("ChainUseDHowling - END/REMOVE")
    return true
  end
  
  print("ChainUseDHowling - REMOVE MON")
  local removeCheckList = {}
  removalCheckList = RemovalCheckList(AIField()) 
  if removalCheckList
  then
    if CardsMatchingFilter(removalCheckList,DinomistMonFilter) > 0	
	then
	  GlobalCardMode = 2
	  local dSaveList = Add(removalCheckList,PRIO_TOGRAVE,1,DinomistMonFilter)
      GlobalTargetSet(removalCheckList[dSaveList[1]],AIMon())
	  print("DHowling - Destroy MONID", GlobalTargetID)
	  return true
	end
  end

  print("ChainUseDHowling - PRIO TARGET")
  local targets2 = CardsMatchingFilter(OppField(),DHowlingFilter2)
  local prio = SubGroup(OppField(),FilterPriorityTarget)
  print("targets2",targets2)
  if targets2 > 0 and UseDHowling(c) then
    print("ChainUseDHowling - MON TO HAND")
    return true
  end

  print("ChainUseDHowling - BATTLE")
  if IsBattlePhase() then
    print("ChainUseDHowling - BATTLE1")
    local aimon,oppmon=GetBattlingMons()
    if WinsBattle(oppmon,aimon)
	and not (
	  HasID(AIST(),41554273,true) -- DRush
	  and OPTCheck(41554273)
	  and HasID(AIDeck(),38988538,true) -- DPlesios
	)
	and not ChainCheck(41554273) -- DRush
    then
	  print("ChainUseDHowling - BATTLE2")
      GlobalCardMode = 1
      GlobalTargetSet(oppmon,OppMon())
	  print("GlobalTargetID",GlobalTargetID)
      OPTSet(c.id)
      return true
    end
  end
  print("ChainUseDHowling - END")
  return false
end
function ChainDEOscilation(c)
  if (
    UseDEOscilation(c)
    and Duel.CheckTiming(TIMING_END_PHASE)
  )
  or RemovalCheckCard(c,CATEGORY_DESTROY)
  or RemovalCheckCard(c,CATEGORY_REMOVE)
  or RemovalCheckCard(c,CATEGORY_TOGRAVE)
  then
    OPTSet(c.id)
    return true
  end
  return false
end
function ChainDEBuck(c)
  return true
end
DinomistChainFunctions={
[23171610] = ChainDLRemoval,	-- DLRemoval
[41554273] = ChainDRush,		-- DRush
[15582767] = ChainDEOscilation,	-- DEOscilation
[94937430] = ChainDEBuck,		-- DEBuck
}
function DinomistChain(cards)
  if HasIDNotNegated(cards,60675348,false,nil,nil,POS_FACEDOWN)
  and ChainActiveDHowling(cards[CurrentIndex])
  then
    return Chain()
  end
  if HasIDNotNegated(cards,60675348,false,nil,nil,POS_FACEUP)
  and ChainUseDHowling(cards[CurrentIndex])
  then
    return Chain()
  end
  for id,v in pairs(DinomistChainFunctions) do
    if HasID(cards,id,v) then
      return Chain()
    end
  end
  return nil
end
------------------------
-------- BATTLE --------
------------------------

--[[LIST
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos

77116346, -- DCharge
41128647, -- DPowerload

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation

22638495, -- DPower
]]
DinomistAtt={
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos
}
DinomistDef={
22638495, -- DPower
}
function DinomistPosition(id,available)
  result = nil
  for i=1,#DinomistAtt do
    if DinomistAtt[i]==id
    then
      result=1
    end
  end
  for i=1,#DinomistDef do
    if DinomistDef[i]==id
    then
      result=4
    end
  end

  return result
end

function DinomistBattleCommand(cards, activatable)
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

  if HasIDNotNegated(cards,64973287) -- DPteran
  and CanWinBattle(cards[CurrentIndex],targets)
  then
    return Attack(CurrentIndex)
  end

  return nil
end

--[[LIST
05067884, -- DSpinos
63251695, -- DRex
37752990, -- DCeratops
00368382, -- DBrachion
64973287, -- DPteran
38988538, -- DPlesios
01580833, -- DStegosaur
32134638, -- DAnkylos

77116346, -- DCharge
41128647, -- DPowerload

41554273, -- DRush
60675348, -- DHowling
15582767, -- EOscilation

22638495, -- DPower
]]
