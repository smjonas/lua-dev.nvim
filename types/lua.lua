---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @class vim.Iter
vim.Iter = {}

-- Return true if all of the items in the iterator match the given predicate.
--- @param pred any #function(...):bool Predicate function. Takes all values
---             returned from the previous stage in the pipeline as arguments
---             and returns true if the predicate matches.
function vim.Iter:all(pred) end

-- Return true if any of the items in the iterator match the given predicate.
--- @param pred any #function(...):bool Predicate function. Takes all values
---             returned from the previous stage in the pipeline as arguments
---             and returns true if the predicate matches.
function vim.Iter:any(pred) end

-- Call a function once for each item in the pipeline.
--- @param f any #function(...) Function to execute for each item in the pipeline.
---          Takes all of the values returned by the previous stage in the
---          pipeline as arguments.
function vim.Iter:each(f) end

-- Add an iterator stage that returns the current iterator count as well as
-- the iterator value.
--- @return any #Iter
function vim.Iter:enumerate() end

-- Add a filter step to the iterator pipeline.
--- @param f any #function(...):bool Takes all values returned from the previous
---          stage in the pipeline and returns false or nil if the current
---          iterator element should be removed.
--- @return any #Iter
function vim.Iter:filter(f) end

-- Find the first value in the iterator that satisfies the given predicate.
--- @return any #any
function vim.Iter:find(f) end

-- Fold an iterator or table into a single value.
--- @param init any #any Initial value of the accumulator.
--- @param f any #function(acc:any, ...):A Accumulation function.
--- @return any #any
function vim.Iter:fold(init, f) end

-- Return the last item in the iterator.
--- @return any #any
function vim.Iter:last() end

-- Add a map step to the iterator pipeline.
--- @param f any #function(...):any Mapping function. Takes all values returned
---          from the previous stage in the pipeline as arguments and returns
---          one or more new values, which are used in the next pipeline
---          stage. Nil return values are filtered from the output.
--- @return any #Iter
function vim.Iter:map(f) end

-- Return the next value from the iterator.
--- @return any #any
function vim.Iter:next() end

-- Return the next value from the end of the iterator.
--- @return any #any
function vim.Iter:nextback() end

-- Return the nth value in the iterator.
--- @param n any #(number) The index of the value to return.
--- @return any #any
function vim.Iter:nth(n) end

-- Return the nth value from the end of the iterator.
--- @param n any #(number) The index of the value to return.
--- @return any #any
function vim.Iter:nthback(n) end

-- Peek at the next value in the iterator without consuming it.
--- @return any #any
function vim.Iter:peek() end

-- Return the next value from the end of the iterator without consuming it.
--- @return any #any
function vim.Iter:peekback() end

-- Reverse an iterator.
--- @return any #Iter
function vim.Iter:rev() end

-- Find the first value in the iterator that satisfies the given predicate,
-- starting from the end.
--- @return any #any
function vim.Iter:rfind(f) end

-- Skip values in the iterator.
--- @param n any #(number) Number of values to skip.
--- @return any #Iter
function vim.Iter:skip(n) end

-- Skip values in the iterator starting from the end.
--- @param n any #(number) Number of values to skip.
--- @return any #Iter
function vim.Iter:skipback(n) end

-- Slice an iterator, changing its start and end positions.
--- @param first any #(number)
--- @param last any #(number)
--- @return any #Iter
function vim.Iter:slice(first, last) end

-- Collect the iterator into a table.
--- @return any #(table)
function vim.Iter:totable() end

--- @class vim.Ringbuf
vim.Ringbuf = {}

function vim.Ringbuf:clear() end

-- Returns the first unread item without removing it
--- @return any #any?|ni
function vim.Ringbuf:peek() end

-- Removes and returns the first unread item
--- @return any #any?|ni
function vim.Ringbuf:pop() end

-- Adds an item, overriding the oldest item if the buffer is full.
--- @param item any #any
function vim.Ringbuf:push(item) end

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
---                an alias to |nvim_exec2()|, where `opts.output` is set to
---                false. Thus it works identical to |:source|. If a table,
---                executes a single command. In this case, it is an alias to
---                |nvim_cmd()| where `opts` is empty.
function vim.cmd(command) end

