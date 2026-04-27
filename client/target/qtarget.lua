if Bridge.Detected.target ~= 'qtarget' then return end

Bridge.Target = Bridge.Target or {}

function Bridge.Target.AddBoxZone(name, coords, size, heading, options)
    exports['qtarget']:AddBoxZone(name, coords, size.x, size.y, {
        name    = name,
        heading = heading,
        minZ    = coords.z - size.z / 2,
        maxZ    = coords.z + size.z / 2,
    }, options)
end

function Bridge.Target.AddSphereZone(name, coords, radius, options)
    exports['qtarget']:AddCircleZone(name, coords, radius, { name = name }, options)
end

function Bridge.Target.AddPolyZone(name, points, options)
    exports['qtarget']:AddPolyZone(name, points, { name = name }, options)
end

function Bridge.Target.AddTargetEntity(entity, options)
    exports['qtarget']:AddTargetEntity(entity, { options = options })
end

function Bridge.Target.AddTargetModel(models, options)
    if type(models) == 'string' then models = { models } end
    exports['qtarget']:AddTargetModel(models, { options = options })
end

function Bridge.Target.RemoveZone(name)
    exports['qtarget']:RemoveZone(name)
end

function Bridge.Target.RemoveTargetEntity(entity)
    exports['qtarget']:RemoveTargetEntity(entity)
end
