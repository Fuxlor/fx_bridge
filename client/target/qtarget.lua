if Bridge.Detected.target ~= 'qtarget' then return end

Bridge.Target = Bridge.Target or {}

function Bridge.Target.AddBoxZone(opts)
    exports['qtarget']:AddBoxZone(opts.name, opts.coords, opts.size.x, opts.size.y, {
        name    = opts.name,
        heading = opts.heading,
        minZ    = opts.coords.z - opts.size.z / 2,
        maxZ    = opts.coords.z + opts.size.z / 2,
    }, opts.options)
end

function Bridge.Target.AddSphereZone(opts)
    exports['qtarget']:AddCircleZone(opts.name, opts.coords, opts.radius, { name = opts.name, useZ = true }, opts.options)
end

function Bridge.Target.AddPolyZone(opts)
    exports['qtarget']:AddPolyZone(opts.name, opts.points, { name = opts.name }, opts.options)
end

function Bridge.Target.AddTargetEntity(opts)
    exports['qtarget']:AddTargetEntity(opts.entity, { options = opts.options })
end

function Bridge.Target.AddTargetModel(opts)
    local models = opts.models
    if type(models) == 'string' then models = { models } end
    exports['qtarget']:AddTargetModel(models, { options = opts.options })
end

function Bridge.Target.RemoveZone(name)
    exports['qtarget']:RemoveZone(name)
end

function Bridge.Target.RemoveTargetEntity(entity)
    exports['qtarget']:RemoveTargetEntity(entity)
end
