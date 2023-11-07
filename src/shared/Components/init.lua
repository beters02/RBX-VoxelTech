local Components = {}
local _C = script

function Components.FindComponent(nonUniqueID)
    local def = _C:FindFirstChild(nonUniqueID)
    return def and require(def) or false
end

return Components