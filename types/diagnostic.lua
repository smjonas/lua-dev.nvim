---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Configure diagnostic options globally or for a specific diagnostic
-- namespace.
--- @param opts any #(`table?`) When omitted or "nil", retrieve the current
---                  configuration. Otherwise, a configuration table with the
---                  following keys:
---                  • underline: (default true) Use underline for
---                    diagnostics. Options:
---                    • severity: Only underline diagnostics matching the
---                      given severity |diagnostic-severity|
---
---                  • virtual_text: (default true) Use virtual text for
---                    diagnostics. If multiple diagnostics are set for a
---                    namespace, one prefix per diagnostic + the last
---                    diagnostic message are shown. In addition to the
---                    options listed below, the "virt_text" options of
---                    |nvim_buf_set_extmark()| may also be used here (e.g.
---                    "virt_text_pos" and "hl_mode"). Options:
---                    • severity: Only show virtual text for diagnostics
---                      matching the given severity |diagnostic-severity|
---                    • source: (boolean or string) Include the diagnostic
---                      source in virtual text. Use "if_many" to only show
---                      sources if there is more than one diagnostic source
---                      in the buffer. Otherwise, any truthy value means to
---                      always show the diagnostic source.
---                    • spacing: (number) Amount of empty spaces inserted at
---                      the beginning of the virtual text.
---                    • prefix: (string or function) prepend diagnostic
---                      message with prefix. If a function, it must have the
---                      signature (diagnostic, i, total) -> string, where
---                      {diagnostic} is of type |diagnostic-structure|, {i}
---                      is the index of the diagnostic being evaluated, and
---                      {total} is the total number of diagnostics for the
---                      line. This can be used to render diagnostic symbols
---                      or error codes.
---                    • suffix: (string or function) Append diagnostic
---                      message with suffix. If a function, it must have the
---                      signature (diagnostic) -> string, where {diagnostic}
---                      is of type |diagnostic-structure|. This can be used
---                      to render an LSP diagnostic error code.
---                    • format: (function) A function that takes a diagnostic
---                      as input and returns a string. The return value is
---                      the text used to display the diagnostic. Example: >lua
---
---                          function(diagnostic)
---                            if diagnostic.severity == vim.diagnostic.severity.ERROR then
---                              return string.format("E: %s", diagnostic.message)
---                            end
---                            return diagnostic.message
---                          end
---
--- <
---
---                  • signs: (default true) Use signs for diagnostics
---                    |diagnostic-signs|. Options:
---                    • severity: Only show signs for diagnostics matching
---                      the given severity |diagnostic-severity|
---                    • priority: (number, default 10) Base priority to use
---                      for signs. When {severity_sort} is used, the priority
---                      of a sign is adjusted based on its severity.
---                      Otherwise, all signs use the same priority.
---                    • text: (table) A table mapping |diagnostic-severity|
---                      to the sign text to display in the sign column. The
---                      default is to use "E", "W", "I", and "H" for errors,
---                      warnings, information, and hints, respectively.
---                      Example: >lua
---
---                        vim.diagnostic.config({
---                          signs = { text = { [vim.diagnostic.severity.ERROR] = 'E', ... } }
---                        })
---
--- <
---                    • numhl: (table) A table mapping |diagnostic-severity|
---                      to the highlight group used for the line number where
---                      the sign is placed.
---                    • linehl: (table) A table mapping |diagnostic-severity|
---                      to the highlight group used for the whole line the
---                      sign is placed in.
---
---                  • float: Options for floating windows. See
---                    |vim.diagnostic.open_float()|.
---                  • update_in_insert: (default false) Update diagnostics in
---                    Insert mode (if false, diagnostics are updated on
---                    InsertLeave)
---                  • severity_sort: (default false) Sort diagnostics by
---                    severity. This affects the order in which signs and
---                    virtual text are displayed. When true, higher
---                    severities are displayed before lower severities (e.g.
---                    ERROR is displayed before WARN). Options:
---                    • reverse: (boolean) Reverse sort order
--- @param namespace any #(`integer?`) Update the options for the given namespace.
---                  When omitted, update the global diagnostic options.
--- @return any #(`table?`) table of current diagnostic config if `opts` is omitted.
function vim.diagnostic.config(opts, namespace) end

