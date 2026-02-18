-- verify_refactor.lua
local lsp_plugins_path = "/Users/emranhossain/.config/nvim/lsp"
local handle = vim.loop.fs_scandir(lsp_plugins_path)

local servers = {}
if handle then
    while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        if type == "file" and name:match("%.lua$") then
            local server_name = name:gsub("%.lua$", "")
            table.insert(servers, server_name)
        end
    end
else
    print("Error: Could not scan directory " .. lsp_plugins_path)
end

print("\n--- Found Servers ---")
for _, s in ipairs(servers) do
    print("- " .. s)
end

print("\n--- Loading Configs ---")
for _, name in ipairs(servers) do
    local config_path = lsp_plugins_path .. "/" .. name .. ".lua"
    local status, config = pcall(dofile, config_path)
    if status then
        print(string.format("SUCCESS: Loaded %s.lua", name))
        -- specialized validation for pylsp
        if name == "pylsp" then
             local max_len = config.settings.pylsp.plugins.pycodestyle.maxLineLength
             print("  [pylsp check] maxLineLength = " .. tostring(max_len))
        end
        -- specialized validation for ruff
        if name == "ruff" then
             local len = config.settings["line-length"]
             print("  [ruff check] line-length = " .. tostring(len))
        end
        -- specialized validation for ltex
        if name == "ltex" then
             local freq = config.settings.ltex.checkFrequency
             print("  [ltex check] checkFrequency = " .. tostring(freq))
        end
    else
        print(string.format("ERROR: Failed to load %s.lua: %s", name, config))
    end
end
