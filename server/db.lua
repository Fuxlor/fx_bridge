Bridge.DB = {}

-- All methods are thin wrappers around oxmysql that enforce Await usage and
-- give the rest of the bundle a consistent API regardless of oxmysql version.

---Execute a SELECT query, returns array of row tables.
---@param query string
---@param params? table
---@return table[]
function Bridge.DB.Query(query, params)
    return MySQL.query.await(query, params or {})
end

---Execute an INSERT, returns the new auto-increment id.
---@param query string
---@param params? table
---@return integer
function Bridge.DB.Insert(query, params)
    return MySQL.insert.await(query, params or {})
end

---Execute an UPDATE/DELETE, returns affected row count.
---@param query string
---@param params? table
---@return integer
function Bridge.DB.Update(query, params)
    return MySQL.update.await(query, params or {})
end

---SELECT returning only the first row.
---@param query string
---@param params? table
---@return table|nil
function Bridge.DB.Single(query, params)
    return MySQL.single.await(query, params or {})
end

---SELECT returning only the first column of the first row.
---@param query string
---@param params? table
---@return any
function Bridge.DB.Scalar(query, params)
    return MySQL.scalar.await(query, params or {})
end

---Prepare a named statement (oxmysql prepare).
---@param name string
---@param query string
function Bridge.DB.Prepare(name, query)
    MySQL.prepare(name, query)
end

---Run all SQL files in a migration list at resource start.
---Files are executed in order; errors are printed and do not crash the resource.
---@param migrations string[]  list of SQL file paths relative to the resource root
---@param resourceName string
function Bridge.DB.Migrate(migrations, resourceName)
    for _, path in ipairs(migrations) do
        local file = LoadResourceFile(resourceName, path)
        if file then
            -- Split on semicolons to handle multi-statement files
            for statement in file:gmatch('([^;]+)') do
                statement = statement:match('^%s*(.-)%s*$')
                if statement ~= '' then
                    local ok, err = pcall(MySQL.update.await, statement, {})
                    if not ok and Config.Debug then
                        print(('[fx_bridge] Migration error in %s: %s'):format(path, err))
                    end
                end
            end
            Bridge.Debug(('Migration applied: %s'):format(path))
        else
            print(('[fx_bridge] WARNING: Migration file not found: %s/%s'):format(resourceName, path))
        end
    end
end