-- Get current diagnostics count.
--- @param bufnr any #(`integer?`) Buffer number to get diagnostics from. Use 0 for
---              current buffer or nil for all buffers.
--- @param opts any #(`table?`) A table with the following keys:
---              • namespace: (number) Limit diagnostics to the given
---                namespace.
---              • lnum: (number) Limit diagnostics to the given line number.
---              • severity: See |diagnostic-severity|.
--- @return any #(`table`) A table with actually present severity values as keys (see
---     |diagnostic-severity|) and integer counts as values.
function vim.diagnostic.count(bufnr, opts) end

-- Disable diagnostics in the given buffer.
--- @param bufnr any #(`integer?`) Buffer number, or 0 for current buffer. When
---                  omitted, disable diagnostics in all buffers.
--- @param namespace any #(`integer?`) Only disable diagnostics for the given
---                  namespace.
function vim.diagnostic.disable(bufnr, namespace) end

-- Enable diagnostics in the given buffer.
--- @param bufnr any #(`integer?`) Buffer number, or 0 for current buffer. When
---                  omitted, enable diagnostics in all buffers.
--- @param namespace any #(`integer?`) Only enable diagnostics for the given
---                  namespace.
function vim.diagnostic.enable(bufnr, namespace) end

-- Convert a list of quickfix items to a list of diagnostics.
--- @param list any[] #(`table[]`) List of quickfix items from |getqflist()| or
---             |getloclist()|.
--- @return any #(`Diagnostic[]`) array of |diagnostic-structure|
function vim.diagnostic.fromqflist(list) end

-- Get current diagnostics.
--- @param bufnr any #(`integer?`) Buffer number to get diagnostics from. Use 0 for
---              current buffer or nil for all buffers.
--- @param opts any #(`table?`) A table with the following keys:
---              • namespace: (number) Limit diagnostics to the given
---                namespace.
---              • lnum: (number) Limit diagnostics to the given line number.
---              • severity: See |diagnostic-severity|.
--- @return any #(`Diagnostic[]`) table A list of diagnostic items
---     |diagnostic-structure|. Keys `bufnr` , `end_lnum` , `end_col` , and `severity` are
---     guaranteed to be present.
function vim.diagnostic.get(bufnr, opts) end

-- Get namespace metadata.
--- @param namespace any #(`integer`) Diagnostic namespace
--- @return any #(`table`) Namespace metadata
function vim.diagnostic.get_namespace(namespace) end

-- Get current diagnostic namespaces.
--- @return any #(`table`) A list of active diagnostic namespaces |vim.diagnostic|.
function vim.diagnostic.get_namespaces() end

-- Get the next diagnostic closest to the cursor position.
--- @param opts any #(`table?`) See |vim.diagnostic.goto_next()|
--- @return any #(`Diagnostic?`) Next diagnostic
function vim.diagnostic.get_next(opts) end

-- Return the position of the next diagnostic in the current buffer.
--- @param opts any #(`table?`) See |vim.diagnostic.goto_next()|
--- @return any #(`table|false`) Next diagnostic position as a (row, col) tuple or
---     false if no next diagnostic.
function vim.diagnostic.get_next_pos(opts) end

-- Get the previous diagnostic closest to the cursor position.
--- @param opts any #(`table?`) See |vim.diagnostic.goto_next()|
--- @return any #(`Diagnostic?`) Previous diagnostic
function vim.diagnostic.get_prev(opts) end

-- Return the position of the previous diagnostic in the current buffer.
--- @param opts any #(`table?`) See |vim.diagnostic.goto_next()|
--- @return any #(`table|false`) Previous diagnostic position as a (row, col) tuple or
---     false if there is no prior diagnostic
function vim.diagnostic.get_prev_pos(opts) end

