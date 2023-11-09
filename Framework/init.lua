local Framework = {}
local ServerType = script:WaitForChild("ServerTypeValue")

function Framework:init()
    
end

function Framework:firstPlayerAdded(player: Player)
    local teleData = player:GetJoinData().teleportData
    if teleData and teleData.ServerType ~= "Hub" then
        self:setServerType(teleData.ServerType)
    end
end

function Framework:setServerType(stype)
    ServerType.Value = stype
end

return Framework