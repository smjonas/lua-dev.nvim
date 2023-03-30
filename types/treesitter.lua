---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @class vim.treesitter.LanguageTree
vim.treesitter.LanguageTree = {}

-- Returns a map of language to child tree.
function vim.treesitter.LanguageTree:children() end

-- Determines whether {range} is contained in the |LanguageTree|.
--- @param range any #(table) `{ start_line, start_col, end_line, end_col }`
--- @return any #(boolean)
function vim.treesitter.LanguageTree:contains(range) end

-- Destroys this |LanguageTree| and all its children.
function vim.treesitter.LanguageTree:destroy() end

-- Invokes the callback for each |LanguageTree| and its children recursively
--- @param fn fun(...) #fun(tree: LanguageTree, lang: string)
--- @param include_self any #(boolean|nil) Whether to include the invoking tree in
---                     the results
function vim.treesitter.LanguageTree:for_each_child(fn, include_self) end

-- Invokes the callback for each |LanguageTree| recursively.
--- @param fn fun(...) #fun(tree: TSTree, ltree: LanguageTree)
function vim.treesitter.LanguageTree:for_each_tree(fn) end

-- Gets the set of included regions
--- @return any #integer[][]
function vim.treesitter.LanguageTree:included_regions() end

-- Invalidates this parser and all its children
--- @param reload any #(boolean|nil)
function vim.treesitter.LanguageTree:invalidate(reload) end

-- Determines whether this tree is valid. If the tree is invalid, call `parse()` . This will return the updated tree.
--- @param exclude_children any #(boolean|nil)
--- @return any #(boolean)
function vim.treesitter.LanguageTree:is_valid(exclude_children) end

-- Gets the language of this tree node.
function vim.treesitter.LanguageTree:lang() end

-- Gets the appropriate language that contains {range}.
--- @param range any #(table) `{ start_line, start_col, end_line, end_col }`
--- @return any #|LanguageTree| Managing {range}
function vim.treesitter.LanguageTree:language_for_range(range) end

-- Gets the smallest named node that contains {range}.
--- @param range any #(table) `{ start_line, start_col, end_line, end_col }`
--- @param opts any #(table|nil) Optional keyword arguments:
---              • ignore_injections boolean Ignore injected languages
---                (default true)
--- @return any #|TSNode| | nil Found node
function vim.treesitter.LanguageTree:named_node_for_range(range, opts) end

-- Parses all defined regions using a treesitter parser for the language this
-- tree represents. This will run the injection query for this language to
-- determine if any child languages should be created.
--- @return any #TSTree[]
function vim.treesitter.LanguageTree:parse() end

-- Registers callbacks for the |LanguageTree|.
--- @param cbs any #(table) An |nvim_buf_attach()|-like table argument with the
---             following handlers:
---             • `on_bytes` : see |nvim_buf_attach()|, but this will be called after the parsers callback.
---             • `on_changedtree` : a callback that will be called every time
---               the tree has syntactical changes. It will only be passed one
---               argument, which is a table of the ranges (as node ranges)
---               that changed.
---             • `on_child_added` : emitted when a child is added to the
---               tree.
---             • `on_child_removed` : emitted when a child is removed from
---               the tree.
function vim.treesitter.LanguageTree:register_cbs(cbs) end

-- Returns the source content of the language tree (bufnr or string).
function vim.treesitter.LanguageTree:source() end

-- Gets the tree that contains {range}.
--- @param range any #(table) `{ start_line, start_col, end_line, end_col }`
--- @param opts any #(table|nil) Optional keyword arguments:
---              • ignore_injections boolean Ignore injected languages
---                (default true)
--- @return any #TSTree|nil
function vim.treesitter.LanguageTree:tree_for_range(range, opts) end

-- Returns all trees this language tree contains. Does not include child
-- languages.
function vim.treesitter.LanguageTree:trees() end

--- @class vim.treesitter.Query
vim.treesitter.Query = {}

-- Iterate over all captures from all matches inside {node}
--- @param node any #|TSNode| under which the search will occur
--- @param source any #(integer|string) Source buffer or string to extract text
---               from
--- @param start any #(integer) Starting line for the search
--- @param stop any #(integer) Stopping line for the search (end-exclusive)
--- @return any #(fun(): integer, TSNode, TSMetadata): capture id, capture node,
---     metadata
function vim.treesitter.Query:iter_captures(node, source, start, stop) end

