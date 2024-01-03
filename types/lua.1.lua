---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Get or set window-scoped |options| for the window with handle {winid} and
-- buffer with number {bufnr}. Like `:setlocal` if {bufnr} is provided, like
-- `:set` otherwise. If [{winid}] is omitted then the current window is used.
-- Invalid {winid}, {bufnr} or key is an error.
function vim.wo() end

