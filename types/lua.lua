---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Add new filetype mappings.
--- @param filetypes any #(table) A table containing new filetype maps (see
---                  example).
function vim.add(filetypes) end

-- Return the basename of the given file or directory
--- @param file any #(string) File or directory
--- @return any #(string) Basename of {file}
function vim.basename(file) end

-- Execute Vim script commands.
--- @param command any #string|table Command(s) to execute. If a string, executes
---                multiple lines of Vim script at once. In this case, it is
---                an alias to |nvim_exec()|, where `output` is set to false.
---                Thus it works identical to |:source|. If a table, executes
---                a single command. In this case, it is an alias to
---                |nvim_cmd()| where `opts` is empty.
function vim.cmd(command) end

-- Compares two strings ( `v1` and `v2` ) in semver format.
--- @param v1 any #(string) Version.
--- @param v2 any #(string) Version to compare with v1.
--- @param opts any #(table|nil) Optional keyword arguments:
---             • strict (boolean): see `semver.parse` for details. Defaults
---               to false.
--- @return any #(integer) `-1` if `v1 < v2`, `0` if `v1 == v2`, `1` if `v1 > v2`.
function vim.cmp(v1, v2, opts) end

function vim.connection_failure_errmsg(consequence) end

-- Deep compare values for equality
--- @param a any #any First value
--- @param b any #any Second value
--- @return any #(boolean) `true` if values are equals, else `false`
function vim.deep_equal(a, b) end

-- Returns a deep copy of the given object. Non-table objects are copied as
-- in a typical Lua assignment, whereas table objects are copied recursively.
-- Functions are naively copied, so functions in the copied table point to
-- the same functions as those in the input table. Userdata and threads are
-- not copied and will throw an error.
--- @param orig any #(table) Table to copy
--- @return any #(table) Table of copied keys and (nested) values.
function vim.deepcopy(orig) end

-- Creates a table whose members are automatically created when accessed, if
-- they don't already exist.
--- @param create any #(function|nil) The function called to create a missing
---               value.
--- @return any #(table) Empty table with metamethod
function vim.defaulttable(create) end

-- Defers calling `fn` until `timeout` ms passes.
--- @param fn fun(...) #(function) Callback to call once `timeout` expires
--- @param timeout any #(integer) Number of milliseconds to wait before calling
---                `fn`
--- @return any #(table) timer luv timer object
function vim.defer_fn(fn, timeout) end

-- Remove an existing mapping. Examples: >lua
--
--    vim.keymap.del('n', 'lhs')
--
--    vim.keymap.del({'n', 'i', 'v'}, '<leader>w', { buffer = 5 })
--
-- <
--- @param opts any #(table|nil) A table of optional arguments:
---             • buffer: (number or boolean) Remove a mapping from the given
---               buffer. When "true" or 0, use the current buffer.
function vim.del(modes, lhs, opts) end

-- Display a deprecation notification to the user.
--- @param name any #string Deprecated function.
--- @param alternative any #(string|nil) Preferred alternative function.
--- @param version any #string Version in which the deprecated function will be
---                    removed.
--- @param plugin any #string|nil Plugin name that the function will be
---                    removed from. Defaults to "Nvim".
--- @param backtrace any #boolean|nil Prints backtrace. Defaults to true.
function vim.deprecate(name, alternative, version, plugin, backtrace) end

-- Return an iterator over the files and directories located in {path}
--- @param path any #(string) An absolute or relative path to the directory to
---             iterate over. The path is first normalized
---             |vim.fs.normalize()|.
--- @param opts any #table|nil Optional keyword arguments:
---             • depth: integer|nil How deep the traverse (default 1)
---             • skip: (fun(dir_name: string): boolean)|nil Predicate to
---               control traversal. Return false to stop searching the
---               current directory. Only useful when depth > 1
--- @return any #Iterator over files and directories in {path}. Each iteration yields
---     two values: name and type. Each "name" is the basename of the file or
---     directory relative to {path}. Type is one of "file" or "directory".
function vim.dir(path, opts) end

-- Return the parent directory of the given file or directory
--- @param file any #(string) File or directory
--- @return any #(string) Parent directory of {file}
function vim.dirname(file) end

-- Tests if `s` ends with `suffix`.
--- @param s any #(string) String
--- @param suffix any #(string) Suffix to match
--- @return any #(boolean) `true` if `suffix` is a suffix of `s`
function vim.endswith(s, suffix) end

