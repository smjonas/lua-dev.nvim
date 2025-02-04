---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @class vim.treesitter.LanguageTree
vim.treesitter.LanguageTree = {}

-- Returns a map of language to child tree.
function vim.treesitter.LanguageTree:children() end

-- Determines whether {range} is contained in the |LanguageTree|.
--- @param range any #(`Range4`) `{ start_line, start_col, end_line, end_col }`
--- @return any #(`boolean`)
function vim.treesitter.LanguageTree:contains(range) end

-- Destroys this |LanguageTree| and all its children.
function vim.treesitter.LanguageTree:destroy() end

-- Invokes the callback for each |LanguageTree| recursively.
--- @param fn fun(...) #(`fun(tree: TSTree, ltree: LanguageTree)`)
function vim.treesitter.LanguageTree:for_each_tree(fn) end

-- Gets the set of included regions managed by this LanguageTree . This can be
-- different from the regions set by injection query, because a partial
-- |LanguageTree:parse()| drops the regions outside the requested range.
--- @return any #(`table<integer, Range6[]>`)
function vim.treesitter.LanguageTree:included_regions() end

-- Invalidates this parser and all its children
--- @param reload any #(`boolean?`)
function vim.treesitter.LanguageTree:invalidate(reload) end

-- Returns whether this LanguageTree is valid, i.e., |LanguageTree:trees()|
-- reflects the latest state of the source. If invalid, user should call
-- |LanguageTree:parse()|.
--- @param exclude_children any #(`boolean?`) whether to ignore the validity of
---                         children (default `false`)
--- @return any #(`boolean`)
function vim.treesitter.LanguageTree:is_valid(exclude_children) end

-- Gets the language of this tree node.
function vim.treesitter.LanguageTree:lang() end

-- Gets the appropriate language that contains {range}.
--- @param range any #(`Range4`) `{ start_line, start_col, end_line, end_col }`
--- @return any #(`LanguageTree`) Managing {range}
function vim.treesitter.LanguageTree:language_for_range(range) end

-- Gets the smallest named node that contains {range}.
--- @param range any #(`Range4`) `{ start_line, start_col, end_line, end_col }`
--- @param opts any #(`table?`) Optional keyword arguments:
---              • ignore_injections boolean Ignore injected languages
---                (default true)
--- @return any #(`TSNode?`) Found node
function vim.treesitter.LanguageTree:named_node_for_range(range, opts) end

-- Recursively parse all regions in the language tree using
-- |treesitter-parsers| for the corresponding languages and run injection
-- queries on the parsed trees to determine whether child trees should be
-- created and parsed.
--- @param range any #(`boolean|Range?`) Parse this range in the parser's source.
---              Set to `true` to run a complete parse of the source (Note:
---              Can be slow!) Set to `false|nil` to only parse regions with
---              empty ranges (typically only the root tree without
---              injections).
--- @return any #(`table<integer, TSTree>`)
function vim.treesitter.LanguageTree:parse(range) end

-- Registers callbacks for the |LanguageTree|.
--- @param cbs any #(`table`) An |nvim_buf_attach()|-like table argument with
---                  the following handlers:
---                  • `on_bytes` : see |nvim_buf_attach()|, but this will be
---                    called after the parsers callback.
---                  • `on_changedtree` : a callback that will be called every
---                    time the tree has syntactical changes. It will be
---                    passed two arguments: a table of the ranges (as node
---                    ranges) that changed and the changed tree.
---                  • `on_child_added` : emitted when a child is added to the
---                    tree.
---                  • `on_child_removed` : emitted when a child is removed
---                    from the tree.
---                  • `on_detach` : emitted when the buffer is detached, see
---                    |nvim_buf_detach_event|. Takes one argument, the number
---                    of the buffer.
--- @param recursive any #(`boolean?`) Apply callbacks recursively for all
---                  children. Any new children will also inherit the
---                  callbacks.
function vim.treesitter.LanguageTree:register_cbs(cbs, recursive) end

-- Returns the source content of the language tree (bufnr or string).
function vim.treesitter.LanguageTree:source() end

-- Gets the tree that contains {range}.
--- @param range any #(`Range4`) `{ start_line, start_col, end_line, end_col }`
--- @param opts any #(`table?`) Optional keyword arguments:
---              • ignore_injections boolean Ignore injected languages
---                (default true)
--- @return any #(`TSTree?`)
function vim.treesitter.LanguageTree:tree_for_range(range, opts) end

-- Returns all trees of the regions parsed by this parser. Does not include
-- child languages. The result is list-like if
-- • this LanguageTree is the root, in which case the result is empty or a
--   singleton list; or
-- • the root LanguageTree is fully parsed.
--- @return any #(`table<integer, TSTree>`)
function vim.treesitter.LanguageTree:trees() end

--- @class vim.treesitter.Query
vim.treesitter.Query = {}

-- Iterate over all captures from all matches inside {node}
--- @param node any #(`TSNode`) under which the search will occur
--- @param source any #(`integer|string`) Source buffer or string to extract text
---               from
--- @param start any #(`integer?`) Starting line for the search. Defaults to
---               `node:start()`.
--- @param stop any #(`integer?`) Stopping line for the search (end-exclusive).
---               Defaults to `node:end_()`.
--- @return any #(`fun(end_line: integer?): integer, TSNode, TSMetadata`) capture id,
---     capture node, metadata
function vim.treesitter.Query:iter_captures(node, source, start, stop) end

