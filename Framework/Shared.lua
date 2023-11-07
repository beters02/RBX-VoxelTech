export type Multiplier = number
export type Offset = number
export type Array<T> = {[number]: T}

export type Entity = {
    RBXTemplateObject: any,
    RBXWorldObject: any,

    Properties: EntityProperties,

    Components: {},
    AddComponent: () -> (),
    RemoveComponent: () -> (),
    GetComponent: () -> (),
    GetComponents: () -> ({}),

    Systems: {},
    EnableSystem: () -> (),
    GetSystems: () -> (),
}

export type EntityProperties = {
    IsAlive: boolean,
    Health: number,
    Drops: boolean,
}

export type Component = {}
export type System = {}

return nil