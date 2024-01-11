---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Wait for {time} in milliseconds until {callback} returns `true`.
--- @param time any #(`integer`) Number of milliseconds to wait
--- @param callback any #(`fun(): boolean?`) Optional callback. Waits until
---                  {callback} returns true
--- @param interval any #(`integer?`) (Approximate) number of milliseconds to wait
---                  between polls
--- @param fast_only any #(`boolean?`) If true, only |api-fast| events will be
---                  processed.
--- @return any #(`boolean, -1|-2?`)
---     • If {callback} returns `true` during the {time}: `true, nil`
---     • If {callback} never returns `true` during the {time}: `false, -1`
---     • If {callback} is interrupted during the {time}: `false, -2`
---     • If {callback} errors, the error is raised.
function vim.wait(time, callback, interval, fast_only) end

-- Get or set window-scoped |options| for the window with handle {winid} and
-- buffer with number {bufnr}. Like `:setlocal` if {bufnr} is provided, like
-- `:set` otherwise. If [{winid}] is omitted then the current window is used.
-- Invalid {winid}, {bufnr} or key is an error.
function vim.wo() end