-- Move to the next diagnostic.
--- @param opts any #(`table?`) Configuration table with the following keys:
---             • namespace: (number) Only consider diagnostics from the given
---               namespace.
---             • cursor_position: (cursor position) Cursor position as a
---               (row, col) tuple. See |nvim_win_get_cursor()|. Defaults to
---               the current cursor position.
---             • wrap: (boolean, default true) Whether to loop around file or
---               not. Similar to 'wrapscan'.
---             • severity: See |diagnostic-severity|.
---             • float: (boolean or table, default true) If "true", call
---               |vim.diagnostic.open_float()| after moving. If a table, pass
---               the table as the {opts} parameter to
---               |vim.diagnostic.open_float()|. Unless overridden, the float
---               will show diagnostics at the new cursor position (as if
---               "cursor" were passed to the "scope" option).
---             • win_id: (number, default 0) Window ID
function vim.diagnostic.goto_next(opts) end

-- Move to the previous diagnostic in the current buffer.
--- @param opts any #(`table?`) See |vim.diagnostic.goto_next()|
function vim.diagnostic.goto_prev(opts) end

-- Hide currently displayed diagnostics.
--- @param namespace any #(`integer?`) Diagnostic namespace. When omitted, hide
---                  diagnostics from all namespaces.
--- @param bufnr any #(`integer?`) Buffer number, or 0 for current buffer. When
---                  omitted, hide diagnostics in all buffers.
function vim.diagnostic.hide(namespace, bufnr) end

-- Check whether diagnostics are disabled in a given buffer.
--- @param bufnr any #(`integer?`) Buffer number, or 0 for current buffer.
--- @param namespace any #(`integer?`) Diagnostic namespace. When omitted, checks if
---                  all diagnostics are disabled in {bufnr}. Otherwise, only
---                  checks if diagnostics from {namespace} are disabled.
--- @return any #(`boolean`)
function vim.diagnostic.is_disabled(bufnr, namespace) end

-- Parse a diagnostic from a string.
--- @param str any #(`string`) String to parse diagnostics from.
--- @param pat any #(`string`) Lua pattern with capture groups.
--- @param groups any #(`table`) List of fields in a |diagnostic-structure|
---                     to associate with captures from {pat}.
--- @param severity_map any #(`table`) A table mapping the severity field from
---                     {groups} with an item from |vim.diagnostic.severity|.
--- @param defaults any #(`table?`) Table of default values for any fields not
---                     listed in {groups}. When omitted, numeric values
---                     default to 0 and "severity" defaults to ERROR.
--- @return any #(`Diagnostic?`) |diagnostic-structure| or `nil` if {pat} fails to match
---     {str}.
function vim.diagnostic.match(str, pat, groups, severity_map, defaults) end

-- Show diagnostics in a floating window.
--- @param opts any #(`table?`) Configuration table with the same keys as
---             |vim.lsp.util.open_floating_preview()| in addition to the
---             following:
---             • bufnr: (number) Buffer number to show diagnostics from.
---               Defaults to the current buffer.
---             • namespace: (number) Limit diagnostics to the given namespace
---             • scope: (string, default "line") Show diagnostics from the
---               whole buffer ("buffer"), the current cursor line ("line"),
---               or the current cursor position ("cursor"). Shorthand
---               versions are also accepted ("c" for "cursor", "l" for
---               "line", "b" for "buffer").
---             • pos: (number or table) If {scope} is "line" or "cursor", use
---               this position rather than the cursor position. If a number,
---               interpreted as a line number; otherwise, a (row, col) tuple.
---             • severity_sort: (default false) Sort diagnostics by severity.
---               Overrides the setting from |vim.diagnostic.config()|.
---             • severity: See |diagnostic-severity|. Overrides the setting
---               from |vim.diagnostic.config()|.
---             • header: (string or table) String to use as the header for
---               the floating window. If a table, it is interpreted as a
---               [text, hl_group] tuple. Overrides the setting from
---               |vim.diagnostic.config()|.
---             • source: (boolean or string) Include the diagnostic source in
---               the message. Use "if_many" to only show sources if there is
---               more than one source of diagnostics in the buffer.
---               Otherwise, any truthy value means to always show the
---               diagnostic source. Overrides the setting from
---               |vim.diagnostic.config()|.
---             • format: (function) A function that takes a diagnostic as
---               input and returns a string. The return value is the text
---               used to display the diagnostic. Overrides the setting from
---               |vim.diagnostic.config()|.
---             • prefix: (function, string, or table) Prefix each diagnostic
---               in the floating window. If a function, it must have the
---               signature (diagnostic, i, total) -> (string, string), where
---               {i} is the index of the diagnostic being evaluated and
---               {total} is the total number of diagnostics displayed in the
---               window. The function should return a string which is
---               prepended to each diagnostic in the window as well as an
---               (optional) highlight group which will be used to highlight
---               the prefix. If {prefix} is a table, it is interpreted as a
---               [text, hl_group] tuple as in |nvim_echo()|; otherwise, if
---               {prefix} is a string, it is prepended to each diagnostic in
---               the window with no highlight. Overrides the setting from
---               |vim.diagnostic.config()|.
---             • suffix: Same as {prefix}, but appends the text to the
---               diagnostic instead of prepending it. Overrides the setting
---               from |vim.diagnostic.config()|.
--- @return any #(`integer?, integer?`) ({float_bufnr}, {win_id})
function vim.diagnostic.open_float(opts, ...) end

