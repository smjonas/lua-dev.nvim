---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Returns a pattern that matches only if the input string at the current
-- position is preceded by `patt`. Pattern `patt` must match only strings
-- with some fixed length, and it cannot contain captures. Like the and
-- predicate, this pattern never consumes any input, independently of success
-- or failure.
--- @param pattern any #(`vim.lpeg.Pattern`)
--- @return any #(`vim.lpeg.Pattern`)
function vim.B(pattern) end

-- Creates a simple capture, which captures the substring of the subject that
-- matches `patt`. The captured value is a string. If `patt` has other
-- captures, their values are returned after this one.
--- @param patt any #(`vim.lpeg.Pattern`)
--- @return any #(`vim.lpeg.Capture`)
function vim.C(patt) end

-- Creates an argument capture. This pattern matches the empty string and
-- produces the value given as the nth extra argument given in the call to `lpeg.match` .
--- @param n any #(`integer`)
--- @return any #(`vim.lpeg.Capture`)
function vim.Carg(n) end

-- Creates a back capture. This pattern matches the empty string and produces
-- the values produced by the most recent group capture named `name` (where
-- `name` can be any Lua value). Most recent means the last complete
-- outermost group capture with the given name. A Complete capture means that
-- the entire pattern corresponding to the capture has matched. An Outermost
-- capture means that the capture is not inside another complete capture. In
-- the same way that LPeg does not specify when it evaluates captures, it
-- does not specify whether it reuses values previously produced by the group
-- or re-evaluates them.
--- @param name any #(`any`)
--- @return any #(`vim.lpeg.Capture`)
function vim.Cb(name) end

-- Creates a constant capture. This pattern matches the empty string and
-- produces all given values as its captured values.
--- @vararg any #(`any`)
--- @return any #(`vim.lpeg.Capture`)
function vim.Cc(...) end

-- Creates a fold capture. If `patt` produces a list of captures C1 C2 ...
-- Cn, this capture will produce the value `func(...func(func(C1, C2),
-- C3)...,Cn)`, that is, it will fold (or accumulate, or reduce) the captures
-- from `patt` using function `func`. This capture assumes that `patt` should
-- produce at least one capture with at least one value (of any type), which
-- becomes the initial value of an accumulator. (If you need a specific
-- initial value, you may prefix a constant captureto `patt`.) For each
-- subsequent capture, LPeg calls `func` with this accumulator as the first
-- argument and all values produced by the capture as extra arguments; the
-- first result from this call becomes the new value for the accumulator. The
-- final value of the accumulator becomes the captured value.
--- @param patt any #(`vim.lpeg.Pattern`)
--- @param func any #(`fun(acc, newvalue)`)
--- @return any #(`vim.lpeg.Capture`)
function vim.Cf(patt, func) end

-- Creates a group capture. It groups all values returned by `patt` into a
-- single capture. The group may be anonymous (if no name is given) or named
-- with the given name (which can be any non-nil Lua value).
--- @param patt any #(`vim.lpeg.Pattern`)
--- @param name any #(`string?`)
--- @return any #(`vim.lpeg.Capture`)
function vim.Cg(patt, name) end

-- Creates a match-time capture. Unlike all other captures, this one is
-- evaluated immediately when a match occurs (even if it is part of a larger
-- pattern that fails later). It forces the immediate evaluation of all its
-- nested captures and then calls `function`. The given function gets as
-- arguments the entire subject, the current position (after the match of
-- `patt`), plus any capture values produced by `patt`. The first value
-- returned by `function` defines how the match happens. If the call returns
-- a number, the match succeeds and the returned number becomes the new
-- current position. (Assuming a subject sand current position i, the
-- returned number must be in the range [i, len(s) + 1].) If the call returns
-- true, the match succeeds without consuming any input (so, to return true
-- is equivalent to return i). If the call returns false, nil, or no value,
-- the match fails. Any extra values returned by the function become the
-- values produced by the capture.
--- @param patt any #(`vim.lpeg.Pattern`)
--- @param fn fun(...) #(`function`)
--- @return any #(`vim.lpeg.Capture`)
function vim.Cmt(patt, fn) end

-- Creates a position capture. It matches the empty string and captures the
-- position in the subject where the match occurs. The captured value is a
-- number.
--- @return any #(`vim.lpeg.Capture`)
function vim.Cp() end

-- Creates a substitution capture. This function creates a substitution
-- capture, which captures the substring of the subject that matches `patt`,
-- with substitutions. For any capture inside `patt` with a value, the
-- substring that matched the capture is replaced by the capture value (which
-- should be a string). The final captured value is the string resulting from
-- all replacements.
--- @param patt any #(`vim.lpeg.Pattern`)
--- @return any #(`vim.lpeg.Capture`)
function vim.Cs(patt) end

-- Creates a table capture. This capture returns a table with all values from
-- all anonymous captures made by `patt` inside this table in successive
-- integer keys, starting at 1. Moreover, for each named capture group
-- created by `patt`, the first value of the group is put into the table with
-- the group name as its key. The captured value is only the table.
--- @param patt any #(vim.lpeg.Pattern |' `) @return (` vim.lpeg.Capture`)
function vim.Ct(patt) end

--- @class vim.Iter
vim.Iter = {}