-- Returns `true` if `v1` are `v2` are equal versions.
--- @param v1 any #(string)
--- @param v2 any #(string)
--- @return any #(boolean)
function vim.eq(v1, v2) end

-- Find files or directories in the given path.
--- @param names any #(string|table|fun(name: string, path: string): boolean) Names
---              of the files and directories to find. Must be base names,
---              paths and globs are not supported when {names} is a string or
---              a table. If {names} is a function, it is called for each
---              traversed file and directory with args:
---              • name: base name of the current item
---              • path: full path of the current item The function should
---                return `true` if the given file or directory is considered
---                a match.
--- @param opts any #(table) Optional keyword arguments:
---              • path (string): Path to begin searching from. If omitted,
---                the |current-directory| is used.
---              • upward (boolean, default false): If true, search upward
---                through parent directories. Otherwise, search through child
---                directories (recursively).
---              • stop (string): Stop searching when this directory is
---                reached. The directory itself is not searched.
---              • type (string): Find only files ("file") or directories
---                ("directory"). If omitted, both files and directories that
---                match {names} are included.
---              • limit (number, default 1): Stop the search after finding
---                this many matches. Use `math.huge` to place no limit on the
---                number of matches.
--- @return any #(table) Normalized paths |vim.fs.normalize()| of all matching files or
---     directories
function vim.find(names, opts) end

-- Splits a string at each instance of a separator.
--- @param s any #(string) String to split
--- @param sep any #(string) Separator or pattern
--- @param plain any #(boolean|nil) If `true` use `sep` literally (passed to
---              string.find)
--- @return any #(function) Iterator over the split components
function vim.gsplit(s, sep, plain) end

-- Returns `true` if `v1` is greater than `v2` .
--- @param v1 any #(string)
--- @param v2 any #(string)
--- @return any #(boolean)
function vim.gt(v1, v2) end

-- Prompts the user for input, allowing arbitrary (potentially asynchronous)
-- work until `on_confirm`.
--- @param opts any #(table) Additional options. See |input()|
---                   • prompt (string|nil) Text of the prompt
---                   • default (string|nil) Default reply to the input
---                   • completion (string|nil) Specifies type of completion
---                     supported for input. Supported types are the same that
---                     can be supplied to a user-defined command using the
---                     "-complete=" argument. See |:command-completion|
---                   • highlight (function) Function that will be used for
---                     highlighting user inputs.
--- @param on_confirm any #(function) ((input|nil) -> ()) Called once the user
---                   confirms or abort the input. `input` is what the user
---                   typed (it might be an empty string if nothing was
---                   entered), or `nil` if the user aborted the dialog.
function vim.input(opts, on_confirm) end

-- Get all the items at a given buffer position.
--- @param bufnr any #(integer|nil) defaults to the current buffer
--- @param row any #(integer|nil) row to inspect, 0-based. Defaults to the row
---               of the current cursor
--- @param col any #(integer|nil) col to inspect, 0-based. Defaults to the col
---               of the current cursor
--- @param filter any #(table|nil) a table with key-value pairs to filter the items
---               • syntax (boolean): include syntax based highlight groups
---                 (defaults to true)
---               • treesitter (boolean): include treesitter based highlight
---                 groups (defaults to true)
---               • extmarks (boolean|"all"): include extmarks. When `all`,
---                 then extmarks without a `hl_group` will also be included
---                 (defaults to true)
---               • semantic_tokens (boolean): include semantic tokens
---                 (defaults to true)
--- @return any #(table) a table with the following key-value pairs. Items are in
---     "traversal order":
---     • treesitter: a list of treesitter captures
---     • syntax: a list of syntax groups
---     • semantic_tokens: a list of semantic tokens
---     • extmarks: a list of extmarks
---     • buffer: the buffer used to get the items
---     • row: the row used to get the items
---     • col: the col used to get the items
function vim.inspect_pos(bufnr, row, col, filter) end

-- Returns true if object `f` can be called as a function.
--- @param f any #any Any object
--- @return any #(boolean) `true` if `f` is callable, else `false`
function vim.is_callable(f) end

-- Extends a list-like table with the values of another list-like table.
--- @param dst any #(table) List which will be modified and appended to
--- @param src any #(table) List from which values will be inserted
--- @param start any #(integer|nil) Start index on src. Defaults to 1
--- @param finish any #(integer|nil) Final index on src. Defaults to `#src`
--- @return any #(table) dst
function vim.list_extend(dst, src, start, finish) end

