-- Get position depending on distance and direction
function adjustDirection(playerDirection, teleportPos, teleportDistance)
    if playerDirection == DIRECTION_NORTH then
        teleportPos.y = teleportPos.y - teleportDistance
    elseif playerDirection == DIRECTION_SOUTH then
        teleportPos.y = teleportPos.y + teleportDistance
    elseif playerDirection == DIRECTION_EAST then
        teleportPos.x = teleportPos.x + teleportDistance
    elseif playerDirection == DIRECTION_WEST then
        teleportPos.x = teleportPos.x - teleportDistance
    end
    return teleportPos
end

function teleportAttempt(creature, playerPos, teleportPos)
    local checkPathing = creature:getPathTo(teleportPos, 0, 0, true, false)
    if checkPathing == false then
        creature:sendTextMessage(MESSAGE_STATUS_SMALL, "You cannot teleport there.")
        return false
    end

    creature:teleportTo(teleportPos)
    playerPos:sendMagicEffect(62)
    return true
end

function onCastSpell(creature, var)
    local playerPos = creature:getPosition()
    local playerDirection = creature:getDirection()
    local magicLevel = creature:getMagicLevel()
    local teleportDistance = 6
    local skull = creature:getSkull()

    local teleportPos = playerPos
    local adjustedPos = teleportPos

    for i = 1, teleportDistance do
        adjustedPos = adjustDirection(playerDirection, adjustedPos, 1)

        local teleportTile = Tile(adjustedPos)
        if teleportTile then
            if teleportTile:hasFlag(TILESTATE_BLOCKSOLID) == false and teleportTile:hasFlag(TILESTATE_FLOORCHANGE) == false then
                local creatureCheck = teleportTile:getCreatures()
                if creatureCheck and #creatureCheck == 0 then
                    if teleportTile:hasFlag(TILESTATE_HOUSE) then
                        if skull == 0 then
                            local house = teleportTile:getHouse()
                            local houseOwner = house:getOwnerGuid()
                            if creature:getGuid() == houseOwner then
                                if teleportAttempt(creature, playerPos, adjustedPos) then
                                    playerPos = adjustedPos
                                end
                            end
                        end
                    elseif teleportTile:hasFlag(TILESTATE_PROTECTIONZONE) then
                        if skull == 0 then
                            if teleportAttempt(creature, playerPos, adjustedPos) then
                                playerPos = adjustedPos
                            end
                        end
                    else
                        if teleportAttempt(creature, playerPos, adjustedPos) then
                            playerPos = adjustedPos
                        end
                    end
                end
            end
        end
    end

    return true
end