-- Returns true if all items in the iterator match the given predicate.
--- @param pred any #(`fun(...):boolean`) Predicate function. Takes all values
---             returned from the previous stage in the pipeline as arguments
---             and returns true if the predicate matches.
function vim.Iter:all(pred) end

-- Returns true if any of the items in the iterator match the given
-- predicate.
--- @param pred any #(`fun(...):boolean`) Predicate function. Takes all values
---             returned from the previous stage in the pipeline as arguments
---             and returns true if the predicate matches.
function vim.Iter:any(pred) end

-- Calls a function once for each item in the pipeline, draining the
-- iterator.
--- @param f any #(`fun(...)`) Function to execute for each item in the pipeline.
---          Takes all of the values returned by the previous stage in the
---          pipeline as arguments.
function vim.Iter:each(f) end

-- Yields the item index (count) and value for each item of an iterator
-- pipeline.
--- @return any #(`Iter`)
function vim.Iter:enumerate() end

-- Filters an iterator pipeline.
--- @param f any #(`fun(...):boolean`) Takes all values returned from the previous
---          stage in the pipeline and returns false or nil if the current
---          iterator element should be removed.
--- @return any #(`Iter`)
function vim.Iter:filter(f) end

-- Find the first value in the iterator that satisfies the given predicate.
--- @return any #(`any`)
function vim.Iter:find(f) end

-- Flattens a |list-iterator|, un-nesting nested values up to the given
-- {depth}. Errors if it attempts to flatten a dict-like value.
--- @param depth any #(`number?`) Depth to which |list-iterator| should be
---              flattened (defaults to 1)
--- @return any #(`Iter`)
function vim.Iter:flatten(depth) end

-- Folds ("reduces") an iterator into a single value.
--- @param init any #(`any`) Initial value of the accumulator.
--- @param f any #(`fun(acc:any, ...):any`) Accumulation function.
--- @return any #(`any`)
function vim.Iter:fold(init, f) end

-- Collect the iterator into a delimited string.
--- @param delim any #(`string`) Delimiter
--- @return any #(`string`)
function vim.Iter:join(delim) end

-- Drains the iterator and returns the last item.
--- @return any #(`any`)
function vim.Iter:last() end

-- Maps the items of an iterator pipeline to the values returned by `f`.
--- @param f any #(`fun(...):any`) Mapping function. Takes all values returned from
---          the previous stage in the pipeline as arguments and returns one
---          or more new values, which are used in the next pipeline stage.
---          Nil return values are filtered from the output.
--- @return any #(`Iter`)
function vim.Iter:map(f) end

-- Gets the next value from the iterator.
--- @return any #(`any`)
function vim.Iter:next() end

-- "Pops" a value from a |list-iterator| (gets the last value and decrements
-- the tail).
--- @return any #(`any`)
function vim.Iter:nextback() end

-- Gets the nth value of an iterator (and advances to it).
--- @param n any #(`number`) The index of the value to return.
--- @return any #(`any`)
function vim.Iter:nth(n) end

-- Gets the nth value from the end of a |list-iterator| (and advances to it).
--- @param n any #(`number`) The index of the value to return.
--- @return any #(`any`)
function vim.Iter:nthback(n) end

-- Gets the next value in a |list-iterator| without consuming it.
--- @return any #(`any`)
function vim.Iter:peek() end

-- Gets the last value of a |list-iterator| without consuming it.
--- @return any #(`any`)
function vim.Iter:peekback() end

-- Reverses a |list-iterator| pipeline.
--- @return any #(`Iter`)
function vim.Iter:rev() end

-- Gets the first value in a |list-iterator| that satisfies a predicate,
-- starting from the end.
--- @return any #(`any`)
function vim.Iter:rfind(f) end

-- Skips `n` values of an iterator pipeline.
--- @param n any #(`number`) Number of values to skip.
--- @return any #(`Iter`)
function vim.Iter:skip(n) end

-- Skips `n` values backwards from the end of a |list-iterator| pipeline.
--- @param n any #(`number`) Number of values to skip.
--- @return any #(`Iter`)
function vim.Iter:skipback(n) end

-- Sets the start and end of a |list-iterator| pipeline.
--- @param first any #(`number`)
--- @param last any #(`number`)
--- @return any #(`Iter`)
function vim.Iter:slice(first, last) end

-- Transforms an iterator to yield only the first n values.
--- @param n any #(`integer`)
--- @return any #(`Iter`)
function vim.Iter:take(n) end

-- Collect the iterator into a table.
--- @return any #(`table`)
function vim.Iter:totable() end

--- @class vim.Option
vim.Option = {}

-- Append a value to string-style options. See |:set+=|
--- @param value any #(`string`) Value to append
function vim.Option:append(value) end

-- Returns a Lua-representation of the option. Boolean, number and string
-- values will be returned in exactly the same fashion.
--- @return any #(`string|integer|boolean?`) value of option
function vim.Option:get() end

-- Prepend a value to string-style options. See |:set^=|
--- @param value any #(`string`) Value to prepend
function vim.Option:prepend(value) end

-- Remove a value from string-style options. See |:set-=|
--- @param value any #(`string`) Value to remove
function vim.Option:remove(value) end

