--[[
    ECS Used for OOP Organization of World Objects within VoxelTech.

    Entities can be defined in shared/IDs/Entities
    Components can be created via ECS.Component.new() or defined in shared/Components
    Systems are created in shared/Systems
]]

--[[
    [ENTITY]    - An entity is an Object with a Unique ID that can have it's own Components and Systems.
    [COMPONENT] - Components are Data Objects define the characteristics of the entity.
    [SYSTEM]    - A system is essentially a script that is responsible for handling the logic of an entity.
]]

local Shared = require(script.Parent:WaitForChild("Shared"))
local Entities = require(game:GetService("ReplicatedStorage").Core.Entities)
local Components = require(game:GetService("ReplicatedStorage").Core.Components)
local Lib = require(script.Parent:WaitForChild("Lib"))

local ECS = {
    _storedEntities = {}:: Shared.Array<Shared.Entity>
}

local Entity
local EntityPrivate
local Component
local System

EntityPrivate = {
    InitializeComponents = function(self: Shared.Entity)
        for compName, compData in pairs(self.Components) do
            self:AddComponent(compName, compData)
        end
    end
}

Entity = {

    RBXTemplateObject = false,
    RBXWorldObject = false,
    Properties = {IsAlive = false, Health = 100, Drops = false} :: Shared.EntityProperties,
    Template = false,
    Components = {},
    Systems = {},

    new = function(nonUniqueID)
        local entityDef = Entities.GetEntity(nonUniqueID)
        assert(entityDef, "Cannot find Entity " .. tostring(nonUniqueID) ". Did you create a def in shared/Entities ?")

        local self = setmetatable(entityDef, Entity)
        setmetatable(entityDef.Properties, Entity.Properties)
        EntityPrivate.InitializeComponents(self)
        EntityPrivate.InitializeSystems(self)
        self.new = false
        return self
    end,
    
    instantiate = function(self, cframe)
        self.RBXWorldObject = self.RBXTemplateObject:Clone()
        self.RBXWorldObject.Parent = workspace
        self.RBXWorldObject.CFrame = cframe
    end,

    AddComponent = function(self, component, data)
        if component.Template then
            return Component.fromTemplate(self, component.Template, data)
        else
            return Component.new(self, component, data)
        end
    end,

    AddSystem = function(self)
        
    end
}

Component = {
    new = function(self: Shared.Entity, id, data)
        self.Components[id] = self.Components[id] or Lib.clone(data)
    end,
    fromTemplate = function(self: Shared.Entity, templateName, data)
        local compDef = Components.FindComponent(templateName)
        assert(compDef, "Component template " .. tostring(templateName) .. " does not exist. Did you create a def in shared/Components ?")
        self.Components[templateName] = setmetatable(Lib.clone(require(compDef)), Component)
        return self.Components[templateName]
    end
}

return ECS