-- Remove all diagnostics from the given namespace.
--- @param namespace any #(`integer?`) Diagnostic namespace. When omitted, remove
---                  diagnostics from all namespaces.
--- @param bufnr any #(`integer?`) Remove diagnostics for the given buffer.
---                  When omitted, diagnostics are removed for all buffers.
function vim.diagnostic.reset(namespace, bufnr) end

-- Set diagnostics for the given namespace and buffer.
--- @param namespace any #(`integer`) The diagnostic namespace
--- @param bufnr any #(`integer`) Buffer number
--- @param diagnostics any #(`table`) A list of diagnostic items
---                    |diagnostic-structure|
--- @param opts any #(`table?`) Display options to pass to
---                    |vim.diagnostic.show()|
function vim.diagnostic.set(namespace, bufnr, diagnostics, opts) end

-- Add buffer diagnostics to the location list.
--- @param opts any #(`table?`) Configuration table with the following keys:
---             • namespace: (number) Only add diagnostics from the given
---               namespace.
---             • winnr: (number, default 0) Window number to set location
---               list for.
---             • open: (boolean, default true) Open the location list after
---               setting.
---             • title: (string) Title of the location list. Defaults to
---               "Diagnostics".
---             • severity: See |diagnostic-severity|.
function vim.diagnostic.setloclist(opts) end

-- Add all diagnostics to the quickfix list.
--- @param opts any #(`table?`) Configuration table with the following keys:
---             • namespace: (number) Only add diagnostics from the given
---               namespace.
---             • open: (boolean, default true) Open quickfix list after
---               setting.
---             • title: (string) Title of quickfix list. Defaults to
---               "Diagnostics".
---             • severity: See |diagnostic-severity|.
function vim.diagnostic.setqflist(opts) end

-- Display diagnostics for the given namespace and buffer.
--- @param namespace any #(`integer?`) Diagnostic namespace. When omitted, show
---                    diagnostics from all namespaces.
--- @param bufnr any #(`integer?`) Buffer number, or 0 for current buffer.
---                    When omitted, show diagnostics in all buffers.
--- @param diagnostics any #(`table?`) The diagnostics to display. When omitted,
---                    use the saved diagnostics for the given namespace and
---                    buffer. This can be used to display a list of
---                    diagnostics without saving them or to display only a
---                    subset of diagnostics. May not be used when {namespace}
---                    or {bufnr} is nil.
--- @param opts any #(`table?`) Display options. See
---                    |vim.diagnostic.config()|.
function vim.diagnostic.show(namespace, bufnr, diagnostics, opts) end

-- Convert a list of diagnostics to a list of quickfix items that can be
-- passed to |setqflist()| or |setloclist()|.
--- @param diagnostics any #(`table`) List of diagnostics |diagnostic-structure|.
--- @return any #(`table[]`) of quickfix list items |setqflist-what|
function vim.diagnostic.toqflist(diagnostics) end

