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

-- Fold ("reduce") an iterator or table into a single value.
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

--- @class vim.Option
vim.Option = {}

-- Append a value to string-style options. See |:set+=|
--- @param value any #(string) Value to append
function vim.Option:append(value) end

-- Returns a Lua-representation of the option. Boolean, number and string
-- values will be returned in exactly the same fashion.
--- @return any #string|integer|boolean|nil value of option
function vim.Option:get() end

-- Prepend a value to string-style options. See |:set^=|
--- @param value any #(string) Value to prepend
function vim.Option:prepend(value) end

-- Remove a value from string-style options. See |:set-=|
--- @param value any #(string) Value to remove
function vim.Option:remove(value) end

--- @class vim.Ringbuf
vim.Ringbuf = {}

function vim.Ringbuf:clear() end

-- Returns the first unread item without removing it
--- @return any #any?|nil
function vim.Ringbuf:peek() end

-- Removes and returns the first unread item
--- @return any #any?|nil
function vim.Ringbuf:pop() end

-- Adds an item, overriding the oldest item if the buffer is full.
--- @param item any #any
function vim.Ringbuf:push(item) end

-- Returns `true` if there's an active snippet in the current buffer.
--- @return any #(boolean)
function vim.active() end

-- Add new filetype mappings.
--- @param filetypes any #(table) A table containing new filetype maps (see
---                  example).
function vim.add(filetypes) end

-- Return the basename of the given path
--- @param file any #(string) Path
--- @return any #(string|nil) Basename of {file}
function vim.basename(file) end

-- Get or set buffer-scoped |options| for the buffer with number {bufnr}.
-- Like `:set` and `:setlocal`. If [{bufnr}] is omitted then the current
-- buffer is used. Invalid {bufnr} or key is an error.
function vim.bo() end

-- Check {str} for spelling errors. Similar to the Vimscript function
-- |spellbadword()|.
--- @param str any #(string)
--- @return any #`{[1]: string, [2]: string, [3]: string}[]` List of tuples with three items:
---     • The badly spelled word.
---     • The type of the spelling error: "bad" spelling mistake "rare" rare
---       word "local" word only valid in another region "caps" word should
---       start with Capital
---     • The position in {str} where the word begins.
function vim.check(str) end

-- Executes Vim script commands.
function vim.cmd() end

-- Parses and compares two version objects (the result of
-- |vim.version.parse()|, or specified literally as a `{major, minor, patch}`
-- tuple, e.g. `{1, 0, 3}`).
--- @param v1 any #Version|number[] Version object.
--- @param v2 any #Version|number[] Version to compare with `v1` .
--- @return any #(integer) -1 if `v1 < v2`, 0 if `v1 == v2`, 1 if `v1 > v2`.
function vim.cmp(v1, v2) end

-- Decodes (or "unpacks") the msgpack-encoded {str} to a Lua object.
--- @param str any #(string)
function vim.decode(str) end

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