-- Iterates the matches of self on a given range.
--- @param node any #(`TSNode`) under which the search will occur
--- @param source any #(`integer|string`) Source buffer or string to search
--- @param start any #(`integer?`) Starting line for the search. Defaults to
---               `node:start()`.
--- @param stop any #(`integer?`) Stopping line for the search (end-exclusive).
---               Defaults to `node:end_()`.
--- @param opts any #(`table?`) Optional keyword arguments:
---               • max_start_depth (integer) if non-zero, sets the maximum
---                 start depth for each match. This is used to prevent
---                 traversing too deep into a tree.
---               • all (boolean) When set, the returned match table maps
---                 capture IDs to a list of nodes. Older versions of
---                 iter_matches incorrectly mapped capture IDs to a single
---                 node, which is incorrect behavior. This option will
---                 eventually become the default and removed.
--- @return any #(`fun(): integer, table<integer, TSNode[]>, table`) pattern id, match,
---     metadata
function vim.treesitter.Query:iter_matches(node, source, start, stop, opts) end

-- Load parser with name {lang}
--- @param lang any #(`string`) Name of the parser (alphanumerical and `_` only)
--- @param opts any #(`table?`) Options:
---             • filetype (string|string[]) Default filetype the parser
---               should be associated with. Defaults to {lang}.
---             • path (string|nil) Optional path the parser is located at
---             • symbol_name (string|nil) Internal symbol name for the
---               language to load
function vim.treesitter.add(lang, opts) end

-- Adds a new directive to be used in queries
--- @param name any #(`string`) Name of the directive, without leading #
--- @param handler any #(`function`)
---                • match: A table mapping capture IDs to a list of captured
---                  nodes
---                • pattern: the index of the matching pattern in the query
---                  file
---                • predicate: list of strings containing the full directive
---                  being called, e.g. `(node (#set! conceal "-"))` would get
---                  the predicate `{ "#set!", "conceal", "-" }`
--- @param opts any #(`table<string, any>`) Optional options:
---                • force (boolean): Override an existing predicate of the
---                  same name
---                • all (boolean): Use the correct implementation of the
---                  match table where capture IDs map to a list of nodes
---                  instead of a single node. Defaults to false (for backward
---                  compatibility). This option will eventually become the
---                  default and removed.
function vim.treesitter.add_directive(name, handler, opts) end

-- Adds a new predicate to be used in queries
--- @param name any #(`string`) Name of the predicate, without leading #
--- @param handler any #(`function`)
---                • see |vim.treesitter.query.add_directive()| for argument
---                  meanings
--- @param opts any #(`table<string, any>`) Optional options:
---                • force (boolean): Override an existing predicate of the
---                  same name
---                • all (boolean): Use the correct implementation of the
---                  match table where capture IDs map to a list of nodes
---                  instead of a single node. Defaults to false (for backward
---                  compatibility). This option will eventually become the
---                  default and removed.
function vim.treesitter.add_predicate(name, handler, opts) end

-- Opens a live editor to query the buffer you started from.
--- @param lang any #(`string?`) language to open the query editor for. If omitted,
---             inferred from the current buffer's filetype.
function vim.treesitter.edit(lang) end

-- Returns the runtime query {query_name} for {lang}.
--- @param lang any #(`string`) Language to use for the query
--- @param query_name any #(`string`) Name of the query (e.g. "highlights")
--- @return any #(`vim.treesitter.Query?`) Parsed query. `nil` if no query files are
---     found.
function vim.treesitter.get(lang, query_name) end

-- Gets the list of files used to make up a query
--- @param lang any #(`string`) Language to get query for
--- @param query_name any #(`string`) Name of the query to load (e.g.,
---                    "highlights")
--- @param is_included any #(`boolean?`) Internal parameter, most of the time left
---                    as `nil`
--- @return any #(`string[]`) query_files List of files to load for given query and
---     language
function vim.treesitter.get_files(lang, query_name, is_included) end

-- Get the filetypes associated with the parser named {lang}.
--- @param lang any #(`string`) Name of parser
--- @return any #(`string[]`) filetypes
function vim.treesitter.get_filetypes(lang) end

--- @param filetype any #(`string`)
--- @return any #(`string?`)
function vim.treesitter.get_lang(filetype) end

-- Inspects the provided language.
--- @param lang any #(`string`) Language
--- @return any #(`table`)
function vim.treesitter.inspect(lang) end

-- Lint treesitter queries using installed parser, or clear lint errors.
--- @param buf any #(`integer`) Buffer handle
--- @param opts any #(`table?`) Optional keyword arguments:
---             • langs (string|string[]|nil) Language(s) to use for checking
---               the query. If multiple languages are specified, queries are
---               validated for all of them
---             • clear (boolean) if `true`, just clear current lint errors
function vim.treesitter.lint(buf, opts) end

-- Lists the currently available directives to use in queries.
--- @return any #(`string[]`) List of supported directives.
function vim.treesitter.list_directives() end

-- Lists the currently available predicates to use in queries.
--- @return any #(`string[]`) List of supported predicates.
function vim.treesitter.list_predicates() end

-- Omnifunc for completing node names and predicates in treesitter queries.
function vim.treesitter.omnifunc(findstart, base) end

-- Parse {query} as a string. (If the query is in a file, the caller should
-- read the contents into a string before calling).
--- @param lang any #(`string`) Language to use for the query
--- @param query any #(`string`) Query in s-expr syntax
--- @return any #(`vim.treesitter.Query`) Parsed query
function vim.treesitter.parse(lang, query) end

-- Register a parser named {lang} to be used for {filetype}(s).
--- @param lang any #(`string`) Name of parser
--- @param filetype any #(`string|string[]`) Filetype(s) to associate with lang
function vim.treesitter.register(lang, filetype) end

-- Sets the runtime query named {query_name} for {lang}
--- @param lang any #(`string`) Language to use for the query
--- @param query_name any #(`string`) Name of the query (e.g., "highlights")
--- @param text any #(`string`) Query text (unparsed).
function vim.treesitter.set(lang, query_name, text) end

