if Bridge.Detected.target ~= 'ox_target' then return end

Bridge.Target = Bridge.Target or {}

function Bridge.Target.AddBoxZone(name, coords, size, heading, options)
    exports.ox_target:addBoxZone({ name = name, coords = coords, size = size, heading = heading, options = options })
end

function Bridge.Target.AddSphereZone(name, coords, radius, options)
    exports.ox_target:addSphereZone({ name = name, coords = coords, radius = radius, options = options })
end

function Bridge.Target.AddPolyZone(name, points, options)
    exports.ox_target:addPolyZone({ name = name, points = points, options = options })
end

function Bridge.Target.AddTargetEntity(entity, options)
    exports.ox_target:addLocalEntity(entity, options)
end

function Bridge.Target.AddTargetModel(models, options)
    if type(models) == 'string' then models = { models } end
    exports.ox_target:addModel(models, options)
end

function Bridge.Target.RemoveZone(name)
    exports.ox_target:removeZone(name)
end

function Bridge.Target.RemoveTargetEntity(entity)
    exports.ox_target:removeLocalEntity(entity)
end