-- Creates a table whose missing keys are provided by {createfn} (like
-- Python's "defaultdict").
--- @param createfn any #function?(key:any):any Provides the value for a missing
---                 `key`.
--- @return any #(table) Empty table with `__index` metamethod.
function vim.defaulttable(createfn) end

-- Defers calling {fn} until {timeout} ms passes.
--- @param fn fun(...) #(function) Callback to call once `timeout` expires
--- @param timeout any #(integer) Number of milliseconds to wait before calling
---                `fn`
--- @return any #(table) timer luv timer object
function vim.defer_fn(fn, timeout) end

-- Remove an existing mapping. Examples:
--- @param opts any #(table|nil) A table of optional arguments:
---             • "buffer": (integer|boolean) Remove a mapping from the given
---               buffer. When `0` or `true`, use the current buffer.
function vim.del(modes, lhs, opts) end

-- Shows a deprecation message to the user.
--- @param name any #string Deprecated feature (function, API, etc.).
--- @param alternative any #(string|nil) Suggested alternative feature.
--- @param version any #string Version when the deprecated function will be removed.
--- @param plugin any #string|nil Name of the plugin that owns the deprecated
---                    feature. Defaults to "Nvim".
--- @param backtrace any #boolean|nil Prints backtrace. Defaults to true.
--- @return any #(string|nil) Deprecated message, or nil if no message was shown.
function vim.deprecate(name, alternative, version, plugin, backtrace) end

-- Run diff on strings {a} and {b}. Any indices returned by this function,
-- either directly or via callback arguments, are 1-based.
--- @param a any #(string) First string to compare
--- @param b any #(string) Second string to compare
--- @param opts any #table<string,any> Optional parameters:
---             • `on_hunk` (callback): Invoked for each hunk in the diff. Return a
---               negative number to cancel the callback for any remaining
---               hunks. Args:
---               • `start_a` (integer): Start line of hunk in {a}.
---               • `count_a` (integer): Hunk size in {a}.
---               • `start_b` (integer): Start line of hunk in {b}.
---               • `count_b` (integer): Hunk size in {b}.
---
---             • `result_type` (string): Form of the returned diff:
---               • "unified": (default) String in unified format.
---               • "indices": Array of hunk locations. Note: This option is
---                 ignored if `on_hunk` is used.
---
---             • `linematch` (boolean|integer): Run linematch on the
---               resulting hunks from xdiff. When integer, only hunks upto
---               this size in lines are run through linematch. Requires
---               `result_type = indices`, ignored otherwise.
---             • `algorithm` (string): Diff algorithm to use. Values:
---               • "myers" the default algorithm
---               • "minimal" spend extra time to generate the smallest
---                 possible diff
---               • "patience" patience diff algorithm
---               • "histogram" histogram diff algorithm
---
---             • `ctxlen` (integer): Context length
---             • `interhunkctxlen` (integer): Inter hunk context length
---             • `ignore_whitespace` (boolean): Ignore whitespace
---             • `ignore_whitespace_change` (boolean): Ignore whitespace
---               change
---             • `ignore_whitespace_change_at_eol` (boolean) Ignore
---               whitespace change at end-of-line.
---             • `ignore_cr_at_eol` (boolean) Ignore carriage return at
---               end-of-line
---             • `ignore_blank_lines` (boolean) Ignore blank lines
---             • `indent_heuristic` (boolean): Use the indent heuristic for
---               the internal diff library.
--- @return any #string|table|nil See {opts.result_type}. `nil` if {opts.on_hunk} is
---     given.
function vim.diff(a, b, opts) end

-- Return an iterator over the items located in {path}
--- @param path any #(string) An absolute or relative path to the directory to
---             iterate over. The path is first normalized
---             |vim.fs.normalize()|.
--- @param opts any #(table|nil) Optional keyword arguments:
---             • depth: integer|nil How deep the traverse (default 1)
---             • skip: (fun(dir_name: string): boolean)|nil Predicate to
---               control traversal. Return false to stop searching the
---               current directory. Only useful when depth > 1
--- @return any #Iterator over items in {path}. Each iteration yields two values:
---     "name" and "type". "name" is the basename of the item relative to
---     {path}. "type" is one of the following: "file", "directory", "link",
---     "fifo", "socket", "char", "block", "unknown".
function vim.dir(path, opts) end

-- Return the parent directory of the given path
--- @param file any #(string) Path
--- @return any #(string|nil) Parent directory of {file}
function vim.dirname(file) end

-- Disables the experimental Lua module loader:
-- • removes the loaders
-- • adds the default Nvim loader
function vim.disable() end

-- Creates a special empty table (marked with a metatable), which Nvim
-- converts to an empty dictionary when translating Lua values to Vimscript
-- or API types. Nvim by default converts an empty table `{}` without this
-- metatable to an list/array.
function vim.empty_dict() end

-- Enables the experimental Lua module loader:
-- • overrides loadfile
-- • adds the Lua loader using the byte-compilation cache
-- • adds the libs loader
-- • removes the default Nvim loader
function vim.enable() end

function vim.encode(obj) end

-- Tests if `s` ends with `suffix`.
--- @param s any #(string) String
--- @param suffix any #(string) Suffix to match
--- @return any #(boolean) `true` if `suffix` is a suffix of `s`
function vim.endswith(s, suffix) end

-- Environment variables defined in the editor session. See |expand-env| and
-- |:let-environment| for the Vimscript behavior. Invalid or unset key
-- returns `nil`.
function vim.env() end

-- Returns `true` if the given versions are equal. See |vim.version.cmp()| for usage.
--- @param v1 any #Version|number[]
--- @param v2 any #Version|number[]
--- @return any #(boolean)
function vim.eq(v1, v2) end

function vim.exit() end

-- Expands the given snippet text. Refer to https://microsoft.github.io/language-server-protocol/specification/#snippet_syntax for the specification of valid input.
--- @param input any #(string)
function vim.expand(input) end

-- Filter a table or iterator.
--- @param f any #function(...):bool Filter function. Accepts the current
---            iterator or table values as arguments and returns true if those
---            values should be kept in the final table
--- @param src any #table|function Table or iterator function to filter
--- @return any #(table)
function vim.filter(f, src, ...) end

-- Finds Lua modules for the given module name.
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
--- @param filetype any #(string) Filetype
--- @param option any #(string) Option name
--- @return any #string|boolean|integer: Option value
function vim.get_option(filetype, option) end

-- Get or set global |options|. Like `:setglobal`. Invalid key is an error.
function vim.go() end

-- Gets an |iterator| that splits a string at each instance of a separator,
-- in "lazy" fashion (as opposed to |vim.split()| which is "eager").
--- @param s any #(string) String to split
--- @param sep any #(string) Separator or pattern
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

-- Hex decode a string.
--- @param enc any #(string) String to decode
--- @return any #(string) Decoded string
function vim.hexdecode(enc) end

-- Hex encode a string.
--- @param str any #(string) String to encode
--- @return any #(string) Hex encoded string
function vim.hexencode(str) end

-- The result is a String, which is the text {str} converted from encoding
-- {from} to encoding {to}. When the conversion fails `nil` is returned. When
-- some characters could not be converted they are replaced with "?". The
-- encoding names are whatever the iconv() library function can accept, see
-- ":Man 3 iconv".
--- @param str any #(string) Text to convert
--- @param from any #(number) Encoding of {str}
--- @param to any #(number) Target encoding
--- @param opts any #table<string,any>|nil
--- @return any #(string|nil) Converted string if conversion succeeds, `nil` otherwise.
function vim.iconv(str, from, to, opts) end

-- Returns true if the code is executing as part of a "fast" event handler,
-- where most of the API is disabled. These are low-level events (e.g.
-- |lua-loop-callbacks|) which can be invoked whenever Nvim polls for input.
-- When this is `false` most API functions are callable (but may be subject
-- to other restrictions such as |textlock|).
function vim.in_fast_event() end

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

-- Jumps within the active snippet in the given direction. If the jump isn't
-- possible, the function call does nothing.
--- @param direction any #(vim.snippet.Direction) Navigation direction. -1 for
---                  previous, 1 for next.
function vim.jump(direction) end

-- Returns `true` if there is an active snippet which can be jumped in the
-- given direction. You can use this function to navigate a snippet as
-- follows:
--- @param direction any #(vim.snippet.Direction) Navigation direction. -1 for
---                  previous, 1 for next.
--- @return any #(boolean)
function vim.jumpable(direction) end

-- Translates keycodes.
--- @param str any #(string) String to be converted.
--- @return any #(string)
function vim.keycode(str) end

-- TODO: generalize this, move to func.lua
--- @param versions any #Version []
--- @return any #Version ?|nil
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

-- Omnifunc for completing Lua values from the runtime Lua interpreter,
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

-- Displays a notification to the user.
--- @param msg any #(string) Content of the notification to show to the user.
--- @param level any #(integer|nil) One of the values from |vim.log.levels|.
--- @param opts any #(table|nil) Optional parameters. Unused by default.
function vim.notify(msg, level, opts) end

-- Displays a notification only one time.
--- @param msg any #(string) Content of the notification to show to the user.
--- @param level any #(integer|nil) One of the values from |vim.log.levels|.
--- @param opts any #(table|nil) Optional parameters. Unused by default.
--- @return any #(boolean) true if message was displayed, else false
function vim.notify_once(msg, level, opts) end

-- Get or set |options|. Like `:set`. Invalid key is an error.
function vim.o() end

-- Adds Lua function {fn} with namespace id {ns_id} as a listener to every,
-- yes every, input key.
--- @param fn fun(...) #fun(key: string) Function invoked on every key press.
---              |i_CTRL-V| Returning nil removes the callback associated with
---              namespace {ns_id}.
--- @param ns_id any #integer? Namespace ID. If nil or 0, generates and returns a
---              new |nvim_create_namespace()| id.
--- @return any #(integer) Namespace id associated with {fn}. Or count of all callbacks
---     if on_key() is called without arguments.
function vim.on_key(fn, ns_id) end

-- Highlight the yanked text
--- @param opts any #(table|nil) Optional parameters
---             • higroup highlight group for yanked region (default
---               "IncSearch")
---             • timeout time in ms before highlight is cleared (default 150)
---             • on_macro highlight when executing macro (default false)
---             • on_visual highlight when yanking visual selection (default
---               true)
---             • event event structure (default vim.v.event)
---             • priority integer priority (default
---               |vim.highlight.priorities|`.user`)
function vim.on_yank(opts) end

-- Opens `path` with the system default handler (macOS `open`, Windows
-- `explorer.exe`, Linux `xdg-open`, …), or returns (but does not show) an
-- error message on failure.
--- @param path any #(string) Path or URL to open
--- @return any #vim.SystemCompleted|nil Command result, or nil if not found.
--- @return any #(string|nil) Error message on failure
function vim.open(path) end

-- Iterate over all the parents of the given path.
--- @param start any #(string) Initial path.
--- @return any #fun(_, dir: string): string? Iterator
--- @return any #nil
--- @return any #(string|nil)
function vim.parents(start) end

-- Parses a semantic version string and returns a version object which can be
-- used with other `vim.version` functions. For example "1.0.1-rc1+build.2"
-- returns:
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
--- @return any #(boolean) result false if client should cancel the paste.
function vim.paste(lines, phase) end

-- Escapes magic chars in |lua-patterns|.
--- @param s any #(string) String to escape
--- @return any #(string) %-escaped pattern string
function vim.pesc(s) end

-- "Pretty prints" the given arguments and returns them unmodified.
--- @return any #any given arguments.
function vim.print(...) end

-- Table with default priorities used for highlighting:
-- • `syntax`: `50`, used for standard syntax highlighting
-- • `treesitter`: `100`, used for tree-sitter-based highlighting
-- • `semantic_tokens`: `125`, used for LSP semantic token highlighting
-- • `diagnostics`: `150`, used for code analysis such as diagnostics
-- • `user`: `200`, used for user-triggered highlights such as LSP document
--   symbols or `on_yank` autocommands
function vim.priorities() end

-- Parses a semver |version-range| "spec" and returns a range object:
--- @param spec any #(string) Version range "spec"
function vim.range(spec) end

-- Attempt to read the file at {path} prompting the user if the file should
-- be trusted. The user's choice is persisted in a trust database at
-- $XDG_STATE_HOME/nvim/trust.
--- @param path any #(string) Path to a file to read.
--- @return any #(string|nil) The contents of the given file if it exists and is
---     trusted, or nil otherwise.
function vim.read(path) end

-- Parse the Vim regex {re} and return a regex object. Regexes are "magic"
-- and case-sensitive by default, regardless of 'magic' and 'ignorecase'.
-- They can be controlled with flags, see |/magic| and |/ignorecase|.
--- @param re any #(string)
--- @return any #vim.regex
function vim.regex(re) end

--- @class vim.regex
vim.regex = {}

-- Match line {line_idx} (zero-based) in buffer {bufnr}. If {start} and {end}
-- are supplied, match only this byte index range. Otherwise see
-- |regex:match_str()|. If {start} is used, then the returned byte indices
-- will be relative {start}.
--- @param bufnr any #(integer)
--- @param line_idx any #(integer)
--- @param start any #(integer|nil)
--- @param end_ any #(integer|nil)
function vim.regex:match_line(bufnr, line_idx, start, end_) end

-- Match the string against the regex. If the string should match the regex
-- precisely, surround the regex with `^` and `$` . If there was a match, the byte indices for the beginning and end of the
-- match are returned. When there is no match, `nil` is returned. Because any integer is "truthy", `regex:match_str()` can be directly used as a condition in an if-statement.
--- @param str any #(string)
function vim.regex:match_str(str) end

-- Gets a dict of line segment ("chunk") positions for the region from `pos1`
-- to `pos2`.
--- @param bufnr any #(integer) Buffer number, or 0 for current buffer
--- @param pos1 any #integer[]|string Start of region as a (line, column)
---                  tuple or |getpos()|-compatible string
--- @param pos2 any #integer[]|string End of region as a (line, column) tuple
---                  or |getpos()|-compatible string
--- @param regtype any #(string) |setreg()|-style selection type
--- @param inclusive any #(boolean) Controls whether `pos2` column is inclusive
---                  (see also 'selection').
--- @return any #(table) region Dict of the form `{linenr = {startcol,endcol}}`.
---     `endcol` is exclusive, and whole lines are returned as
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

-- Sends {event} to {channel} via |RPC| and returns immediately. If {channel}
-- is 0, the event is broadcast to all channels.
--- @param channel any #(integer)
--- @param method any #(string)
--- @param args any[] #any[]|nil
--- @vararg any #any|nil
function vim.rpcnotify(channel, method, args, ...) end

-- Sends a request to {channel} to invoke {method} via |RPC| and blocks until
-- a response is received.
--- @param channel any #(integer)
--- @param method any #(string)
--- @param args any[] #any[]|nil
--- @vararg any #any|nil
function vim.rpcrequest(channel, method, args, ...) end

-- Schedules {fn} to be invoked soon by the main event-loop. Useful to avoid
-- |textlock| or other temporary restrictions.
--- @param fn fun(...) #(function)
function vim.schedule(fn) end

-- Returns a function which calls {fn} via |vim.schedule()|.
--- @param fn fun(...) #(function)
--- @return any #(function)
function vim.schedule_wrap(fn) end

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

-- Adds a new |mapping|. Examples:
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
---               • "buffer": (integer|boolean) Creates buffer-local mapping,
---                 `0` or `true` for current buffer.
---               • "remap": (boolean) Make the mapping recursive. Inverse of
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

-- Enumerates key-value pairs of a table, ordered by key.
--- @param t any #(table) Dict-like table
--- @return any #(function) |for-in| iterator over sorted keys and their values
function vim.spairs(t) end

-- Splits a string at each instance of a separator and returns the result as
-- a table (unlike |vim.gsplit()|).
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

-- Convert UTF-32 or UTF-16 {index} to byte index. If {use_utf16} is not
-- supplied, it defaults to false (use UTF-32). Returns the byte index.
--- @param str any #(string)
--- @param index any #(number)
--- @param use_utf16 any #any|nil
function vim.str_byteindex(str, index, use_utf16) end

-- Gets the distance (in bytes) from the last byte of the codepoint
-- (character) that {index} points to.
--- @param str any #(string)
--- @param index any #(number)
--- @return any #(number)
function vim.str_utf_end(str, index) end

-- Gets a list of the starting byte positions of each UTF-8 codepoint in the
-- given string.
--- @param str any #(string)
--- @return any #(table)
function vim.str_utf_pos(str) end

-- Gets the distance (in bytes) from the starting byte of the codepoint
-- (character) that {index} points to.
--- @param str any #(string)
--- @param index any #(number)
--- @return any #(number)
function vim.str_utf_start(str, index) end

-- Convert byte index to UTF-32 and UTF-16 indices. If {index} is not
-- supplied, the length of the string is used. All indices are zero-based.
--- @param str any #(string)
--- @param index any #(number|nil)
--- @return any #(integer) UTF-32 index
--- @return any #(integer) UTF-16 index
function vim.str_utfindex(str, index) end

-- Compares strings case-insensitively.
--- @param a any #(string)
--- @param b any #(string)
--- @return any #0|1|-1 if strings are equal, {a} is greater than {b} or {a} is lesser
---     than {b}, respectively.
function vim.stricmp(a, b) end

-- Runs a system command or throws an error if {cmd} cannot be run.
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
--- @param on_exit any #(function|nil) Called when subprocess exits. When provided,
---                the command runs asynchronously. Receives SystemCompleted
---                object, see return of SystemObj:wait().
--- @return any #vim.SystemObj Object with the fields:
---     • pid (integer) Process ID
---     • wait (fun(timeout: integer|nil): SystemCompleted) Wait for the
---       process to complete. Upon timeout the process is sent the KILL
---       signal (9) and the exit code is set to 124.
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

-- Tests if `t` is an "array": a table indexed only by integers (potentially non-contiguous).
--- @param t any #(table)
--- @return any #(boolean) `true` if array-like table, else `false`.
function vim.tbl_isarray(t) end

-- Checks if a table is empty.
--- @param t any #(table) Table to check
--- @return any #(boolean) `true` if `t` is empty
function vim.tbl_isempty(t) end

-- Tests if `t` is a "list": a table indexed only by contiguous integers starting from 1 (what |lua-length| calls a "regular
-- array").
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
--- @return any #(boolean) success true if operation was successful
--- @return any #(string) msg full path if operation was successful, else error message
function vim.trust(opts) end

-- Attach to ui events, similar to |nvim_ui_attach()| but receive events as
-- Lua callback. Can be used to implement screen elements like popupmenu or
-- message handling in Lua.
--- @param ns any #(integer)
--- @param options any #table<string, any>
--- @param callback any #fun()
function vim.ui_attach(ns, options, callback) end

-- Detach a callback previously attached with |vim.ui_attach()| for the given
-- namespace {ns}.
--- @param ns any #(integer)
function vim.ui_detach(ns) end

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

-- Wait for {time} in milliseconds until {callback} returns `true`.
--- @param time any #(integer) Number of milliseconds to wait
--- @param callback any #fun():|nil boolean Optional callback. Waits until
---                  {callback} returns true
--- @param interval any #(integer|nil) (Approximate) number of milliseconds to
---                  wait between polls
--- @param fast_only any #(boolean|nil) If true, only |api-fast| events will be
---                  processed. If called from while in an |api-fast| event,
---                  will automatically be set to `true`.
--- @return any #boolean, nil|-1|-2
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

