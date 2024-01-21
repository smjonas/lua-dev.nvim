---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Gets the distance (in bytes) from the starting byte of the codepoint
-- (character) that {index} points to.
--- @param str any #(`string`)
--- @param index any #(`number`)
--- @return any #(`number`)
function vim.str_utf_start(str, index) end

-- Convert byte index to UTF-32 and UTF-16 indices. If {index} is not
-- supplied, the length of the string is used. All indices are zero-based.
--- @param str any #(`string`)
--- @param index any #(`number?`)
--- @return any #(`integer`) UTF-32 index
--- @return any #(`integer`) UTF-16 index
function vim.str_utfindex(str, index) end

-- Compares strings case-insensitively.
--- @param a any #(`string`)
--- @param b any #(`string`)
--- @return any #(`0|1|-1`) if strings are equal, {a} is greater than {b} or {a} is
---     lesser than {b}, respectively.
function vim.stricmp(a, b) end

-- Runs a system command or throws an error if {cmd} cannot be run.
--- @param cmd any #(`string[]`) Command to execute
--- @param opts any #(`vim.SystemOpts?`) Options:
---                • cwd: (string) Set the current working directory for the
---                  sub-process.
---                • env: table<string,string> Set environment variables for
---                  the new process. Inherits the current environment with
---                  `NVIM` set to |v:servername|.
---                • clear_env: (boolean) `env` defines the job environment
---                  exactly, instead of merging current environment.
---                • stdin: (string|string[]|boolean) If `true`, then a pipe
---                  to stdin is opened and can be written to via the
---                  `write()` method to SystemObj. If string or string[] then
---                  will be written to stdin and closed. Defaults to `false`.
---                • stdout: (boolean|function) Handle output from stdout.
---                  When passed as a function must have the signature
---                  `fun(err: string, data: string)`. Defaults to `true`
---                • stderr: (boolean|function) Handle output from stderr.
---                  When passed as a function must have the signature
---                  `fun(err: string, data: string)`. Defaults to `true`.
---                • text: (boolean) Handle stdout and stderr as text.
---                  Replaces `\r\n` with `\n`.
---                • timeout: (integer) Run the command with a time limit.
---                  Upon timeout the process is sent the TERM signal (15) and
---                  the exit code is set to 124.
---                • detach: (boolean) If true, spawn the child process in a
---                  detached state - this will make it a process group
---                  leader, and will effectively enable the child to keep
---                  running after the parent exits. Note that the child
---                  process will still keep the parent's event loop alive
---                  unless the parent process calls |uv.unref()| on the
---                  child's process handle.
--- @param on_exit any #(`fun(out: vim.SystemCompleted)?`) Called when subprocess
---                exits. When provided, the command runs asynchronously.
---                Receives SystemCompleted object, see return of
---                SystemObj:wait().
--- @return any #(`vim.SystemObj`) Object with the fields:
---     • pid (integer) Process ID
---     • wait (fun(timeout: integer|nil): SystemCompleted) Wait for the
---       process to complete. Upon timeout the process is sent the KILL
---       signal (9) and the exit code is set to 124. Cannot be called in
---       |api-fast|.
---       • SystemCompleted is an object with the fields:
---         • code: (integer)
---         • signal: (integer)
---         • stdout: (string), nil if stdout argument is passed
---         • stderr: (string), nil if stderr argument is passed
---
---
---     • kill (fun(signal: integer|string))
---     • write (fun(data: string|nil)) Requires `stdin=true`. Pass `nil` to
---       close the stream.
---     • is_closing (fun(): boolean)
function vim.system(cmd, opts, on_exit) end

-- Add the reverse lookup values to an existing table. For example:
-- `tbl_add_reverse_lookup { A = 1 } == { [1] = 'A', A = 1 }`
--- @param o any #(`table`) Table to add the reverse to
--- @return any #(`table`) o
function vim.tbl_add_reverse_lookup(o) end

-- Checks if a table contains a given value, specified either directly or via
-- a predicate that is checked for each value.
--- @param t any #(`table`) Table to check
--- @param value any #(`any`) Value to compare or predicate function reference
--- @param opts any #(`table?`) Keyword arguments |kwargs|:
---              • predicate: (boolean) `value` is a function reference to be
---                checked (default false)
--- @return any #(`boolean`) `true` if `t` contains `value`
function vim.tbl_contains(t, value, opts) end

-- Counts the number of non-nil values in table `t`.
--- @param t any #(`table`) Table
--- @return any #(`integer`) Number of non-nil values in table
function vim.tbl_count(t) end

-- Merges recursively two or more tables.
--- @param behavior any #(`string`) Decides what to do if a key is found in more
---                 than one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #(`table`) Two or more tables
--- @return any #(`table`) Merged table
function vim.tbl_deep_extend(behavior, ...) end

-- Merges two or more tables.
--- @param behavior any #(`string`) Decides what to do if a key is found in more
---                 than one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #(`table`) Two or more tables
--- @return any #(`table`) Merged table
function vim.tbl_extend(behavior, ...) end

