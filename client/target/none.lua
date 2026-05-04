if Bridge.Detected.target ~= 'none' then return end

Bridge.Target = Bridge.Target or {}

local function noop(name)
    Bridge.Debug('Target not available — skipped: ' .. tostring(name))
end

function Bridge.Target.AddBoxZone(opts)      noop(opts and opts.name) end
function Bridge.Target.AddSphereZone(opts)   noop(opts and opts.name) end
function Bridge.Target.AddPolyZone(opts)     noop(opts and opts.name) end
function Bridge.Target.AddTargetEntity(opts) end
function Bridge.Target.AddTargetModel(opts)  end
function Bridge.Target.RemoveZone(name)           noop(name) end
function Bridge.Target.RemoveTargetEntity(...)    end