-- Iterates the matches of self on a given range.
--- @param node any #|TSNode| under which the search will occur
--- @param source any #(integer|string) Source buffer or string to search
--- @param start any #(integer) Starting line for the search
--- @param stop any #(integer) Stopping line for the search (end-exclusive)
--- @return any #(fun(): integer, table<integer,TSNode>, table): pattern id, match,
---     metadata
function vim.treesitter.Query:iter_matches(node, source, start, stop) end

--- @class vim.treesitter.TSHighlighter
vim.treesitter.TSHighlighter = {}

-- Removes all internal references to the highlighter
function vim.treesitter.TSHighlighter:destroy() end

-- Load parser with name {lang}
--- @param lang any #(string) Name of the parser (alphanumerical and `_` only)
--- @param opts any #(table|nil) Options:
---             • filetype (string|string[]) Default filetype the parser
---               should be associated with. Defaults to {lang}.
---             • path (string|nil) Optional path the parser is located at
---             • symbol_name (string|nil) Internal symbol name for the
---               language to load
function vim.treesitter.add(lang, opts) end

-- Adds a new directive to be used in queries
--- @param name any #(string) Name of the directive, without leading #
--- @param handler any #function(match:table<string,|TSNode|>, pattern:string,
---                bufnr:integer, predicate:string[], metadata:table)
---                • match: see |treesitter-query|
---                  • node-level data are accessible via `match[capture_id]`
---
---                • pattern: see |treesitter-query|
---                • predicate: list of strings containing the full directive
---                  being called, e.g. `(node (#set! conceal "-"))` would get
---                  the predicate `{ "#set!", "conceal", "-" }`
--- @param force any #(boolean|nil)
function vim.treesitter.add_directive(name, handler, force) end

-- Adds a new predicate to be used in queries
--- @param name any #(string) Name of the predicate, without leading #
--- @param handler any #function(match:table<string,|TSNode|>, pattern:string,
---                bufnr:integer, predicate:string[])
---                • see |vim.treesitter.query.add_directive()| for argument
---                  meanings
--- @param force any #(boolean|nil)
function vim.treesitter.add_predicate(name, handler, force) end

-- Returns the runtime query {query_name} for {lang}.
--- @param lang any #(string) Language to use for the query
--- @param query_name any #(string) Name of the query (e.g. "highlights")
--- @return any #Query|nil Parsed query
function vim.treesitter.get(lang, query_name) end

-- Gets the list of files used to make up a query
--- @param lang any #(string) Language to get query for
--- @param query_name any #(string) Name of the query to load (e.g., "highlights")
--- @param is_included any #(boolean|nil) Internal parameter, most of the time left
---                    as `nil`
--- @return any #string[] query_files List of files to load for given query and
---     language
function vim.treesitter.get_files(lang, query_name, is_included) end

-- Get the filetypes associated with the parser named {lang}.
--- @param lang any #string Name of parser
--- @return any #string[] filetypes
function vim.treesitter.get_filetypes(lang) end

--- @param filetype any #string
--- @return any #string|nil
function vim.treesitter.get_lang(filetype) end

-- Inspects the provided language.
--- @param lang any #(string) Language
--- @return any #(table)
function vim.treesitter.inspect(lang) end

-- Lists the currently available directives to use in queries.
--- @return any #string[] List of supported directives.
function vim.treesitter.list_directives() end

-- Lists the currently available predicates to use in queries.
--- @return any #string[] List of supported predicates.
function vim.treesitter.list_predicates() end

-- Parse {query} as a string. (If the query is in a file, the caller should
-- read the contents into a string before calling).
--- @param lang any #(string) Language to use for the query
--- @param query any #(string) Query in s-expr syntax
--- @return any #Query Parsed query
function vim.treesitter.parse(lang, query) end

-- Register a parser named {lang} to be used for {filetype}(s).
--- @param lang any #string Name of parser
--- @param filetype any #string|string[] Filetype(s) to associate with lang
function vim.treesitter.register(lang, filetype) end

-- Sets the runtime query named {query_name} for {lang}
--- @param lang any #(string) Language to use for the query
--- @param query_name any #(string) Name of the query (e.g., "highlights")
--- @param text any #(string) Query text (unparsed).
function vim.treesitter.set(lang, query_name, text) end