-- Parses and compares two version objects (the result of
-- |vim.version.parse()|, or specified literally as a `{major, minor, patch}`
-- tuple, e.g. `{1, 0, 3}`).
--- @param v1 any #Version|number[] Version object.
--- @param v2 any #Version|number[] Version to compare with `v1` .
--- @return any #(integer) -1 if `v1 < v2`, 0 if `v1 == v2`, 1 if `v1 > v2`.
function vim.cmp(v1, v2) end

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
--- @param create any #function?(key:any):any The function called to create a
---               missing value.
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

-- Shows a deprecation message to the user.
--- @param name any #string Deprecated feature (function, API, etc.).
--- @param alternative any #(string|nil) Suggested alternative feature.
--- @param version any #string Version when the deprecated function will be removed.
--- @param plugin any #string|nil Name of the plugin that owns the deprecated
---                    feature. Defaults to "Nvim".
--- @param backtrace any #boolean|nil Prints backtrace. Defaults to true.
--- @return any #Deprecated message, or nil if no message was shown.
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

-- Disables the experimental Lua module loader:
-- • removes the loaders
-- • adds the default Neovim loader
function vim.disable() end

-- Enables the experimental Lua module loader:
-- • overrides loadfile
-- • adds the lua loader using the byte-compilation cache
-- • adds the libs loader
-- • removes the default Neovim loader
function vim.enable() end

-- Tests if `s` ends with `suffix`.
--- @param s any #(string) String
--- @param suffix any #(string) Suffix to match
--- @return any #(boolean) `true` if `suffix` is a suffix of `s`
function vim.endswith(s, suffix) end

-- Returns `true` if the given versions are equal. See |vim.version.cmp()| for usage.
--- @param v1 any #Version|number[]
--- @param v2 any #Version|number[]
--- @return any #(boolean)
function vim.eq(v1, v2) end

-- Filter a table or iterator.
--- @param f any #function(...):bool Filter function. Accepts the current
---            iterator or table values as arguments and returns true if those
---            values should be kept in the final table
--- @param src any #table|function Table or iterator function to filter
--- @return any #(table)
function vim.filter(f, src, ...) end

-- Finds lua modules for the given module name.
--- @param modname any #(string) Module name, or `"*"` to find the top-level
---                modules instead
--- @param opts any #(table|nil) Options for finding a module:
---                • rtp: (boolean) Search for modname in the runtime path
---                  (defaults to `true`)
---                • paths: (string[]) Extra paths to search for modname
---                  (defaults to `{}`)
---                • patterns: (string[]) List of patterns to use when
---                  searching for modules. A pattern is a string added to the
---                  basename of the Lua module being searched. (defaults to
---                  `{"/init.lua", ".lua"}`)
---                • all: (boolean) Return all matches instead of just the
---                  first one (defaults to `false`)
--- @return any #(list) A list of results with the following properties:
---     • modpath: (string) the path to the module
---     • modname: (string) the name of the module
---     • stat: (table|nil) the fs_stat of the module path. Won't be returned
---       for `modname="*"`
function vim.find(modname, opts) end

-- Get the default option value for a {filetype}.
--- @param filetype any #string Filetype
--- @param option any #string Option name
--- @return any #string|boolean|integer: Option value
function vim.get_option(filetype, option) end

-- Splits a string at each instance of a separator.
--- @param s any #string String to split
--- @param sep any #string Separator or pattern
--- @param opts any #(table|nil) Keyword arguments |kwargs|:
---             • plain: (boolean) Use `sep` literally (as in string.find).
---             • trimempty: (boolean) Discard empty segments at start and end
---               of the sequence.
--- @return any #(function) Iterator over the split components
function vim.gsplit(s, sep, opts) end

-- Returns `true` if `v1 > v2` . See |vim.version.cmp()| for usage.
--- @param v1 any #Version|number[]
--- @param v2 any #Version|number[]
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

-- Concatenate directories and/or file paths into a single path with
-- normalization (e.g., `"foo/"` and `"bar"` get joined to `"foo/bar"`)
--- @vararg any #(string)
--- @return any #(string)
function vim.joinpath(...) end

