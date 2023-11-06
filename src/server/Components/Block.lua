local Block = {}

function Block.new(blockName: string)
    local block = script:FindFirstChild(blockName)
    block = block or {}
    local self = setmetatable({})
end

function Block:canProcess()
    
end

return Block