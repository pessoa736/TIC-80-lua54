-- luarocksdemo.lua
-- Demonstrates optional LuaRocks integration in this fork.
-- Place pure Lua rocks under ./rocks/share/lua/5.4/ (e.g., install with: luarocks install inspect --tree=./rocks)
-- If luarocks runtime modules are present, they will be auto-loaded; we also try manual require here safely.

local has_loader, _ = pcall(require, 'luarocks.loader') -- may succeed silently
local ok_inspect, inspect = pcall(require, 'inspect')

-- TIC() is the main loop called by the fantasy console.
function TIC()
    cls()
    if ok_inspect and inspect then
        print('LuaRocks: inspect loaded', 0, 0, 12)
        local sample = {a=1, b=2, nested={x=true, y=false}}
        local render = inspect(sample)
        print(render, 0, 8, 3)
    else
        print('LuaRocks module not found', 0, 0, 2)
        print('Install with: luarocks install inspect --tree=./rocks', 0, 8, 1)
    end
    if has_loader then
        print('luarocks.loader active', 0, 16, 11)
    else
        print('luarocks.loader missing (pure Lua only)', 0, 16, 5)
    end
end
