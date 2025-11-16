-- tic_luarocks.lua
-- Offline install helper (design stub). Real installation is limited by TIC-80 sandbox:
--  * No io.* library loaded
--  * loadfile/dofile disabled
-- Therefore we cannot parse arbitrary rockspec or write files from inside the VM yet.
-- This stub documents the intended interface and fails gracefully.

local M = {}

-- Intended contract:
-- install_local(rockspec_path, source_root)
--   rockspec_path: string (path to pre-downloaded .rockspec inside sandbox root)
--   source_root: directory where module sources already unpacked.
-- Returns true/err.
-- Security rules (planned):
--   * Paths must be relative, no '..'
--   * Only .lua files copied
--   * Target under ./rocks/share/lua/5.4/
--   * Deny overwrite of existing non-Lua files
--   * Maintain simple manifest table for uninstall (future)

function M.install_local(rockspec_path, source_root)
  return nil, 'install_local not available: filesystem APIs disabled in TIC-80 Lua sandbox'
end

return M
