local Players = game:GetService("Players")
local Framework = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"))

Framework:init()
Players.PlayerAdded:Once(function(player)
    Framework:firstPlayerAdded(player)
end)

-- Load Game Objects