-- Creates a copy of a table containing only elements from start to end
-- (inclusive)
--- @param list any[] #(list) Table
--- @param start any #(integer|nil) Start range of slice
--- @param finish any #(integer|nil) End range of slice
--- @return any #(list) Copy of table sliced from start to finish (inclusive)
function vim.list_slice(list, start, finish) end

-- Returns `true` if `v1` is less than `v2` .
--- @param v1 any #(string)
--- @param v2 any #(string)
--- @return any #(boolean)
function vim.lt(v1, v2) end

-- Omnifunc for completing lua values from from the runtime lua interpreter,
-- similar to the builtin completion for the `:lua` command.
function vim.lua_omnifunc(find_start, _) end

-- Perform filetype detection.
--- @param args any[] #(table) Table specifying which matching strategy to use.
---             Accepted keys are:
---             • buf (number): Buffer number to use for matching. Mutually
---               exclusive with {contents}
---             • filename (string): Filename to use for matching. When {buf}
---               is given, defaults to the filename of the given buffer
---               number. The file need not actually exist in the filesystem.
---               When used without {buf} only the name of the file is used
---               for filetype matching. This may result in failure to detect
---               the filetype in cases where the filename alone is not enough
---               to disambiguate the filetype.
---             • contents (table): An array of lines representing file
---               contents to use for matching. Can be used with {filename}.
---               Mutually exclusive with {buf}.
--- @return any #(string|nil) If a match was found, the matched filetype.
--- @return any #(function|nil) A function that modifies buffer state when called (for
---     example, to set some filetype specific buffer variables). The function
---     accepts a buffer number as its only argument.
function vim.match(args) end

-- Normalize a path to a standard format. A tilde (~) character at the
-- beginning of the path is expanded to the user's home directory and any
-- backslash (\) characters are converted to forward slashes (/). Environment
-- variables are also expanded.
--- @param path any #(string) Path to normalize
--- @return any #(string) Normalized path
function vim.normalize(path) end

-- Display a notification to the user.
--- @param msg any #(string) Content of the notification to show to the user.
--- @param level any #(integer|nil) One of the values from |vim.log.levels|.
--- @param opts any #(table|nil) Optional parameters. Unused by default.
function vim.notify(msg, level, opts) end

-- Display a notification only one time.
--- @param msg any #(string) Content of the notification to show to the user.
--- @param level any #(integer|nil) One of the values from |vim.log.levels|.
--- @param opts any #(table|nil) Optional parameters. Unused by default.
--- @return any #(boolean) true if message was displayed, else false
function vim.notify_once(msg, level, opts) end

-- Adds Lua function {fn} with namespace id {ns_id} as a listener to every,
-- yes every, input key.
--- @param fn fun(...) #(function) Callback function. It should take one string
---              argument. On each key press, Nvim passes the key char to
---              fn(). |i_CTRL-V| If {fn} is nil, it removes the callback for
---              the associated {ns_id}
--- @param ns_id any #integer? Namespace ID. If nil or 0, generates and returns a
---              new |nvim_create_namespace()| id.
--- @return any #(integer) Namespace id associated with {fn}. Or count of all callbacks
---     if on_key() is called without arguments.
--- @return any #
--- Note:
---     {fn} will be removed if an error occurs while calling.
function vim.on_key(fn, ns_id) end

-- Iterate over all the parents of the given file or directory.
--- @param start any #(string) Initial file or directory.
--- @return any #(function) Iterator
function vim.parents(start) end