-- Converts the given value into a proper pattern. This following rules are
-- applied:
-- • If the argument is a pattern, it is returned unmodified.
-- • If the argument is a string, it is translated to a pattern that matches
--   the string literally.
-- • If the argument is a non-negative number `n`, the result is a pattern
--   that matches exactly `n` characters.
-- • If the argument is a negative number `-n`, the result is a pattern that
--   succeeds only if the input string has less than `n` characters left:
--   `lpeg.P(-n)` is equivalent to `-lpeg.P(n)` (see the unary minus
--   operation).
-- • If the argument is a boolean, the result is a pattern that always
--   succeeds or always fails (according to the boolean value), without
--   consuming any input.
-- • If the argument is a table, it is interpreted as a grammar (see
--   Grammars).
-- • If the argument is a function, returns a pattern equivalent to a
--   match-time captureover the empty string.
--- @param value any #(`vim.lpeg.Pattern|string|integer|boolean|table|function`)
--- @return any #(`vim.lpeg.Pattern`)
function vim.P(value) end

--- @class vim.Pattern
vim.Pattern = {}

-- Matches the given `pattern` against the `subject` string. If the match
-- succeeds, returns the index in the subject of the first character after
-- the match, or the captured values (if the pattern captured any value). An
-- optional numeric argument `init` makes the match start at that position in
-- the subject string. As usual in Lua libraries, a negative value counts
-- from the end. Unlike typical pattern-matching functions, `match` works
-- only in anchored mode; that is, it tries to match the pattern with a
-- prefix of the given subject string (at position `init`), not with an
-- arbitrary substring of the subject. So, if we want to find a pattern
-- anywhere in a string, we must either write a loop in Lua or write a
-- pattern that matches anywhere.
--- @param subject any #(`string`)
--- @param init any #(`integer?`)
--- @return any #(`integer|vim.lpeg.Capture?`)
function vim.Pattern:match(subject, init) end

-- Returns a pattern that matches any single character belonging to one of
-- the given ranges. Each `range` is a string `xy` of length 2, representing
-- all characters with code between the codes of `x` and `y` (both
-- inclusive). As an example, the pattern `lpeg.R("09")` matches any digit,
-- and `lpeg.R("az", "AZ")` matches any ASCII letter.
--- @vararg any #(`string`)
--- @return any #(`vim.lpeg.Pattern`)
function vim.R(...) end

--- @class vim.Ringbuf
vim.Ringbuf = {}

-- Clear all items.
function vim.Ringbuf:clear() end

-- Returns the first unread item without removing it
--- @return any #(`any?`)
function vim.Ringbuf:peek() end

-- Removes and returns the first unread item
--- @return any #(`any?`)
function vim.Ringbuf:pop() end

-- Adds an item, overriding the oldest item if the buffer is full.
--- @param item any #(`any`)
function vim.Ringbuf:push(item) end

-- Returns a pattern that matches any single character that appears in the
-- given string (the `S` stands for Set). As an example, the pattern
-- `lpeg.S("+-*&zwj;/")` matches any arithmetic operator. Note that, if `s`
-- is a character (that is, a string of length 1), then `lpeg.P(s)` is
-- equivalent to `lpeg.S(s)` which is equivalent to `lpeg.R(s..s)`. Note also
-- that both `lpeg.S("")` and `lpeg.R()` are patterns that always fail.
--- @param string any #(`string`)
--- @return any #(`vim.lpeg.Pattern`)
function vim.S(string) end

-- Creates a non-terminal (a variable) for a grammar. This operation creates
-- a non-terminal (a variable) for a grammar. The created non-terminal refers
-- to the rule indexed by `v` in the enclosing grammar.
--- @param v any #(`string|integer`)
--- @return any #(`vim.lpeg.Pattern`)
function vim.V(v) end

-- Returns `true` if there's an active snippet in the current buffer.
--- @return any #(`boolean`)
function vim.active() end

-- Add new filetype mappings.
--- @param filetypes any #(`table`) A table containing new filetype maps (see
---                  example).
function vim.add(filetypes) end

-- Return the basename of the given path
--- @param file any #(`string`) Path
--- @return any #(`string?`) Basename of {file}
function vim.basename(file) end

-- Get or set buffer-scoped |options| for the buffer with number {bufnr}.
-- Like `:set` and `:setlocal`. If [{bufnr}] is omitted then the current
-- buffer is used. Invalid {bufnr} or key is an error.
function vim.bo() end

-- Check {str} for spelling errors. Similar to the Vimscript function
-- |spellbadword()|.
--- @param str any #(`string`)
--- @return any #(`{[1]: string, [2]: string, [3]: string}[]`) List of tuples with
---     three items:
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
--- @param v1 any #(`Version|number[]|string`) Version object.
--- @param v2 any #(`Version|number[]|string`) Version to compare with `v1` .
--- @return any #(`integer`) -1 if `v1 < v2`, 0 if `v1 == v2`, 1 if `v1 > v2`.
function vim.cmp(v1, v2) end

-- Compiles the given {string} and returns an equivalent LPeg pattern. The
-- given string may define either an expression or a grammar. The optional
-- {defs} table provides extra Lua values to be used by the pattern.
--- @param string any #(`string`)
--- @param defs any #(`table?`)
--- @return any #(`vim.lpeg.Pattern`)
function vim.compile(string, defs) end

-- Decodes (or "unpacks") the msgpack-encoded {str} to a Lua object.
--- @param str any #(`string`)
function vim.decode(str) end

