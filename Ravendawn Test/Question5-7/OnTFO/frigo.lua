local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)

-- Set area

local damageArea = {
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 2, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1}
}

local animationArea = {
    {
        {0, 0, 0, 4, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 4, 0},
        {1, 0, 0, 2, 0, 0, 1},
        {0, 0, 0, 0, 0, 4, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0},
        {0, 4, 0, 4, 0, 0, 0},
        {1, 0, 0, 2, 0, 0, 1},
        {0, 4, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 4, 0, 0, 0},
        {0, 0, 1, 4, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 4, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 4, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 0, 0, 4, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
	    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 4, 0, 4, 0, 0, 0},
        {1, 0, 0, 2, 0, 0, 1},
        {0, 4, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
	    {
        {0, 0, 0, 4, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 4, 0, 4, 0, 4, 0},
        {0, 0, 1, 2, 1, 0, 0},
        {0, 4, 0, 4, 0, 4, 0},
        {0, 0, 1, 4, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
		{
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 2, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
		{
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 2, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    }

}

local area = createCombatArea(damageArea)
combat:setArea(area)

function onGetFormulaValues(player, level, maglevel)
    local min = (level / 5) + (maglevel * 1.4) + 8
    local max = (level / 5) + (maglevel * 2.2) + 14
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local function animation(pos, playerpos, effect)
    if Position(pos):isSightClear(playerpos) then
        Position(pos):sendMagicEffect(effect)
    end
end

function onCastSpell(creature, var)
    local creaturepos = creature:getPosition()
    local playerpos = Position(creaturepos)
    local delay = 200

    local centre = {}
    local damagearea = {}

    for j = 1, #animationArea do
        for k, v in ipairs(animationArea[j]) do
            for i = 1, #v do
                if v[i] == 3 or v[i] == 2 then
                    centre.Row = k
                    centre.Column = i
                    table.insert(damagearea, centre)
                elseif v[i] == 1 then
                    local darea = {}
                    darea.Row = k
                    darea.Column = i
                    darea.Delay = j * delay
                    darea.Effect = 44 -- Efecto para el 1
                    table.insert(damagearea, darea)
                elseif v[i] == 4 then
                    local darea = {}
                    darea.Row = k
                    darea.Column = i
                    darea.Delay = j * delay
                    darea.Effect = 42 -- Efecto para el 4
                    table.insert(damagearea, darea)
                end
            end
        end
    end

    for i = 1, #damagearea do
        local modifierx = damagearea[i].Column - centre.Column
        local modifiery = damagearea[i].Row - centre.Row

        local damagepos = Position(creaturepos)
        damagepos.x = damagepos.x + modifierx
        damagepos.y = damagepos.y + modifiery

        local animationDelay = damagearea[i].Delay or 0
        local effect = damagearea[i].Effect

        addEvent(animation, animationDelay, damagepos, playerpos, effect)
    end

    return combat:execute(creature, var)
end