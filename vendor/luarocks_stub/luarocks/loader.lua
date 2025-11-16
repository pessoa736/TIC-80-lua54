-- Minimal stub of luarocks.loader for TIC-80 sandbox.
-- Provides only enough to avoid errors when require('luarocks.loader') is called.
-- This is NOT the full LuaRocks runtime.
local loader = {}

-- mimic some globals usually configured by LuaRocks without exposing filesystem or network
loader.config = {
  lua_version = _VERSION,
  rocks_tree = './rocks',
}

-- no-op functions (placeholders)
function loader.path() return package.path end
function loader.cpath() return package.cpath end

-- mark common submodules as loaded with lightweight stubs to reduce further require attempts
package.loaded['luarocks.loader'] = loader
package.loaded['luarocks.core'] = { _VERSION = 'stub' }
package.loaded['luarocks.util'] = {}

return loader