-- Deep compare values for equality
--- @param a any #(`any`) First value
--- @param b any #(`any`) Second value
--- @return any #(`boolean`) `true` if values are equals, else `false`
function vim.deep_equal(a, b) end

-- Returns a deep copy of the given object. Non-table objects are copied as
-- in a typical Lua assignment, whereas table objects are copied recursively.
-- Functions are naively copied, so functions in the copied table point to
-- the same functions as those in the input table. Userdata and threads are
-- not copied and will throw an error.
--- @param orig any #(`table`) Table to copy
--- @param noref any #(`boolean?`) When `false` (default) a contained table is only
---              copied once and all references point to this single copy.
---              When `true` every occurrence of a table results in a new
---              copy. This also means that a cyclic reference can cause
---              `deepcopy()` to fail.
--- @return any #(`table`) Table of copied keys and (nested) values.
function vim.deepcopy(orig, noref) end

-- Creates a table whose missing keys are provided by {createfn} (like
-- Python's "defaultdict").
--- @param createfn any #(`fun(key:any):any?`) Provides the value for a missing
---                 `key`.
--- @return any #(`table`) Empty table with `__index` metamethod.
function vim.defaulttable(createfn) end

-- Defers calling {fn} until {timeout} ms passes.
--- @param fn fun(...) #(`function`) Callback to call once `timeout` expires
--- @param timeout any #(`integer`) Number of milliseconds to wait before calling
---                `fn`
--- @return any #(`table`) timer luv timer object
function vim.defer_fn(fn, timeout) end

-- Remove an existing mapping. Examples:
--- @param opts any #(`table?`) A table of optional arguments:
---             • "buffer": (integer|boolean) Remove a mapping from the given
---               buffer. When `0` or `true`, use the current buffer.
function vim.del(modes, lhs, opts) end

-- Shows a deprecation message to the user.
--- @param name any #(`string`) Deprecated feature (function, API, etc.).
--- @param alternative any #(`string?`) Suggested alternative feature.
--- @param version any #(`string`) Version when the deprecated function will be
---                    removed.
--- @param plugin any #(`string?`) Name of the plugin that owns the deprecated
---                    feature. Defaults to "Nvim".
--- @param backtrace any #(`boolean?`) Prints backtrace. Defaults to true.
--- @return any #(`string?`) Deprecated message, or nil if no message was shown.
function vim.deprecate(name, alternative, version, plugin, backtrace) end

-- Run diff on strings {a} and {b}. Any indices returned by this function,
-- either directly or via callback arguments, are 1-based.
--- @param a any #(`string`) First string to compare
--- @param b any #(`string`) Second string to compare
--- @param opts any #(`table<string,any>`) Optional parameters:
---             • `on_hunk` (callback): Invoked for each hunk in the diff.
---               Return a negative number to cancel the callback for any
---               remaining hunks. Args:
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
--- @return any #(`string|table?`) See {opts.result_type}. `nil` if {opts.on_hunk} is
---     given.
function vim.diff(a, b, opts) end

-- Return an iterator over the items located in {path}
--- @param path any #(`string`) An absolute or relative path to the directory to
---             iterate over. The path is first normalized
---             |vim.fs.normalize()|.
--- @param opts any #(`table?`) Optional keyword arguments:
---             • depth: integer|nil How deep the traverse (default 1)
---             • skip: (fun(dir_name: string): boolean)|nil Predicate to
---               control traversal. Return false to stop searching the
---               current directory. Only useful when depth > 1
--- @return any #(`Iterator`) over items in {path}. Each iteration yields two values:
---     "name" and "type". "name" is the basename of the item relative to
---     {path}. "type" is one of the following: "file", "directory", "link",
---     "fifo", "socket", "char", "block", "unknown".
function vim.dir(path, opts) end

-- Return the parent directory of the given path
--- @param file any #(`string`) Path
--- @return any #(`string?`) Parent directory of {file}
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

-- Encodes (or "packs") Lua object {obj} as msgpack in a Lua string.
function vim.encode(obj) end

-- Tests if `s` ends with `suffix`.
--- @param s any #(`string`) String
--- @param suffix any #(`string`) Suffix to match
--- @return any #(`boolean`) `true` if `suffix` is a suffix of `s`
function vim.endswith(s, suffix) end

-- Environment variables defined in the editor session. See |expand-env| and
-- |:let-environment| for the Vimscript behavior. Invalid or unset key
-- returns `nil`.
function vim.env() end

-- Returns `true` if the given versions are equal. See |vim.version.cmp()| for
-- usage.
--- @param v1 any #(`Version|number[]|string`)
--- @param v2 any #(`Version|number[]|string`)
--- @return any #(`boolean`)
function vim.eq(v1, v2) end

-- Exits the current snippet.
function vim.exit() end

-- Expands the given snippet text. Refer to https://microsoft.github.io/language-server-protocol/specification/#snippet_syntax for
-- the specification of valid input.
--- @param input any #(`string`)
function vim.expand(input) end

-- Filters a table or other |iterable|.
--- @param f any #(`fun(...):boolean`) Filter function. Accepts the current
---            iterator or table values as arguments and returns true if those
---            values should be kept in the final table
--- @param src any #(`table|function`) Table or iterator function to filter
--- @return any #(`table`)
function vim.filter(f, src, ...) end

-- Finds Lua modules for the given module name.
--- @param modname any #(`string`) Module name, or `"*"` to find the top-level
---                modules instead
--- @param opts any #(`table?`) Options for finding a module:
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
--- @return any #(`list`) A list of results with the following properties:
---     • modpath: (string) the path to the module
---     • modname: (string) the name of the module
---     • stat: (table|nil) the fs_stat of the module path. Won't be returned
---       for `modname="*"`
function vim.find(modname, opts) end

-- Returns `true` if `v1 >= v2` . See |vim.version.cmp()| for usage.
--- @param v1 any #(`Version|number[]|string`)
--- @param v2 any #(`Version|number[]|string`)
--- @return any #(`boolean`)
function vim.ge(v1, v2) end

-- Get the default option value for a {filetype}.
--- @param filetype any #(`string`) Filetype
--- @param option any #(`string`) Option name
--- @return any #(`string|boolean|integer`) Option value
function vim.get_option(filetype, option) end

-- Get or set global |options|. Like `:setglobal`. Invalid key is an error.
function vim.go() end

-- Gets an |iterator| that splits a string at each instance of a separator,
-- in "lazy" fashion (as opposed to |vim.split()| which is "eager").
--- @param s any #(`string`) String to split
--- @param sep any #(`string`) Separator or pattern
--- @param opts any #(`table?`) Keyword arguments |kwargs|:
---             • plain: (boolean) Use `sep` literally (as in string.find).
---             • trimempty: (boolean) Discard empty segments at start and end
---               of the sequence.
--- @return any #(`function`) Iterator over the split components
function vim.gsplit(s, sep, opts) end

-- Does a global substitution, replacing all occurrences of {pattern} in the
-- given {subject} by {replacement}.
--- @param subject any #(`string`)
--- @param pattern any #(`vim.lpeg.Pattern|string`)
--- @param replacement any #(`string`)
--- @return any #(`string`)
function vim.gsub(subject, pattern, replacement) end

-- Returns `true` if `v1 > v2` . See |vim.version.cmp()| for usage.
--- @param v1 any #(`Version|number[]|string`)
--- @param v2 any #(`Version|number[]|string`)
--- @return any #(`boolean`)
function vim.gt(v1, v2) end

-- Hex decode a string.
--- @param enc any #(`string`) String to decode
--- @return any #(`string`) Decoded string
function vim.hexdecode(enc) end

-- Hex encode a string.
--- @param str any #(`string`) String to encode
--- @return any #(`string`) Hex encoded string
function vim.hexencode(str) end

-- The result is a String, which is the text {str} converted from encoding
-- {from} to encoding {to}. When the conversion fails `nil` is returned. When
-- some characters could not be converted they are replaced with "?". The
-- encoding names are whatever the iconv() library function can accept, see
-- ":Man 3 iconv".
--- @param str any #(`string`) Text to convert
--- @param from any #(`number`) Encoding of {str}
--- @param to any #(`number`) Target encoding
--- @param opts any #(`table<string,any>?`)
--- @return any #(`string?`) Converted string if conversion succeeds, `nil` otherwise.
function vim.iconv(str, from, to, opts) end

-- Returns true if the code is executing as part of a "fast" event handler,
-- where most of the API is disabled. These are low-level events (e.g.
-- |lua-loop-callbacks|) which can be invoked whenever Nvim polls for input.
-- When this is `false` most API functions are callable (but may be subject
-- to other restrictions such as |textlock|).
function vim.in_fast_event() end

-- Prompts the user for input, allowing arbitrary (potentially asynchronous)
-- work until `on_confirm`.
--- @param opts any #(`table`) Additional options. See |input()|
---                   • prompt (string|nil) Text of the prompt
---                   • default (string|nil) Default reply to the input
---                   • completion (string|nil) Specifies type of completion
---                     supported for input. Supported types are the same that
---                     can be supplied to a user-defined command using the
---                     "-complete=" argument. See |:command-completion|
---                   • highlight (function) Function that will be used for
---                     highlighting user inputs.
--- @param on_confirm any #(`function`) ((input|nil) -> ()) Called once the user
---                   confirms or abort the input. `input` is what the user
---                   typed (it might be an empty string if nothing was
---                   entered), or `nil` if the user aborted the dialog.
function vim.input(opts, on_confirm) end

-- Get all the items at a given buffer position.
--- @param bufnr any #(`integer?`) defaults to the current buffer
--- @param row any #(`integer?`) row to inspect, 0-based. Defaults to the row of
---               the current cursor
--- @param col any #(`integer?`) col to inspect, 0-based. Defaults to the col of
---               the current cursor
--- @param filter any #(`table?`) a table with key-value pairs to filter the items
---               • syntax (boolean): include syntax based highlight groups
---                 (defaults to true)
---               • treesitter (boolean): include treesitter based highlight
---                 groups (defaults to true)
---               • extmarks (boolean|"all"): include extmarks. When `all`,
---                 then extmarks without a `hl_group` will also be included
---                 (defaults to true)
---               • semantic_tokens (boolean): include semantic tokens
---                 (defaults to true)
--- @return any #(`table`) a table with the following key-value pairs. Items are in
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
--- @param f any #(`any`) Any object
--- @return any #(`boolean`) `true` if `f` is callable, else `false`
function vim.is_callable(f) end

-- Concatenate directories and/or file paths into a single path with
-- normalization (e.g., `"foo/"` and `"bar"` get joined to `"foo/bar"`)
--- @vararg any #(`string`)
--- @return any #(`string`)
function vim.joinpath(...) end

-- Jumps within the active snippet in the given direction. If the jump isn't
-- possible, the function call does nothing.
--- @param direction any #(`vim.snippet.Direction`) Navigation direction. -1 for
---                  previous, 1 for next.
function vim.jump(direction) end

-- Returns `true` if there is an active snippet which can be jumped in the
-- given direction. You can use this function to navigate a snippet as
-- follows:
--- @param direction any #(`vim.snippet.Direction`) Navigation direction. -1 for
---                  previous, 1 for next.
--- @return any #(`boolean`)
function vim.jumpable(direction) end

-- Translates keycodes.
--- @param str any #(`string`) String to be converted.
--- @return any #(`string`)
function vim.keycode(str) end

-- TODO: generalize this, move to func.lua
--- @param versions any #(`Version[]`)
--- @return any #(`Version?`)
function vim.last(versions) end

-- Returns `true` if `v1 <= v2` . See |vim.version.cmp()| for usage.
--- @param v1 any #(`Version|number[]|string`)
--- @param v2 any #(`Version|number[]|string`)
--- @return any #(`boolean`)
function vim.le(v1, v2) end

-- Checks if a list-like table (integer keys without gaps) contains `value`.
--- @param t any #(`table`) Table to check (must be list-like, not validated)
--- @param value any #(`any`) Value to compare
--- @return any #(`boolean`) `true` if `t` contains `value`
function vim.list_contains(t, value) end

-- Extends a list-like table with the values of another list-like table.
--- @param dst any #(`table`) List which will be modified and appended to
--- @param src any #(`table`) List from which values will be inserted
--- @param start any #(`integer?`) Start index on src. Defaults to 1
--- @param finish any #(`integer?`) Final index on src. Defaults to `#src`
--- @return any #(`table`) dst
function vim.list_extend(dst, src, start, finish) end

-- Creates a copy of a table containing only elements from start to end
-- (inclusive)
--- @param list any[] #(`list`) Table
--- @param start any #(`integer?`) Start range of slice
--- @param finish any #(`integer?`) End range of slice
--- @return any #(`list`) Copy of table sliced from start to finish (inclusive)
function vim.list_slice(list, start, finish) end

-- LPeg is a new pattern-matching library for Lua, based on Parsing Expression
-- Grammars (PEGs).
function vim.lpeg() end

-- Returns `true` if `v1 < v2` . See |vim.version.cmp()| for usage.
--- @param v1 any #(`Version|number[]|string`)
--- @param v2 any #(`Version|number[]|string`)
--- @return any #(`boolean`)
function vim.lt(v1, v2) end

-- Omnifunc for completing Lua values from the runtime Lua interpreter,
-- similar to the builtin completion for the `:lua` command.
function vim.lua_omnifunc(find_start, _) end

-- Maps a table or other |iterable|.
--- @param f any #(`fun(...): any?`) Map function. Accepts the current iterator
---            or table values as arguments and returns one or more new
---            values. Nil values are removed from the final table.
--- @param src any #(`table|function`) Table or iterator function to filter
--- @return any #(`table`)
function vim.map(f, src, ...) end

-- Perform filetype detection.
--- @param args any[] #(`table`) Table specifying which matching strategy to use.
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
--- @return any #(`string?`) If a match was found, the matched filetype.
--- @return any #(`function?`) A function that modifies buffer state when called (for
---     example, to set some filetype specific buffer variables). The function
---     accepts a buffer number as its only argument.
function vim.match(args) end

