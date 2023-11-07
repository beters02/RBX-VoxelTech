local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedCore = ReplicatedStorage:WaitForChild("Core")

local Framework = {}
Framework.Components = ReplicatedCore:WaitForChild("Components")
Framework.IDs = ReplicatedCore:WaitForChild("IDs")
Framework.Types = require(script:WaitForChild("Types"))

return Framework