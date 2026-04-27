if Bridge.Detected.target ~= 'qb-target' then return end

Bridge.Target = Bridge.Target or {}

function Bridge.Target.AddBoxZone(name, coords, size, heading, options)
    exports['qb-target']:AddBoxZone(name, coords, size.x, size.y, {
        name    = name,
        heading = heading,
        minZ    = coords.z - size.z / 2,
        maxZ    = coords.z + size.z / 2,
    }, options)
end

function Bridge.Target.AddSphereZone(name, coords, radius, options)
    exports['qb-target']:AddCircleZone(name, coords, radius, { name = name }, options)
end

function Bridge.Target.AddPolyZone(name, points, options)
    exports['qb-target']:AddPolyZone(name, points, { name = name }, options)
end

function Bridge.Target.AddTargetEntity(entity, options)
    exports['qb-target']:AddTargetEntity(entity, { options = options })
end

function Bridge.Target.AddTargetModel(models, options)
    if type(models) == 'string' then models = { models } end
    exports['qb-target']:AddTargetModel(models, { options = options })
end

function Bridge.Target.RemoveZone(name)
    exports['qb-target']:RemoveZone(name)
end

function Bridge.Target.RemoveTargetEntity(entity)
    exports['qb-target']:RemoveTargetEntity(entity)
end
