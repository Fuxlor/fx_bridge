Bridge.Logger = {}

-- Discord embed colour presets
local COLORS = {
    info    = 3447003,   -- blue
    success = 3066993,   -- green
    warning = 16776960,  -- yellow
    error   = 15158332,  -- red
    default = 9807270,   -- grey
}

---Send a structured Discord webhook embed.
---@param category string  key in Config.Webhooks.categories
---@param data { title: string, description: string, fields?: table[], color?: string|integer, footer?: string }
function Bridge.Logger.Log(category, data)
    if not Config.Webhooks.enabled then return end

    local url = Config.Webhooks.categories[category] or Config.Webhooks.default
    if not url or url == '' then return end

    local color = data.color
    if type(color) == 'string' then
        color = COLORS[color] or COLORS.default
    end
    color = color or COLORS.default

    local embed = {
        title       = data.title or '',
        description = data.description or '',
        color       = color,
        fields      = data.fields or {},
        timestamp   = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer      = data.footer and { text = data.footer } or { text = 'fx_bridge' },
    }

    local payload = json.encode({
        username   = Config.Webhooks.username or 'FX Bundle',
        avatar_url = Config.Webhooks.avatar or nil,
        embeds     = { embed },
    })

    PerformHttpRequest(url, function(code, _, headers)
        if Config.Debug and code ~= 200 and code ~= 204 then
            print(('[fx_bridge] Webhook failed for category "%s": HTTP %d'):format(category, code))
        end
    end, 'POST', payload, { ['Content-Type'] = 'application/json' })
end