-- Filter a table using a predicate function
--- @param func any #(`function`) Function
--- @param t any #(`table`) Table
--- @return any #(`table`) Table of filtered values
function vim.tbl_filter(func, t) end

-- Creates a copy of a list-like table such that any nested tables are
-- "unrolled" and appended to the result.
--- @param t any #(`table`) List-like table
--- @return any #(`table`) Flattened copy of the given list-like table
function vim.tbl_flatten(t) end

-- Index into a table (first argument) via string keys passed as subsequent
-- arguments. Return `nil` if the key does not exist.
--- @param o any #(`table`) Table to index
--- @vararg any #(`any`) Optional keys (0 or more, variadic) via which to index
---            the table
--- @return any #(`any`) Nested value indexed by key (if it exists), else nil
function vim.tbl_get(o, ...) end

-- Tests if `t` is an "array": a table indexed only by integers (potentially
-- non-contiguous).
--- @param t any #(`table`)
--- @return any #(`boolean`) `true` if array-like table, else `false`.
function vim.tbl_isarray(t) end

-- Checks if a table is empty.
--- @param t any #(`table`) Table to check
--- @return any #(`boolean`) `true` if `t` is empty
function vim.tbl_isempty(t) end

-- Tests if `t` is a "list": a table indexed only by contiguous integers
-- starting from 1 (what |lua-length| calls a "regular array").
--- @param t any #(`table`)
--- @return any #(`boolean`) `true` if list-like table, else `false`.
function vim.tbl_islist(t) end

-- Return a list of all keys used in a table. However, the order of the
-- return table of keys is not guaranteed.
--- @param t any #(`table`) Table
--- @return any #(`list`) List of keys
function vim.tbl_keys(t) end

-- Apply a function to all values of a table.
--- @param func any #(`function`) Function
--- @param t any #(`table`) Table
--- @return any #(`table`) Table of transformed values
function vim.tbl_map(func, t) end

-- Return a list of all values used in a table. However, the order of the
-- return table of values is not guaranteed.
--- @param t any #(`table`) Table
--- @return any #(`list`) List of values
function vim.tbl_values(t) end

-- Parses a raw glob into an |lua-lpeg| pattern.
--- @param pattern any #(`string`) The raw glob pattern
--- @return any #(`vim.lpeg.Pattern`) pattern An |lua-lpeg| representation of the
---     pattern
function vim.to_lpeg(pattern) end

-- Collects an |iterable| into a table.
--- @param f any #(`function`) Iterator function
--- @return any #(`table`)
function vim.totable(f, ...) end

-- Trim whitespace (Lua pattern "%s") from both sides of a string.
--- @param s any #(`string`) String to trim
--- @return any #(`string`) String with whitespace removed from its beginning and end
function vim.trim(s) end

-- Manage the trust database.
--- @param opts any #(`table`)
---             • action (string): "allow" to add a file to the trust database
---               and trust it, "deny" to add a file to the trust database and
---               deny it, "remove" to remove file from the trust database
---             • path (string|nil): Path to a file to update. Mutually
---               exclusive with {bufnr}. Cannot be used when {action} is
---               "allow".
---             • bufnr (number|nil): Buffer number to update. Mutually
---               exclusive with {path}.
--- @return any #(`boolean`) success true if operation was successful
--- @return any #(`string`) msg full path if operation was successful, else error
---     message
function vim.trust(opts) end

-- Returns the string `"pattern"` if the given value is a pattern, otherwise
-- `nil`.
--- @return any #(`"pattern"?`)
function vim.type(value) end

-- Attach to ui events, similar to |nvim_ui_attach()| but receive events as
-- Lua callback. Can be used to implement screen elements like popupmenu or
-- message handling in Lua.
--- @param ns any #(`integer`)
--- @param options any #(`table<string, any>`)
--- @param callback any #(`fun()`)
function vim.ui_attach(ns, options, callback) end

-- Detach a callback previously attached with |vim.ui_attach()| for the given
-- namespace {ns}.
--- @param ns any #(`integer`)
function vim.ui_detach(ns) end

-- Validates a parameter specification (types and values).
--- @param opt any #(`table`) Names of parameters to validate. Each key is a
---            parameter name; each value is a tuple in one of these forms:
---            1. (arg_value, type_name, optional)
---               • arg_value: argument value
---               • type_name: string|table type name, one of: ("table", "t",
---                 "string", "s", "number", "n", "boolean", "b", "function",
---                 "f", "nil", "thread", "userdata") or list of them.
---               • optional: (optional) boolean, if true, `nil` is valid
---
---            2. (arg_value, fn, msg)
---               • arg_value: argument value
---               • fn: any function accepting one argument, returns true if
---                 and only if the argument is valid. Can optionally return
---                 an additional informative error message as the second
---                 returned value.
---               • msg: (optional) error string if validation fails
function vim.validate(opt) end

-- Returns a string with the running version of LPeg.
--- @return any #(`string`)
function vim.version() end

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