-- Normalize a path to a standard format. A tilde (~) character at the
-- beginning of the path is expanded to the user's home directory and any
-- backslash (\) characters are converted to forward slashes (/). Environment
-- variables are also expanded.
--- @param path any #(`string`) Path to normalize
--- @param opts any #(`table?`) Options:
---             • expand_env: boolean Expand environment variables (default:
---               true)
--- @return any #(`string`) Normalized path
function vim.normalize(path, opts) end

-- Displays a notification to the user.
--- @param msg any #(`string`) Content of the notification to show to the user.
--- @param level any #(`integer?`) One of the values from |vim.log.levels|.
--- @param opts any #(`table?`) Optional parameters. Unused by default.
function vim.notify(msg, level, opts) end

-- Displays a notification only one time.
--- @param msg any #(`string`) Content of the notification to show to the user.
--- @param level any #(`integer?`) One of the values from |vim.log.levels|.
--- @param opts any #(`table?`) Optional parameters. Unused by default.
--- @return any #(`boolean`) true if message was displayed, else false
function vim.notify_once(msg, level, opts) end

-- Get or set |options|. Like `:set`. Invalid key is an error.
function vim.o() end

-- Adds Lua function {fn} with namespace id {ns_id} as a listener to every,
-- yes every, input key.
--- @param fn fun(...) #(`fun(key: string)?`) Function invoked on every key press.
---              |i_CTRL-V| Passing in nil when {ns_id} is specified removes
---              the callback associated with namespace {ns_id}.
--- @param ns_id any #(`integer?`) Namespace ID. If nil or 0, generates and returns
---              a new |nvim_create_namespace()| id.
--- @return any #(`integer`) Namespace id associated with {fn}. Or count of all
---     callbacks if on_key() is called without arguments.
function vim.on_key(fn, ns_id) end

