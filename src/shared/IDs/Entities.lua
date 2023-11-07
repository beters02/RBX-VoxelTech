local Framework = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"))
local Types = Framework.Types

local Container = require(Framework.Components.Container)

export type Entity = {
    processSpeed: Types.Multiplier,
    canProcess: boolean,
    canCollide: boolean,
    fuelInputType: Fuel,
    fuelOutputType: Fuel,

    Container: any
}

export type Fuel = "Heat" | "Power" | nil

local Entity = {
    Chest = {
        canCollide = true,
        Container = Container.new({Stored = 27})
    }:: Entity
}

return Entity