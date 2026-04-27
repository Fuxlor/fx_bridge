if Bridge.Detected.target ~= 'none' then return end

Bridge.Target = Bridge.Target or {}

local function noop(name)
    Bridge.Debug('Target not available — skipped: ' .. tostring(name))
end

function Bridge.Target.AddBoxZone(name, ...)      noop(name) end
function Bridge.Target.AddSphereZone(name, ...)   noop(name) end
function Bridge.Target.AddPolyZone(name, ...)     noop(name) end
function Bridge.Target.AddTargetEntity(...)       end
function Bridge.Target.AddTargetModel(...)        end
function Bridge.Target.RemoveZone(name)           noop(name) end
function Bridge.Target.RemoveTargetEntity(...)    end