-- Highlight the yanked text
--- @param opts any #(`table?`) Optional parameters
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
--- @param path any #(`string`) Path or URL to open
--- @return any #(`vim.SystemCompleted?`) Command result, or nil if not found.
--- @return any #(`string?`) Error message on failure
function vim.open(path) end

-- Iterate over all the parents of the given path.
--- @param start any #(`string`) Initial path.
--- @return any #(`fun(_, dir: string): string?`) Iterator
--- @return any #(`nil`)
--- @return any #(`string?`)
function vim.parents(start) end

-- Parses a semantic version string and returns a version object which can be
-- used with other `vim.version` functions. For example "1.0.1-rc1+build.2"
-- returns:
--- @param version any #(`string`) Version string to parse.
--- @param opts any #(`table?`) Optional keyword arguments:
---                • strict (boolean): Default false. If `true`, no coercion
---                  is attempted on input not conforming to semver v2.0.0. If
---                  `false`, `parse()` attempts to coerce input such as
---                  "1.0", "0-x", "tmux 3.2a" into valid versions.
--- @return any #(`Version?`) parsed_version Version object or `nil` if input is
---     invalid.
function vim.parse(version, opts) end

-- Paste handler, invoked by |nvim_paste()| when a conforming UI (such as the
-- |TUI|) pastes text into the editor.
--- @param lines any #(`string[]`) |readfile()|-style list of lines to paste.
---              |channel-lines|
--- @param phase any #(`-1|1|2|3`) -1: "non-streaming" paste: the call contains all
---              lines. If paste is "streamed", `phase` indicates
---              the stream state:
---              • 1: starts the paste (exactly once)
---              • 2: continues the paste (zero or more times)
---              • 3: ends the paste (exactly once)
--- @return any #(`boolean`) result false if client should cancel the paste.
function vim.paste(lines, phase) end

