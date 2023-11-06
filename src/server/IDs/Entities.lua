local Container = require(script.Parent.Parent.Components.Container)

export type Multiplier = number
export type Offset = number

export type Entity = {
    processSpeed: Multiplier,
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