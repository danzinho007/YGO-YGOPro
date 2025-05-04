function s.can_be_used_as_material(tp)
    -- Obtém o monstro na Zona 2 do campo do jogador (posição do meio)
    local tc = Duel.GetFieldCard(tp, LOCATION_MZONE, 2)
    
    -- Verifica se há um monstro nessa posição, se está virado para cima e em posição de ataque
    if tc and tc:IsFaceup() and tc:IsPosition(POS_FACEUP_ATTACK) then
        local lvl = tc:GetLevel() -- Obtém o nível da carta
        
        -- Define a lógica de evolução dos níveis
        local next_level = {
            [1] = 4,
            [4] = 6,
            [6] = 8,
            [8] = 10,
            [10] = 12
        }

        -- Retorna o nível permitido para montagem
        return next_level[lvl] or nil
    end
    
    return nil -- Retorna nil se não houver monstro ou não atender os requisitos
end

function s.cartaTerreno(e,tp,eg,ep,ev,re,r,rp)
    -- Lista de cartas de campo genéricas (substitua pelos IDs das cartas desejadas)
    local terrenos = {100000001, 100000002, 100000003, 100000004, 100000005}
    
    -- Escolhe um terreno aleatório da lista
    local terrenoID = terrenos[math.random(#terrenos)]
    
    -- Cria e ativa a carta de campo
    local tc = Duel.CreateToken(tp, terrenoID)
    Duel.MoveToField(tc, tp, tp, LOCATION_FZONE, POS_FACEUP, true)
    
    -- Adiciona 6 marcadores à carta do campo
    tc:AddCounter(0x109, 6)
end