-- Escapes magic chars in |lua-patterns|.
--- @param s any #(`string`) String to escape
--- @return any #(`string`) %-escaped pattern string
function vim.pesc(s) end

-- "Pretty prints" the given arguments and returns them unmodified.
--- @return any #(`any`) given arguments.
function vim.print(...) end

-- Table with default priorities used for highlighting:
-- • `syntax`: `50`, used for standard syntax highlighting
-- • `treesitter`: `100`, used for treesitter-based highlighting
-- • `semantic_tokens`: `125`, used for LSP semantic token highlighting
-- • `diagnostics`: `150`, used for code analysis such as diagnostics
-- • `user`: `200`, used for user-triggered highlights such as LSP document
--   symbols or `on_yank` autocommands
function vim.priorities() end

-- Parses a semver |version-range| "spec" and returns a range object:
--- @param spec any #(`string`) Version range "spec"
function vim.range(spec) end

-- Attempt to read the file at {path} prompting the user if the file should
-- be trusted. The user's choice is persisted in a trust database at
-- $XDG_STATE_HOME/nvim/trust.
--- @param path any #(`string`) Path to a file to read.
--- @return any #(`string?`) The contents of the given file if it exists and is
---     trusted, or nil otherwise.
function vim.read(path) end

-- Parse the Vim regex {re} and return a regex object. Regexes are "magic"
-- and case-sensitive by default, regardless of 'magic' and 'ignorecase'.
-- They can be controlled with flags, see |/magic| and |/ignorecase|.
--- @param re any #(`string`)
--- @return any #(`vim.regex`)
function vim.regex(re) end

--- @class vim.regex
vim.regex = {}

-- Match line {line_idx} (zero-based) in buffer {bufnr}. If {start} and {end}
-- are supplied, match only this byte index range. Otherwise see
-- |regex:match_str()|. If {start} is used, then the returned byte indices
-- will be relative {start}.
--- @param bufnr any #(`integer`)
--- @param line_idx any #(`integer`)
--- @param start any #(`integer?`)
--- @param end_ any #(`integer?`)
function vim.regex:match_line(bufnr, line_idx, start, end_) end

-- Match the string against the regex. If the string should match the regex
-- precisely, surround the regex with `^` and `$` . If there was a match, the
-- byte indices for the beginning and end of the match are returned. When
-- there is no match, `nil` is returned. Because any integer is "truthy", `regex:match_str()` can
-- be directly used as a condition in an if-statement.
--- @param str any #(`string`)
function vim.regex:match_str(str) end

-- Gets a dict of line segment ("chunk") positions for the region from `pos1`
-- to `pos2`.
--- @param bufnr any #(`integer`) Buffer number, or 0 for current buffer
--- @param pos1 any #(`integer[]|string`) Start of region as a (line, column)
---                  tuple or |getpos()|-compatible string
--- @param pos2 any #(`integer[]|string`) End of region as a (line, column)
---                  tuple or |getpos()|-compatible string
--- @param regtype any #(`string`) |setreg()|-style selection type
--- @param inclusive any #(`boolean`) Controls whether the ending column is
---                  inclusive (see also 'selection').
--- @return any #(`table`) region Dict of the form `{linenr = {startcol,endcol}}`.
---     `endcol` is exclusive, and whole lines are returned as
---     `{startcol,endcol} = {0,-1}`.
function vim.region(bufnr, pos1, pos2, regtype, inclusive) end