-- Parses a semantic version string.
--- @param version any #(string) Version string to be parsed.
--- @param opts any #(table|nil) Optional keyword arguments:
---                • strict (boolean): Default false. If `true` , no coercion is attempted on input not strictly
---                  conforming to semver v2.0.0 ( https://semver.org/spec/v2.0.0.html ). E.g. `parse("v1.2")` returns nil.
--- @return any #(table|nil) parsed_version Parsed version table or `nil` if `version`
---     is invalid.
function vim.parse(version, opts) end

-- Paste handler, invoked by |nvim_paste()| when a conforming UI (such as the
-- |TUI|) pastes text into the editor.
--- @param lines any #string[] # |readfile()|-style list of lines to paste.
---              |channel-lines|
--- @param phase any #paste_phase -1: "non-streaming" paste: the call contains all
---              lines. If paste is "streamed", `phase` indicates the stream state:
---              • 1: starts the paste (exactly once)
---              • 2: continues the paste (zero or more times)
---              • 3: ends the paste (exactly once)
--- @return any #(boolean) # false if client should cancel the paste.
function vim.paste(lines, phase) end

-- Escapes magic chars in |lua-patterns|.
--- @param s any #(string) String to escape
--- @return any #(string) %-escaped pattern string
function vim.pesc(s) end

-- "Pretty prints" the given arguments and returns them unmodified.
--- @return any #any # given arguments.
function vim.print(...) end

-- Attempt to read the file at {path} prompting the user if the file should
-- be trusted. The user's choice is persisted in a trust database at
-- $XDG_STATE_HOME/nvim/trust.
--- @param path any #(string) Path to a file to read.
--- @return any #(string|nil) The contents of the given file if it exists and is
---     trusted, or nil otherwise.
function vim.read(path) end

-- Get a table of lines with start, end columns for a region marked by two
-- points
--- @param bufnr any #(integer) number of buffer
--- @param pos1 any #integer[] (line, column) tuple marking beginning of
---                  region
--- @param pos2 any #integer[] (line, column) tuple marking end of region
--- @param regtype any #(string) type of selection, see |setreg()|
--- @param inclusive any #(boolean) indicating whether the selection is
---                  end-inclusive
--- @return any #(table) region Table of the form `{linenr = {startcol,endcol}}`
function vim.region(bufnr, pos1, pos2, regtype, inclusive) end

-- Defers callback `cb` until the Nvim API is safe to call.
--- @param cb any #(function)
--- @return any #(function)
function vim.schedule_wrap(cb) end

-- Prompts the user to pick from a list of items, allowing arbitrary
-- (potentially asynchronous) work until `on_choice`.
--- @param items any #(table) Arbitrary items
--- @param opts any #(table) Additional options
---                  • prompt (string|nil) Text of the prompt. Defaults to
---                    `Select one of:`
---                  • format_item (function item -> text) Function to format
---                    an individual item from `items`. Defaults to
---                    `tostring`.
---                  • kind (string|nil) Arbitrary hint string indicating the
---                    item shape. Plugins reimplementing `vim.ui.select` may
---                    wish to use this to infer the structure or semantics of
---                    `items`, or the context in which select() was called.
--- @param on_choice any #(function) ((item|nil, idx|nil) -> ()) Called once the
---                  user made a choice. `idx` is the 1-based index of `item`
---                  within `items`. `nil` if the user aborted the dialog.
function vim.select(items, opts, on_choice) end

-- Adds a new |mapping|. Examples: >lua
--
--    -- Map to a Lua function:
--    vim.keymap.set('n', 'lhs', function() print("real lua function") end)
--    -- Map to multiple modes:
--    vim.keymap.set({'n', 'v'}, '<leader>lr', vim.lsp.buf.references, { buffer=true })
--    -- Buffer-local mapping:
--    vim.keymap.set('n', '<leader>w', "<cmd>w<cr>", { silent = true, buffer = 5 })
--    -- Expr mapping:
--    vim.keymap.set('i', '<Tab>', function()
--      return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
--    end, { expr = true })
--    -- <Plug> mapping:
--    vim.keymap.set('n', '[%', '<Plug>(MatchitNormalMultiBackward)')
--
-- <
--- @param mode any #string|table Mode short-name, see |nvim_set_keymap()|. Can
---             also be list of modes to create mapping on multiple modes.
--- @param lhs any #(string) Left-hand side |{lhs}| of the mapping.
--- @param rhs any #string|function Right-hand side |{rhs}| of the mapping, can be
---             a Lua function.
--- @param opts any #(table|nil) Table of |:map-arguments|.
---             • Same as |nvim_set_keymap()| {opts}, except:
---               • "replace_keycodes" defaults to `true` if "expr" is `true`.
---               • "noremap": inverse of "remap" (see below).
---
---             • Also accepts:
---               • "buffer" number|boolean Creates buffer-local mapping, `0`
---                 or `true` for current buffer.
---               • remap: (boolean) Make the mapping recursive. Inverses
---                 "noremap". Defaults to `false`.
function vim.set(mode, lhs, rhs, opts) end

-- Show all the items at a given buffer position.
--- @param bufnr any #(integer|nil) defaults to the current buffer
--- @param row any #(integer|nil) row to inspect, 0-based. Defaults to the row
---               of the current cursor
--- @param col any #(integer|nil) col to inspect, 0-based. Defaults to the col
---               of the current cursor
--- @param filter any #(table|nil) see |vim.inspect_pos()|
function vim.show_pos(bufnr, row, col, filter) end

-- Enumerate a table sorted by its keys.
--- @param t any #(table) List-like table
--- @return any #iterator over sorted keys and their values
function vim.spairs(t) end

-- Splits a string at each instance of a separator.
--- @param s any #(string) String to split
--- @param sep any #(string) Separator or pattern
--- @param kwargs any #(table|nil) Keyword arguments:
---               • plain: (boolean) If `true` use `sep` literally (passed to
---                 string.find)
---               • trimempty: (boolean) If `true` remove empty items from the
---                 front and back of the list
--- @return any #string[] List of split components
function vim.split(s, sep, kwargs) end

-- Tests if `s` starts with `prefix`.
--- @param s any #(string) String
--- @param prefix any #(string) Prefix to match
--- @return any #(boolean) `true` if `prefix` is a prefix of `s`
function vim.startswith(s, prefix) end

-- Add the reverse lookup values to an existing table. For example:
-- `tbl_add_reverse_lookup { A = 1 } == { [1] = 'A', A = 1 }`
--- @param o any #(table) Table to add the reverse to
--- @return any #(table) o
function vim.tbl_add_reverse_lookup(o) end

-- Checks if a list-like (vector) table contains `value`.
--- @param t any #(table) Table to check
--- @param value any #any Value to compare
--- @return any #(boolean) `true` if `t` contains `value`
function vim.tbl_contains(t, value) end

-- Counts the number of non-nil values in table `t`.
--- @param t any #(table) Table
--- @return any #(integer) Number of non-nil values in table
function vim.tbl_count(t) end

-- Merges recursively two or more map-like tables.
--- @param behavior any #(string) Decides what to do if a key is found in more than
---                 one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #(table) Two or more map-like tables
--- @return any #(table) Merged table
function vim.tbl_deep_extend(behavior, ...) end

-- Merges two or more map-like tables.
--- @param behavior any #(string) Decides what to do if a key is found in more than
---                 one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #(table) Two or more map-like tables
--- @return any #(table) Merged table
function vim.tbl_extend(behavior, ...) end

-- Filter a table using a predicate function
--- @param func any #(function) Function
--- @param t any #(table) Table
--- @return any #(table) Table of filtered values
function vim.tbl_filter(func, t) end

-- Creates a copy of a list-like table such that any nested tables are
-- "unrolled" and appended to the result.
--- @param t any #(table) List-like table
--- @return any #(table) Flattened copy of the given list-like table
function vim.tbl_flatten(t) end

-- Index into a table (first argument) via string keys passed as subsequent
-- arguments. Return `nil` if the key does not exist.
--- @param o any #(table) Table to index
--- @vararg any #(string) Optional strings (0 or more, variadic) via which to
---            index the table
--- @return any #any Nested value indexed by key (if it exists), else nil
function vim.tbl_get(o, ...) end

-- Checks if a table is empty.
--- @param t any #(table) Table to check
--- @return any #(boolean) `true` if `t` is empty
function vim.tbl_isempty(t) end

-- Tests if a Lua table can be treated as an array.
--- @param t any #(table) Table
--- @return any #(boolean) `true` if array-like table, else `false`
function vim.tbl_islist(t) end

-- Return a list of all keys used in a table. However, the order of the
-- return table of keys is not guaranteed.
--- @param t any #(table) Table
--- @return any #(list) List of keys
function vim.tbl_keys(t) end

-- Apply a function to all values of a table.
--- @param func any #(function) Function
--- @param t any #(table) Table
--- @return any #(table) Table of transformed values
function vim.tbl_map(func, t) end

-- Return a list of all values used in a table. However, the order of the
-- return table of values is not guaranteed.
--- @param t any #(table) Table
--- @return any #(list) List of values
function vim.tbl_values(t) end

-- Trim whitespace (Lua pattern "%s") from both sides of a string.
--- @param s any #(string) String to trim
--- @return any #(string) String with whitespace removed from its beginning and end
function vim.trim(s) end

-- Manage the trust database.
--- @param opts any #(table)
---             • action (string): "allow" to add a file to the trust database
---               and trust it, "deny" to add a file to the trust database and
---               deny it, "remove" to remove file from the trust database
---             • path (string|nil): Path to a file to update. Mutually
---               exclusive with {bufnr}. Cannot be used when {action} is
---               "allow".
---             • bufnr (number|nil): Buffer number to update. Mutually
---               exclusive with {path}.
--- @return any #(boolean, string) success, msg:
---     • true and full path of target file if operation was successful
---     • false and error message on failure
function vim.trust(opts) end

-- Validates a parameter specification (types and values).
--- @param opt any #(table) Names of parameters to validate. Each key is a
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

