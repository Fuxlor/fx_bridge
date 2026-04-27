-- Loaded last. Validates interface, exposes top-level aliases, and defines Bridge.Jobs
-- (fully framework-agnostic: only reads .job / .gang from the standardised player wrapper).

local required = { 'GetPlayer', 'GetPlayerFromIdentifier', 'GetIdentifier', 'GetAllPlayers' }

for _, fn in ipairs(required) do
    if not Bridge.Framework[fn] then
        Bridge.Framework[fn] = function(...)
            Bridge.Debug('Bridge.Framework.' .. fn .. ' not implemented for: ' .. Bridge.Detected.framework)
            return nil
        end
    end
end

Bridge.GetPlayer               = Bridge.Framework.GetPlayer
Bridge.GetPlayerFromIdentifier = Bridge.Framework.GetPlayerFromIdentifier
Bridge.GetIdentifier           = Bridge.Framework.GetIdentifier
Bridge.GetAllPlayers           = Bridge.Framework.GetAllPlayers

-- ─── Jobs ────────────────────────────────────────────────────────────────────

Bridge.Jobs = {}

function Bridge.Jobs.GetJob(source)
    local player = Bridge.Framework.GetPlayer(source)
    return player and player.job or nil
end

function Bridge.Jobs.HasJob(source, jobName, minGrade)
    local job = Bridge.Jobs.GetJob(source)
    if not job or job.name ~= jobName then return false end
    return not minGrade or job.grade >= minGrade
end

function Bridge.Jobs.GetGang(source)
    local player = Bridge.Framework.GetPlayer(source)
    return player and player.gang or nil
end

function Bridge.Jobs.HasGang(source, gangName, minGrade)
    local gang = Bridge.Jobs.GetGang(source)
    if not gang or gang.name ~= gangName then return false end
    return not minGrade or gang.grade >= minGrade
end