-- Translate keycodes.
--- @param str any #string String to be converted.
--- @return any #string
function vim.keycode(str) end

-- TODO: generalize this, move to func.lua
--- @param versions any #Version []
--- @return any #Version ?|ni
function vim.last(versions) end

-- Checks if a list-like table (integer keys without gaps) contains `value`.
--- @param t any #(table) Table to check (must be list-like, not validated)
--- @param value any #any Value to compare
--- @return any #(boolean) `true` if `t` contains `value`
function vim.list_contains(t, value) end

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

-- Returns `true` if `v1 < v2` . See |vim.version.cmp()| for usage.
--- @param v1 any #Version|number[]
--- @param v2 any #Version|number[]
--- @return any #(boolean)
function vim.lt(v1, v2) end

-- Omnifunc for completing lua values from the runtime lua interpreter,
-- similar to the builtin completion for the `:lua` command.
function vim.lua_omnifunc(find_start, _) end

-- Map and filter a table or iterator.
--- @param f any #function(...):?any Map function. Accepts the current iterator
---            or table values as arguments and returns one or more new
---            values. Nil values are removed from the final table.
--- @param src any #table|function Table or iterator function to filter
--- @return any #(table)
function vim.map(f, src, ...) end

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
--- @param opts any #(table|nil) Options:
---             • expand_env: boolean Expand environment variables (default:
---               true)
--- @return any #(string) Normalized path
function vim.normalize(path, opts) end

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

-- Parses a semantic version string and returns a version object which can be
-- used with other `vim.version` functions. For example "1.0.1-rc1+build.2" returns: >
--
--    { major = 1, minor = 0, patch = 1, prerelease = "rc1", build = "build.2" }
--
-- <
--- @param version any #(string) Version string to parse.
--- @param opts any #(table|nil) Optional keyword arguments:
---                • strict (boolean): Default false. If `true`, no coercion
---                  is attempted on input not conforming to semver v2.0.0. If
---                  `false`, `parse()` attempts to coerce input such as
---                  "1.0", "0-x", "tmux 3.2a" into valid versions.
--- @return any #(table|nil) parsed_version Version object or `nil` if input is invalid.
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

-- Parses a semver |version-range| "spec" and returns a range object: >
--
--   {
--     from: Version
--     to: Version
--     has(v: string|Version)
--   }
--
-- <
--- @param spec any #string Version range "spec"
function vim.range(spec) end

-- Attempt to read the file at {path} prompting the user if the file should
-- be trusted. The user's choice is persisted in a trust database at
-- $XDG_STATE_HOME/nvim/trust.
--- @param path any #(string) Path to a file to read.
--- @return any #(string|nil) The contents of the given file if it exists and is
---     trusted, or nil otherwise.
function vim.read(path) end

-- Get a table of lines with start, end columns for a region marked by two
-- points. Input and output positions are (0,0)-indexed and indicate byte
-- positions.
--- @param bufnr any #(integer) number of buffer
--- @param pos1 any #integer[]|string start of region as a (line, column)
---                  tuple or string accepted by |getpos()|
--- @param pos2 any #integer[]|string end of region as a (line, column) tuple
---                  or string accepted by |getpos()|
--- @param regtype any #(string) type of selection, see |setreg()|
--- @param inclusive any #(boolean) indicating whether column of pos2 is inclusive
--- @return any #(table) region Table of the form `{linenr = {startcol,endcol}}`.
---     `endcol` is exclusive, and whole lines are marked with
---     `{startcol,endcol} = {0,-1}`.
function vim.region(bufnr, pos1, pos2, regtype, inclusive) end

-- Resets the cache for the path, or all the paths if path is nil.
--- @param path any #string? path to reset
function vim.reset(path) end

-- Create a ring buffer limited to a maximal number of items. Once the buffer
-- is full, adding a new entry overrides the oldest entry.
--- @param size any #(integer)
--- @return any #(table)
function vim.ringbuf(size) end

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
--    vim.keymap.set({'n', 'v'}, '<leader>lr', vim.lsp.buf.references, { buffer = true })
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
--- @param opts any #(table|nil) Keyword arguments |kwargs| accepted by
---             |vim.gsplit()|
--- @return any #string[] List of split components
function vim.split(s, sep, opts) end

