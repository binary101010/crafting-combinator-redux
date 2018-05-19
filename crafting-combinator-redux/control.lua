local events = require "events"

script.on_init(function()
    global.craftingcombinators = global.craftingcombinators or {}
end)

script.on_event(defines.events.on_built_entity, events.entityBuilt)
script.on_event(defines.events.on_robot_built_entity, events.entityRobotBuilt)

script.on_event(defines.events.on_gui_opened, events.guiOpened)
script.on_event(defines.events.on_gui_closed, events.guiClosed)
script.on_event(defines.events.on_gui_click, events.guiClicked)
script.on_event(defines.events.on_player_selected_area, events.areaSelected)
script.on_event(defines.events.on_player_alt_selected_area, events.areaSelected)
script.on_event(defines.events.on_player_cursor_stack_changed , events.cursorStackChanged)
script.on_event(defines.events.on_selected_entity_changed, events.entitySelected)