--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Tell Nvim to resize a grid. Triggers a grid_resize event with
--                 the requested grid size or the maximum size if it exceeds size
--                 limits.
--
--                 On invalid grid handle, fails with error.
--
--                 Parameters: ~
--                     {grid}    The handle of the grid to be changed.
--                     {width}   The new requested width.
--                     {height}  The new requested height.
function vim.fn.nvim_ui_try_resize_grid(grid, width, height) end

-- The result is a Number, which is 1 when a file with the
-- 		name {file} exists, and can be written.  If {file} doesn't
-- 		exist, or is not writable, the result is 0.  If {file} is a
-- 		directory, and we can write to it, the result is 2.
function vim.fn.filewritable(file) end

-- Calls many API methods atomically.
--
--                 This has two main usages:
--                 1. To perform several requests from an async context
--                    atomically, i.e. without interleaving redraws, RPC requests
--                    from other clients, or user interactions (however API
--                    methods may trigger autocommands or event processing which
--                    have such side-effects, e.g. |:sleep| may wake timers).
--                 2. To minimize RPC overhead (roundtrips) of a sequence of many
--                    requests.
--
--                 Parameters: ~
--                     {calls}  an array of calls, where each call is described
--                              by an array with two elements: the request name,
--                              and an array of arguments.
--
--                 Return: ~
--                     Array of two elements. The first is an array of return
--                     values. The second is NIL if all calls succeeded. If a
--                     call resulted in an error, it is a three-element array
--                     with the zero-based index of the call which resulted in an
--                     error, the error type and the error message. If an error
--                     occurred, the values from all preceding calls will still
--                     be returned.
function vim.fn.nvim_call_atomic(calls) end

-- Return a |Channel| that is null. Only useful for testing.
-- 		{only available when compiled with the +channel feature}
function vim.fn.test_null_channel() end

-- associated with window {nr}.  {nr} can be the window number or
-- 		the |window-ID|.
-- 		When {nr} is zero, the number of the buffer in the current
-- 		window is returned.
-- 		When window {nr} doesn't exist, -1 is returned.
-- 		Example: >
--   :echo "The file in the current window is " . bufname(winbufnr(0))
-- <
function vim.fn.winbufnr(nr) end

-- Clear {history}, i.e. delete all its entries.  See |hist-names|
-- 		for the possible values of {history}.
--
-- 		If the parameter {item} evaluates to a String, it is used as a
-- 		regular expression.  All entries matching that expression will
-- 		be removed from the history (if there are any).
-- 		Upper/lowercase must match, unless "\c" is used |/\c|.
-- 		If {item} evaluates to a Number, it will be interpreted as
-- 		an index, see |:history-indexing|.  The respective entry will
-- 		be removed if it exists.
--
-- 		The result is a Number: 1 for a successful operation,
-- 		otherwise 0 is returned.
--
-- 		Examples:
-- 		Clear expression register history: >
-- 			:call histdel("expr")
-- <
-- 		Remove all entries starting with "*" from the search history: >
-- 			:call histdel("/", '^\*')
-- <
-- 		The following three are equivalent: >
-- 			:call histdel("search", histnr("search"))
-- 			:call histdel("search", -1)
-- 			:call histdel("search", '^'.histget("search", -1).'$')
-- <
-- 		To delete the last search pattern and use the last-but-one for
-- 		the "n" command and 'hlsearch': >
-- 			:call histdel("search", -1)
-- 			:let @/ = histget("search", -1)
function vim.fn.histdel(history, item) end