-- Tests if `s` starts with `prefix`.
--- @param s any #(string) String
--- @param prefix any #(string) Prefix to match
--- @return any #(boolean) `true` if `prefix` is a prefix of `s`
function vim.startswith(s, prefix) end

-- Run a system command
--- @param cmd any #(string[]) Command to execute
--- @param opts any #(SystemOpts|nil) Options:
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
---                • stderr: (boolean|function) Handle output from stdout.
---                  When passed as a function must have the signature
---                  `fun(err: string, data: string)`. Defaults to `true`.
---                • text: (boolean) Handle stdout and stderr as text.
---                  Replaces `\r\n` with `\n`.
---                • timeout: (integer)
---                • detach: (boolean) If true, spawn the child process in a
---                  detached state - this will make it a process group
---                  leader, and will effectively enable the child to keep
---                  running after the parent exits. Note that the child
---                  process will still keep the parent's event loop alive
---                  unless the parent process calls |uv.unref()| on the
---                  child's process handle.
--- @param on_exit any #(function|nil) Called when subprocess exits. When provided,
---                the command runs asynchronously. Receives SystemCompleted
---                object, see return of SystemObj:wait().
--- @return any #SystemObj Object with the fields:
---     • pid (integer) Process ID
---     • wait (fun(timeout: integer|nil): SystemCompleted)
---       • SystemCompleted is an object with the fields:
---         • code: (integer)
---         • signal: (integer)
---         • stdout: (string), nil if stdout argument is passed
---         • stderr: (string), nil if stderr argument is passed
---
---
---     • kill (fun(signal: integer))
---     • write (fun(data: string|nil)) Requires `stdin=true`. Pass `nil` to
---       close the stream.
---     • is_closing (fun(): boolean)
function vim.system(cmd, opts, on_exit) end

-- Add the reverse lookup values to an existing table. For example:
-- `tbl_add_reverse_lookup { A = 1 } == { [1] = 'A', A = 1 }`
--- @param o any #(table) Table to add the reverse to
--- @return any #(table) o
function vim.tbl_add_reverse_lookup(o) end

-- Checks if a table contains a given value, specified either directly or via
-- a predicate that is checked for each value.
--- @param t any #(table) Table to check
--- @param value any #any Value to compare or predicate function reference
--- @param opts any #(table|nil) Keyword arguments |kwargs|:
---              • predicate: (boolean) `value` is a function reference to be
---                checked (default false)
--- @return any #(boolean) `true` if `t` contains `value`
function vim.tbl_contains(t, value, opts) end

-- Counts the number of non-nil values in table `t`.
--- @param t any #(table) Table
--- @return any #(integer) Number of non-nil values in table
function vim.tbl_count(t) end

-- Merges recursively two or more tables.
--- @param behavior any #(string) Decides what to do if a key is found in more than
---                 one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #(table) Two or more tables
--- @return any #(table) Merged table
function vim.tbl_deep_extend(behavior, ...) end

-- Merges two or more tables.
--- @param behavior any #(string) Decides what to do if a key is found in more than
---                 one map:
---                 • "error": raise an error
---                 • "keep": use value from the leftmost map
---                 • "force": use value from the rightmost map
--- @vararg any #(table) Two or more tables
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
--- @vararg any #any Optional keys (0 or more, variadic) via which to index the
---            table
--- @return any #any Nested value indexed by key (if it exists), else nil
function vim.tbl_get(o, ...) end

-- Tests if a Lua table can be treated as an array (a table indexed by
-- integers).
--- @param t any #(table)
--- @return any #(boolean) `true` if array-like table, else `false`.
function vim.tbl_isarray(t) end

-- Checks if a table is empty.
--- @param t any #(table) Table to check
--- @return any #(boolean) `true` if `t` is empty
function vim.tbl_isempty(t) end

-- Tests if a Lua table can be treated as a list (a table indexed by
-- consecutive integers starting from 1).
--- @param t any #(table)
--- @return any #(boolean) `true` if list-like table, else `false`.
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

-- Collect an iterator into a table.
--- @param f any #(function) Iterator function
--- @return any #(table)
function vim.totable(f, ...) end

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

