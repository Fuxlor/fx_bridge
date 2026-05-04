if Bridge.Detected.target ~= 'ox_target' then return end

Bridge.Target = Bridge.Target or {}

function Bridge.Target.AddBoxZone(opts)
    for _, opt in ipairs(opts.options) do
        opt.onSelect = opt.action
    end
    exports.ox_target:addBoxZone({ name = opts.name, coords = opts.coords, size = opts.size, heading = opts.heading, options = opts.options })
end

function Bridge.Target.AddSphereZone(opts)
    for _, opt in ipairs(opts.options) do
        opt.onSelect = opt.action
    end
    exports.ox_target:addSphereZone({ name = opts.name, coords = opts.coords, radius = opts.radius, onEnter = opts.onEnter, onExit = opts.onExit, options = opts.options })
end

function Bridge.Target.AddPolyZone(opts)
    for _, opt in ipairs(opts.options) do
        opt.onSelect = opt.action
    end
    exports.ox_target:addPolyZone({ name = opts.name, points = opts.points, options = opts.options })
end

function Bridge.Target.AddTargetEntity(opts)
    local opts = opts
    for _, opt in ipairs(opts.options) do
        opt.onSelect = opt.action
    end
    exports.ox_target:addLocalEntity(opts.entity, opts.options)
end

function Bridge.Target.AddTargetModel(opts)
    local models = opts.models
    if type(models) == 'string' then models = { models } end
    exports.ox_target:addModel(models, opts.options)
end

function Bridge.Target.RemoveZone(name)
    exports.ox_target:removeZone(name)
end

function Bridge.Target.RemoveTargetEntity(entity)
    exports.ox_target:removeLocalEntity(entity)
end
