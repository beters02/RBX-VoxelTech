local rs = game.ReplicatedStorage
local assets = rs:WaitForChild("Assets")

local blocks = {grass = assets:WaitForChild("Grass"), stone = assets:WaitForChild("Stone"), dirt = assets:WaitForChild("Dirt")}
local models = {tree = assets:WaitForChild("Tree")}
local blockSize = Vector3.new(4, 4, 4)  -- Adjust the size of each block as needed

local mapBorders = Vector2.new(50, 50)
local caveBorders = Vector2.new(25, 25)

local layers = 10
local dirtLayers = 3
local caveLayers = 15

local threshold = 0
local seed = Random.new():NextInteger(0, 10e6)
local frequency = 1/16

function density(p: Vector3): number
    return math.noise(
        p.X * frequency,
        p.Y * frequency,
        p.Z * frequency
    )
end

function canPlace(position)
    local region = Region3.new(position - Vector3.new(0, 0.5, 0), position + Vector3.new(0, 0.5, 0))
    local parts = workspace:FindPartsInRegion3(region, nil, math.huge)
    return #parts == 0
end

function generateCaveLayer(stonePos, x, y, z)
    for ygen = 1, caveLayers do
        local d = density(Vector3.new(x + seed, y + ygen, z))
        if d < threshold then continue end

        local b = blocks.stone:Clone()
        b.Position = stonePos - Vector3.new(0, ygen * blockSize.Y, 0)
        b.Parent = workspace.Caves
    end
end

function generateSolidCaveLayer(stonePos)
    for ygen = 1, caveLayers do
        local b = blocks.stone:Clone()
        b.Position = stonePos - Vector3.new(0, ygen * blockSize.Y, 0)
        b.Parent = workspace.Caves
    end
end

function generateTree(block, spawnedTrees)
    if math.random() < 0.05 then
        local block2Position = block.Position + Vector3.new(0, blockSize.Y / 2, 0)

        if canPlace(block2Position) and not spawnedTrees[block2Position] then
            local treeModel = models.tree:Clone()
            treeModel.Parent = workspace
            treeModel:SetPrimaryPartCFrame(CFrame.new(block2Position))
            spawnedTrees[block2Position] = true
        end
    end
    return spawnedTrees
end

local function generateTerrain()
    local spawnedTrees = {}
    local caveStart = math.random(1, mapBorders.X - caveBorders.X)

    for i = 1, mapBorders.Y do
        for x = 1, mapBorders.X do
            local scale = 0.05
            local noise = math.noise(x * scale, i * scale)
            local height = math.floor(noise * layers)

            local block = blocks.grass:Clone()
            block.Position = Vector3.new((x - 12) * blockSize.X, height * blockSize.Y, (i - 12) * blockSize.Z)
            block.Parent = workspace

            for layer = 1, layers - height do
                local stonePosition = block.Position - Vector3.new(0, (dirtLayers + layer) * blockSize.Y, 0)

                if canPlace(stonePosition) then
                    local stone = blocks.stone:Clone()
                    stone.Parent = workspace
                    stone.Position = stonePosition

                    if i >= caveStart and x >= caveStart then
                        generateCaveLayer(stonePosition, x, layer, i)
                    else
                        generateSolidCaveLayer(stonePosition, x, layer, i)
                    end
                end
            end

            for layer = 1, dirtLayers do
                local dirtPosition = block.Position - Vector3.new(0, layer * blockSize.y, 0)

                if canPlace(dirtPosition) then
                    local dirt = blocks.dirt:Clone()
                    dirt.Parent = workspace
                    dirt.Position = dirtPosition
                end
            end

            if block.Name == "Grass" then
                spawnedTrees = generateTree(block, spawnedTrees)
            end
        end
    end
end


generateTerrain()