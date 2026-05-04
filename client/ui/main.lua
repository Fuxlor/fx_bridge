-- Loaded last.
-- Contains: truly native helpers (DrawText3D, HelpText) shared by all notify modules,
-- the native progress bar implementation referenced by non-ox_lib modules,
-- and no-op stubs for any unimplemented function.

Bridge.UI = Bridge.UI or {}

-- ─── DrawText3D ──────────────────────────────────────────────────────────────

local drawActive = false
local drawData   = nil

function Bridge.UI.DrawText3D(x, y, z, text, scale)
    scale      = scale or 0.35
    drawActive = true
    drawData   = { x = x, y = y, z = z, text = text, scale = scale }
end

function Bridge.UI.StopDrawText3D()
    drawActive = false
    drawData   = nil
end

CreateThread(function()
    while true do
        Wait(0)
        if drawActive and drawData then
            local d = drawData
            SetTextScale(d.scale, d.scale)
            SetTextFont(0)
            SetTextProportional(true)
            SetTextColour(255, 255, 255, 215)
            SetTextEntry('STRING')
            SetTextCentre(true)
            AddTextComponentString(d.text)
            SetDrawOrigin(d.x, d.y, d.z, 0)
            DrawText(0.0, 0.0)
            ClearDrawOrigin()
        end
    end
end)

-- ─── Help text ───────────────────────────────────────────────────────────────

local helpText = nil

function Bridge.UI.ShowHelpText(text)
    helpText = text
end

function Bridge.UI.HideHelpText()
    helpText = nil
    ClearAllHelpMessages()
end

CreateThread(function()
    while true do
        if helpText then
            BeginTextCommandDisplayHelp('STRING')
            AddTextComponentSubstringPlayerName(helpText)
            EndTextCommandDisplayHelp(0, false, false, -1)
            Wait(0)
        else
            Wait(250)
        end
    end
end)

-- ─── Native progress bar (shared implementation) ─────────────────────────────

function Bridge.UI._NativeProgressBar(label, duration, canCancel, onFinish, onCancel)
    local startTime = GetGameTimer()
    local cancelled = false

    CreateThread(function()
        while GetGameTimer() - startTime < duration do
            Wait(0)
            local progress = (GetGameTimer() - startTime) / duration
            DrawRect(0.5, 0.95, 0.25, 0.025, 0, 0, 0, 180)
            DrawRect(0.5 - 0.125 + (0.25 * progress / 2), 0.95, 0.25 * progress, 0.025, 33, 160, 56, 220)
            if canCancel and IsControlJustPressed(0, 194) then
                cancelled = true
                break
            end
        end
        if cancelled and onCancel then onCancel()
        elseif not cancelled and onFinish then onFinish() end
    end)
end

-- ─── No-op stubs ─────────────────────────────────────────────────────────────

if not Bridge.UI.ShowTextUI then
    Bridge.UI.ShowTextUI = Bridge.UI.ShowHelpText
end

if not Bridge.UI.HideTextUI then
    Bridge.UI.HideTextUI = Bridge.UI.HideHelpText
end

local stubs = { 'Notify', 'ProgressBar' }
for _, fn in ipairs(stubs) do
    if not Bridge.UI[fn] then
        Bridge.UI[fn] = function()
            Bridge.Debug('Bridge.UI.' .. fn .. ' not implemented for notify: ' .. Bridge.Detected.notify)
        end
    end
end