-- Resets the cache for the path, or all the paths if path is nil.
--- @param path any #(`string?`) path to reset
function vim.reset(path) end

-- Create a ring buffer limited to a maximal number of items. Once the buffer
-- is full, adding a new entry overrides the oldest entry.
--- @param size any #(`integer`)
--- @return any #(`table`)
function vim.ringbuf(size) end

-- Sends {event} to {channel} via |RPC| and returns immediately. If {channel}
-- is 0, the event is broadcast to all channels.
--- @param channel any #(`integer`)
--- @param method any #(`string`)
--- @param args any[] #(`any[]?`)
--- @vararg any #(`any?`)
function vim.rpcnotify(channel, method, args, ...) end

-- Sends a request to {channel} to invoke {method} via |RPC| and blocks until
-- a response is received.
--- @param channel any #(`integer`)
--- @param method any #(`string`)
--- @param args any[] #(`any[]?`)
--- @vararg any #(`any?`)
function vim.rpcrequest(channel, method, args, ...) end

-- Schedules {fn} to be invoked soon by the main event-loop. Useful to avoid
-- |textlock| or other temporary restrictions.
--- @param fn fun(...) #(`function`)
function vim.schedule(fn) end

-- Returns a function which calls {fn} via |vim.schedule()|.
--- @param fn fun(...) #(`function`)
--- @return any #(`function`)
function vim.schedule_wrap(fn) end

-- Prompts the user to pick from a list of items, allowing arbitrary
-- (potentially asynchronous) work until `on_choice`.
--- @param items any #(`table`) Arbitrary items
--- @param opts any #(`table`) Additional options
---                  • prompt (string|nil) Text of the prompt. Defaults to
---                    `Select one of:`
---                  • format_item (function item -> text) Function to format
---                    an individual item from `items`. Defaults to
---                    `tostring`.
---                  • kind (string|nil) Arbitrary hint string indicating the
---                    item shape. Plugins reimplementing `vim.ui.select` may
---                    wish to use this to infer the structure or semantics of
---                    `items`, or the context in which select() was called.
--- @param on_choice any #(`function`) ((item|nil, idx|nil) -> ()) Called once the
---                  user made a choice. `idx` is the 1-based index of `item`
---                  within `items`. `nil` if the user aborted the dialog.
function vim.select(items, opts, on_choice) end

-- Adds a new |mapping|. Examples:
--- @param mode any #(`string|table`) Mode short-name, see |nvim_set_keymap()|. Can
---             also be list of modes to create mapping on multiple modes.
--- @param lhs any #(`string`) Left-hand side |{lhs}| of the mapping.
--- @param rhs any #(`string|function`) Right-hand side |{rhs}| of the mapping,
---             can be a Lua function.
--- @param opts any #(`table?`) Table of |:map-arguments|.
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

-- Sets a limit for the size of the backtrack stack used by LPeg to track
-- calls and choices. The default limit is `400`. Most well-written patterns
-- need little backtrack levels and therefore you seldom need to change this
-- limit; before changing it you should try to rewrite your pattern to avoid
-- the need for extra space. Nevertheless, a few useful patterns may
-- overflow. Also, with recursive grammars, subjects with deep recursion may
-- also need larger limits.
--- @param max any #(`integer`)
function vim.setmaxstack(max) end

-- Show all the items at a given buffer position.
--- @param bufnr any #(`integer?`) defaults to the current buffer
--- @param row any #(`integer?`) row to inspect, 0-based. Defaults to the row of
---               the current cursor
--- @param col any #(`integer?`) col to inspect, 0-based. Defaults to the col of
---               the current cursor
--- @param filter any #(`table?`) see |vim.inspect_pos()|
function vim.show_pos(bufnr, row, col, filter) end

-- Enumerates key-value pairs of a table, ordered by key.
--- @param t any #(`table`) Dict-like table
--- @return any #(`function`) |for-in| iterator over sorted keys and their values
function vim.spairs(t) end

-- Splits a string at each instance of a separator and returns the result as
-- a table (unlike |vim.gsplit()|).
--- @param s any #(`string`) String to split
--- @param sep any #(`string`) Separator or pattern
--- @param opts any #(`table?`) Keyword arguments |kwargs| accepted by
---             |vim.gsplit()|
--- @return any #(`string[]`) List of split components
function vim.split(s, sep, opts) end

-- Tests if `s` starts with `prefix`.
--- @param s any #(`string`) String
--- @param prefix any #(`string`) Prefix to match
--- @return any #(`boolean`) `true` if `prefix` is a prefix of `s`
function vim.startswith(s, prefix) end

-- Convert UTF-32 or UTF-16 {index} to byte index. If {use_utf16} is not
-- supplied, it defaults to false (use UTF-32). Returns the byte index.
--- @param str any #(`string`)
--- @param index any #(`number`)
--- @param use_utf16 any #(`any?`)
function vim.str_byteindex(str, index, use_utf16) end

-- Gets the distance (in bytes) from the last byte of the codepoint
-- (character) that {index} points to.
--- @param str any #(`string`)
--- @param index any #(`number`)
--- @return any #(`number`)
function vim.str_utf_end(str, index) end

-- Gets a list of the starting byte positions of each UTF-8 codepoint in the
-- given string.
--- @param str any #(`string`)
--- @return any #(`table`)
function vim.str_utf_pos(str) end

