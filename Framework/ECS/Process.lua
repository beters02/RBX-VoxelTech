--[[
    ECS Process Module - Responsible for processing all entities that require processing.
]]

local Process = {
    Threads = {}
}

function Process.init(entity)
    if not Process.Threads[entity.Name] then
        Process.Threads[entity.Name] = {}
    end
    Process.Threads[entity.Name][entity.ID] = entity
end

function Process.remove(entity)
    if Process.Threads[entity.Name] then
        Process.Threads[entity.Name][entity.ID] = nil
    end
end

return Process