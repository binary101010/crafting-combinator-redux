local config = require "configuration"

local events = {}

local openedEntity = nil

local function initCraftingCombinatorEntity(createdEntity)
    if createdEntity.name == config.CRAFTINGCOMBINATOR_NAME then
        global.craftingcombinators[createdEntity] = {assemblers={}}
    end
end

local function isFoundInOtherCraftingCombinator(entityToAdd)
    for i, entity in pairs(global.craftingcombinators) do
        for i_, assembler in pairs(entity.assembler) do
            if assembler == entityToAdd then
                return true
            end
        end
    end

    return false
end

events.entityBuilt = function(e)
    initCraftingCombinatorEntity(e.created_entity)
end

events.entityRobotBuilt = function(e)
    initCraftingCombinatorEntity(e.created_entity)
end

events.guiOpened = function(e)
    local player = game.players[e.player_index]
    local entity = e.entity

    if entity and entity.name == config.CRAFTINGCOMBINATOR_NAME then
        local gui = player.gui.center
        player.opened = gui.add{
            type = "frame",
            name = config.GUI_PREFIX.."-entity-frame",
            caption = config.GUI_CAPTION,
            direction = "vertical",
        }
        player.opened.add{
            type = "button",
            name = config.GUI_PREFIX.."-add-button",
            caption = config.GUI_ADD_BUTTON,
            tooltip = config.GUI_ADD_BUTTON_TOOLTIP
        }
        openedEntity = entity
    end
end

events.guiClosed = function(e)
    local guiElement = e.element

    if guiElement and guiElement.name == config.GUI_PREFIX.."-entity-frame" then
        guiElement.destroy()
        openedEntity = nil
    end
end

events.guiClicked = function(e)
    local player = game.players[e.player_index]
    local guiElement = e.element

    if guiElement and guiElement.name == config.GUI_PREFIX.."-add-button" then
        --guiElement.parent.style.visible = false
        player.cursor_stack.set_stack{name=config.CRAFTINGCOMBINATOR_NAME_SELECTION_TOOL}
    end
end

events.areaSelected = function(e)
    local player = game.players[e.player_index]
    local selectedEntities = e.entities
    local selectionTool = e.item

    if selectionTool == config.CRAFTINGCOMBINATOR_NAME_SELECTION_TOOL then
        player.clean_cursor()
        for i, selectedEntity in pairs(selectedEntities) do
            if selectedEntity.type == "assembling-machine" and not isFoundInOtherCraftingCombinator(selectedEntity) then
                table.insert(global.craftingcombinators[openedEntity].assemblers, selectedEntity)
                game.print("entity added: "..selectedEntity.name)
            end
        end
    end
end

events.cursorStackChanged = function(e)
    local player = game.players[e.player_index]
    local guiElement = player.opened

    if not player.cursor_stack.valid_for_read
        and guiElement
        and guiElement.name == config.GUI_PREFIX.."-entity-frame" then
        --guiElement.parent.style.visible = true
    end

    player.get_main_inventory().remove{name=config.CRAFTINGCOMBINATOR_NAME_SELECTION_TOOL}
end

events.entitySelected = function(e)
    local player = game.players[e.player_index]
    local selectedEntity = e.last_entity

    if selectedEntity and selectedEntity.name == config.CRAFTINGCOMBINATOR_NAME then
        if global.craftingcombinators[selectedEntity] then
            for i, assembler in pairs(global.craftingcombinators[selectedEntity].assemblers) do
                -- TODO: mache rahmen um assembler
                game.print("crafting combinator selektiert")
            end
        end
    end
end

return events
