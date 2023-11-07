--[[
    ENTITY TABLE DEF EXAMPLE:

    in a moduleScript called "Machine", placed in Entities:
    local Machine = {
        Template = "Chest",
        Components = {
            {"InternalFuel", {Base = 15, Max = 100}}
        },
        Systems = {
            {"HandleFuel"}
        }
    }
    return Machine
]]

local Entity = {}
local Entities = script

function Entity.GetEntity(nonUniqueID)
    local def = Entities:FindFirstChild(nonUniqueID)
    return def and require(def) or false
end

return Entity