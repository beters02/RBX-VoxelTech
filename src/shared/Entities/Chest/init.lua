-- [[ Any interactable block is going to be considered a "Chest" ]]

local Chest = {
    RBXTemplateObject = game.ReplicatedStorage.Assets.Chest,
    Properties = {IsAlive = false, Health = 50, Drops = true},
    Components = {
        {Template = "Container"}
    }
}

return Chest