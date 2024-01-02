---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- LSP method names.
function vim.lsp.Methods() end

-- Add the folder at path to the workspace folders. If {path} is not
-- provided, the user will be prompted for a path using |input()|.
function vim.lsp.add_workspace_folder(workspace_folder) end

-- Applies a `TextDocumentEdit`, which is a list of changes to a single
-- document.
--- @param text_document_edit any #(table) a `TextDocumentEdit` object
--- @param index any #(integer) Optional index of the edit, if from a
---                           list of edits (or nil, if not from a list)
function vim.lsp.apply_text_document_edit(text_document_edit, index, offset_encoding) end

-- Applies a list of text edits to a buffer.
--- @param text_edits any #(table) list of `TextEdit` objects
--- @param bufnr any #(integer) Buffer id
--- @param offset_encoding any #(string) utf-8|utf-16|utf-32
function vim.lsp.apply_text_edits(text_edits, bufnr, offset_encoding) end

-- Applies a `WorkspaceEdit`.
--- @param workspace_edit any #(table) `WorkspaceEdit`
--- @param offset_encoding any #(string) utf-8|utf-16|utf-32 (required)
function vim.lsp.apply_workspace_edit(workspace_edit, offset_encoding) end

-- Removes document highlights from a buffer.
--- @param bufnr any #(integer|nil) Buffer id
function vim.lsp.buf_clear_references(bufnr) end

-- Shows a list of document highlights for a certain buffer.
--- @param bufnr any #(integer) Buffer id
--- @param references any #(table) List of `DocumentHighlight` objects to
---                        highlight
--- @param offset_encoding any #(string) One of "utf-8", "utf-16", "utf-32".
function vim.lsp.buf_highlight_references(bufnr, references, offset_encoding) end

-- Returns the UTF-32 and UTF-16 offsets for a position in a certain buffer.
--- @param buf any #(integer) buffer number (0 for current)
--- @param row any #0-indexed line
--- @param col any #0-indexed byte offset in line
--- @param offset_encoding any #(string) utf-8|utf-16|utf-32 defaults to
---                        `offset_encoding` of first client of `buf`
--- @return any #(integer) `offset_encoding` index of the character in line {row}
---     column {col} in buffer {buf}
function vim.lsp.character_offset(buf, row, col, offset_encoding) end

-- Clear the lenses
--- @param client_id any #(integer|nil) filter by client_id. All clients if nil
--- @param bufnr any #(integer|nil) filter by buffer. All buffers if nil
function vim.lsp.clear(client_id, bufnr) end

function vim.lsp.clear_references() end

-- Selects a code action available at the current cursor position.
--- @param options any #(table|nil) Optional table which holds the following
---                optional fields:
---                • context: (table|nil) Corresponds to `CodeActionContext` of the LSP specification:
---                  • diagnostics (table|nil): LSP `Diagnostic[]`. Inferred
---                    from the current position if not provided.
---                  • only (table|nil): List of LSP `CodeActionKind`s used to
---                    filter the code actions. Most language servers support
---                    values like `refactor` or `quickfix`.
---                  • triggerKind (number|nil): The reason why code actions
---                    were requested.
---
---                • filter: (function|nil) Predicate taking an `CodeAction`
---                  and returning a boolean.
---                • apply: (boolean|nil) When set to `true`, and there is
---                  just one remaining action (after filtering), the action
---                  is applied without user query.
---                • range: (table|nil) Range for which code actions should be
---                  requested. If in visual mode this defaults to the active
---                  selection. Table must contain `start` and `end` keys with
---                  {row,col} tuples using mark-like indexing. See
---                  |api-indexing|
function vim.lsp.code_action(options) end

-- Retrieves the completion items at the current cursor position. Can only be
-- called in Insert mode.
--- @param context any #(table) (context support not yet implemented) Additional
---                information about the context in which a completion was
---                triggered (how it was triggered, and by which trigger
---                character, if applicable)
function vim.lsp.completion(context) end

-- Returns the range table for the difference between prev and curr lines
--- @return any #lsp.TextDocumentContentChangeEvent : see https://microsoft.github.io/language-server-protocol/specification/#textDocumentContentChangeEvent
function vim.lsp.compute_diff(___MissingCloseParenHere___) end

-- Create a LSP RPC client factory that connects via TCP to the given host
-- and port
--- @param host any #(string) host to connect to
--- @param port any #(integer) port to connect to
--- @return any #fun(dispatchers: vim.lsp.rpc.Dispatchers ): vim.lsp.rpc.PublicClient function intended to be passed to |vim.lsp.start_client()| or
---     |vim.lsp.start()| on the field cmd
function vim.lsp.connect(host, port) end

-- Converts any of `MarkedString` | `MarkedString[]` | `MarkupContent` into a
-- list of lines containing valid markdown. Useful to populate the hover
-- window for `textDocument/hover`, for parsing the result of
-- `textDocument/signatureHelp`, and potentially others.
--- @param input any #(`MarkedString` | `MarkedString[]` | `MarkupContent`)
--- @param contents any #(table|nil) List of strings to extend with converted
---                 lines. Defaults to {}.
--- @return any #string[] extended with lines of converted markdown.
function vim.lsp.convert_input_to_markdown_lines(input, contents) end

-- Converts `textDocument/signatureHelp` response to markdown lines.
--- @param signature_help any #(table) Response of `textDocument/SignatureHelp`
--- @param ft any #(string|nil) filetype that will be use as the `lang`
---                       for the label markdown code block
--- @param triggers any #(table|nil) list of trigger characters from the lsp
---                       server. used to better determine parameter offsets
--- @return any #(table|nil) table list of lines of converted markdown.
--- @return any #(table|nil) table of active hl
function vim.lsp.convert_signature_help_to_markdown_lines(signature_help, ft, triggers) end

-- Jumps to the declaration of the symbol under the cursor.
--- @param options any #(table|nil) additional options
---                • reuse_win: (boolean) Jump to existing window if buffer is
---                  already open.
---                • on_list: (function) |lsp-on-list-handler| replacing the
---                  default handler. Called for any non-empty result.
function vim.lsp.declaration(options) end

-- Jumps to the definition of the symbol under the cursor.
--- @param options any #(table|nil) additional options
---                • reuse_win: (boolean) Jump to existing window if buffer is
---                  already open.
---                • on_list: (function) |lsp-on-list-handler| replacing the
---                  default handler. Called for any non-empty result.
function vim.lsp.definition(options) end

-- Display the lenses using virtual text
--- @param lenses any #lsp.CodeLens[]|nil lenses to display
--- @param bufnr any #(integer)
--- @param client_id any #(integer)
function vim.lsp.display(lenses, bufnr, client_id) end

-- Send request to the server to resolve document highlights for the current
-- text document position. This request can be triggered by a key mapping or
-- by events such as `CursorHold`, e.g.:
function vim.lsp.document_highlight() end

-- Lists all symbols in the current buffer in the quickfix window.
--- @param options any #(table|nil) additional options
---                • on_list: (function) handler for list results. See
---                  |lsp-on-list-handler|
function vim.lsp.document_symbol(options) end

-- Create a LSP RPC client factory that connects via named pipes (Windows) or
-- unix domain sockets (Unix) to the given pipe_path (file path on Unix and
-- name on Windows)
--- @param pipe_path any #(string) file path of the domain socket (Unix) or name of
---                  the named pipe (Windows) to connect to
--- @return any #fun(dispatchers: vim.lsp.rpc.Dispatchers ): vim.lsp.rpc.PublicClient::function intended to be passed to
---     |vim.lsp.start_client()| or |vim.lsp.start()| on the field cmd
function vim.lsp.domain_socket_connect(pipe_path) end

-- Enable/disable/toggle inlay hints for a buffer
--- @param bufnr any #(integer|nil) Buffer handle, or 0 or nil for current
--- @param enable any #(boolean|nil) true/nil to enable, false to disable
function vim.lsp.enable(bufnr, enable) end

-- Executes an LSP server command.
--- @param command_params any #(table) A valid `ExecuteCommandParams` object
function vim.lsp.execute_command(command_params) end

-- Force a refresh of all semantic tokens
--- @param bufnr any #(integer|nil) filter by buffer. All buffers if nil, current
---              buffer if 0
function vim.lsp.force_refresh(bufnr) end

-- Formats a buffer using the attached (and optionally filtered) language
-- server clients.
--- @param options any #(table|nil) Optional table which holds the following
---                optional fields:
---                • formatting_options (table|nil): Can be used to specify
---                  FormattingOptions. Some unspecified options will be
---                  automatically derived from the current Nvim options. See https://microsoft.github.io/language-server-protocol/specification/#formattingOptions
---                • timeout_ms (integer|nil, default 1000): Time in
---                  milliseconds to block for formatting requests. No effect
---                  if async=true
---                • bufnr (number|nil): Restrict formatting to the clients
---                  attached to the given buffer, defaults to the current
---                  buffer (0).
---                • filter (function|nil): Predicate used to filter clients.
---                  Receives a client as argument and must return a boolean.
---                  Clients matching the predicate are included. Example: >lua
---
---                      -- Never request typescript-language-server for formatting
---                      vim.lsp.buf.format {
---                        filter = function(client) return client.name ~= "tsserver" end
---                      }
---
--- <
---                • async boolean|nil If true the method won't block.
---                  Defaults to false. Editing the buffer while formatting
---                  asynchronous can lead to unexpected changes.
---                • id (number|nil): Restrict formatting to the client with
---                  ID (client.id) matching this field.
---                • name (string|nil): Restrict formatting to the client with
---                  name (client.name) matching this field.
---                • range (table|nil) Range to format. Table must contain
---                  `start` and `end` keys with {row,col} tuples using (1,0)
---                  indexing. Defaults to current selection in visual mode
---                  Defaults to `nil` in other modes, formatting the full
---                  buffer
function vim.lsp.format(options) end

-- Constructs an error message from an LSP error object.
--- @return any #string::The formatted error message
function vim.lsp.format_rpc_error() end

-- Get the list of inlay hints, (optionally) restricted by buffer or range.
--- @param filter any #vim.lsp.inlay_hint.get.filter ? Optional filters |kwargs|:
---               • bufnr (integer?): 0 for current buffer
---               • range (lsp.Range?)
--- @return any #vim.lsp.inlay_hint.get.ret [] Each list item is a table with the following fields:
---     • bufnr (integer)
---     • client_id (integer)
---     • inlay_hint (lsp.InlayHint)
function vim.lsp.get(filter) end

-- Return the semantic token(s) at the given position. If called without
-- arguments, returns the token under the cursor.
--- @param bufnr any #(integer|nil) Buffer number (0 for current buffer, default)
--- @param row any #(integer|nil) Position row (default cursor position)
--- @param col any #(integer|nil) Position column (default cursor position)
--- @return any #(table|nil) List of tokens at position. Each token has the following
---     fields:
---     • line (integer) line number, 0-based
---     • start_col (integer) start column, 0-based
---     • end_col (integer) end column, 0-based
---     • type (string) token type as string, e.g. "variable"
---     • modifiers (table) token modifiers as a set. E.g., { static = true,
---       readonly = true }
---     • client_id (integer)
function vim.lsp.get_at_pos(bufnr, row, col) end

-- Returns indentation size.
--- @param bufnr any #(integer|nil) Buffer handle, defaults to current
--- @return any #(integer) indentation size
function vim.lsp.get_effective_tabstop(bufnr) end

-- Returns the log filename.
--- @return any #(string) log filename
function vim.lsp.get_filename() end

-- Gets the current log level.
--- @return any #(integer) current log level
function vim.lsp.get_level() end

-- Get the diagnostic namespace associated with an LSP client
-- |vim.diagnostic| for diagnostics
--- @param client_id any #(integer) The id of the LSP client
--- @param is_pull any #boolean? Whether the namespace is for a pull or push
---                  client. Defaults to push
function vim.lsp.get_namespace(client_id, is_pull) end

-- Highlight a semantic token.
--- @param token any #(table) a semantic token, found as `args.data.token` in
---                  |LspTokenUpdate|.
--- @param bufnr any #(integer) the buffer to highlight
--- @param client_id any #(integer) The ID of the |vim.lsp.client|
--- @param hl_group any #(string) Highlight group name
--- @param opts any #(table|nil) Optional parameters.
---                  • priority: (integer|nil) Priority for the applied
---                    extmark. Defaults to
---                    `vim.highlight.priorities.semantic_tokens + 3`
function vim.lsp.highlight_token(token, bufnr, client_id, hl_group, opts) end

-- |lsp-handler| for the method "textDocument/hover"
--- @param ctx any #lsp.HandlerContext
--- @param config any #(table) Configuration table.
---               • border: (default=nil)
---                 • Add borders to the floating window
---                 • See |vim.lsp.util.open_floating_preview()| for more
---                   options.
function vim.lsp.hover(_, result, ctx, config) end

-- Lists all the implementations for the symbol under the cursor in the
-- quickfix window.
--- @param options any #(table|nil) additional options
---                • on_list: (function) |lsp-on-list-handler| replacing the
---                  default handler. Called for any non-empty result.
function vim.lsp.implementation(options) end

-- Lists all the call sites of the symbol under the cursor in the |quickfix|
-- window. If the symbol can resolve to multiple items, the user can pick one
-- in the |inputlist()|.
function vim.lsp.incoming_calls() end

--- @param bufnr any #(integer|nil) Buffer handle, or 0 or nil for current
--- @return any #(boolean)
function vim.lsp.is_enabled(bufnr) end

-- Jumps to a location.
--- @param location any #(table) (`Location`|`LocationLink`)
--- @param offset_encoding any #(string|nil) utf-8|utf-16|utf-32
--- @param reuse_win any #(boolean|nil) Jump to existing window if buffer is
---                        already open.
--- @return any #(boolean) `true` if the jump succeeded
function vim.lsp.jump_to_location(location, offset_encoding, reuse_win) end

-- List workspace folders.
function vim.lsp.list_workspace_folders() end

-- Returns the items with the byte position calculated correctly and in
-- sorted order, for display in quickfix and location lists.
--- @param locations any #lsp.Location[]|lsp.LocationLink[]
--- @param offset_encoding any #(string) offset_encoding for locations
---                        utf-8|utf-16|utf-32 default to first client of
---                        buffer
--- @return any #vim.lsp.util.LocationItem [] list of items
function vim.lsp.locations_to_items(locations, offset_encoding) end

-- Helper function to return nested values in language server settings
--- @param settings any #(table) language server settings
--- @param section any #string indicating the field of the settings table
--- @return any #table|string The value of settings accessed via section
function vim.lsp.lookup_section(settings, section) end

-- Gets a new ClientCapabilities object describing the LSP client
-- capabilities.
--- @return any #lsp.ClientCapabilities
function vim.lsp.make_client_capabilities() end

-- Creates a table with sensible default options for a floating window. The
-- table can be passed to |nvim_open_win()|.
--- @param width any #(integer) window width (in character cells)
--- @param height any #(integer) window height (in character cells)
--- @param opts any #(table) optional
---               • offset_x (integer) offset to add to `col`
---               • offset_y (integer) offset to add to `row`
---               • border (string or table) override `border`
---               • focusable (string or table) override `focusable`
---               • zindex (string or table) override `zindex`, defaults to 50
---               • relative ("mouse"|"cursor") defaults to "cursor"
---               • anchor_bias ("auto"|"above"|"below") defaults to "auto"
---                 • "auto": place window based on which side of the cursor
---                   has more lines
---                 • "above": place the window above the cursor unless there
---                   are not enough lines to display the full window height.
---                 • "below": place the window below the cursor unless there
---                   are not enough lines to display the full window height.
--- @return any #(table) Options
function vim.lsp.make_floating_popup_options(width, height, opts) end

-- Creates a `DocumentFormattingParams` object for the current buffer and
-- cursor position.
--- @param options any #(table|nil) with valid `FormattingOptions` entries
--- @return any #lsp.DocumentFormattingParams object
function vim.lsp.make_formatting_params(options) end

-- Using the given range in the current buffer, creates an object that is
-- similar to |vim.lsp.util.make_range_params()|.
--- @param start_pos any #integer[]|nil {row,col} mark-indexed position.
---                        Defaults to the start of the last visual selection.
--- @param end_pos any #integer[]|nil {row,col} mark-indexed position.
---                        Defaults to the end of the last visual selection.
--- @param bufnr any #(integer|nil) buffer handle or 0 for current,
---                        defaults to current
--- @param offset_encoding any #"utf-8"|"utf-16"|"utf-32"|nil defaults to
---                        `offset_encoding` of first client of `bufnr`
--- @return any #(table) { textDocument = { uri = `current_file_uri` }, range = { start
---     = `start_position`, end = `end_position` } }
function vim.lsp.make_given_range_params(start_pos, end_pos, bufnr, offset_encoding) end

-- Creates a `TextDocumentPositionParams` object for the current buffer and
-- cursor position.
--- @param window any #(integer|nil) window handle or 0 for current,
---                        defaults to current
--- @param offset_encoding any #(string|nil) utf-8|utf-16|utf-32|nil defaults to
---                        `offset_encoding` of first client of buffer of
---                        `window`
--- @return any #(table) `TextDocumentPositionParams` object
function vim.lsp.make_position_params(window, offset_encoding) end

-- Using the current position in the current buffer, creates an object that
-- can be used as a building block for several LSP requests, such as
-- `textDocument/codeAction`, `textDocument/colorPresentation`,
-- `textDocument/rangeFormatting`.
--- @param window any #(integer|nil) window handle or 0 for current,
---                        defaults to current
--- @param offset_encoding any #"utf-8"|"utf-16"|"utf-32"|nil defaults to
---                        `offset_encoding` of first client of buffer of
---                        `window`
--- @return any #(table) { textDocument = { uri = `current_file_uri` }, range = { start
---     = `current_position`, end = `current_position` } }
function vim.lsp.make_range_params(window, offset_encoding) end

-- Creates a `TextDocumentIdentifier` object for the current buffer.
--- @param bufnr any #(integer|nil) Buffer handle, defaults to current
--- @return any #(table) `TextDocumentIdentifier`
function vim.lsp.make_text_document_params(bufnr) end

-- Create the workspace params
--- @param added any #(table)
--- @param removed any #(table)
function vim.lsp.make_workspace_params(added, removed) end

-- Sends a notification to the LSP server.
--- @param method any #(string) The invoked LSP method
--- @param params any #(table?) Parameters for the invoked LSP method
--- @return any #(boolean) `true` if notification could be sent, `false` if not
function vim.lsp.notify(method, params) end

-- |lsp-handler| for the method `textDocument/codeLens`
--- @param ctx any #lsp.HandlerContext
function vim.lsp.on_codelens(err, result, ctx, _) end

-- |lsp-handler| for the method "textDocument/diagnostic"
--- @param ctx any #lsp.HandlerContext
--- @param config any #(table) Configuration table (see |vim.diagnostic.config()|).
function vim.lsp.on_diagnostic(_, result, ctx, config) end

-- |lsp-handler| for the method "textDocument/publishDiagnostics"
--- @param ctx any #lsp.HandlerContext
--- @param config any #(table) Configuration table (see |vim.diagnostic.config()|).
function vim.lsp.on_publish_diagnostics(_, result, ctx, config) end

-- Shows contents in a floating window.
--- @param contents any #(table) of lines to show in window
--- @param syntax any #(string) of syntax to set for opened buffer
--- @param opts any #(table) with optional fields (additional keys are filtered
---                 with |vim.lsp.util.make_floating_popup_options()| before
---                 they are passed on to |nvim_open_win()|)
---                 • height: (integer) height of floating window
---                 • width: (integer) width of floating window
---                 • wrap: (boolean, default true) wrap long lines
---                 • wrap_at: (integer) character to wrap at for computing
---                   height when wrap is enabled
---                 • max_width: (integer) maximal width of floating window
---                 • max_height: (integer) maximal height of floating window
---                 • focus_id: (string) if a popup with this id is opened,
---                   then focus it
---                 • close_events: (table) list of events that closes the
---                   floating window
---                 • focusable: (boolean, default true) Make float focusable
---                 • focus: (boolean, default true) If `true`, and if
---                   {focusable} is also `true`, focus an existing floating
---                   window with the same {focus_id}
--- @return any #(integer) bufnr of newly created float window
--- @return any #(integer) winid of newly created float window preview window
function vim.lsp.open_floating_preview(contents, syntax, opts) end

-- Lists all the items that are called by the symbol under the cursor in the
-- |quickfix| window. If the symbol can resolve to multiple items, the user
-- can pick one in the |inputlist()|.
function vim.lsp.outgoing_calls() end

-- Previews a location in a floating window
--- @param location any #(table) a single `Location` or `LocationLink`
--- @return any #(integer|nil) buffer id of float window
--- @return any #(integer|nil) window id of float window
function vim.lsp.preview_location(location, opts) end

-- Lists all the references to the symbol under the cursor in the quickfix
-- window.
--- @param context any #(table|nil) Context for the request
--- @param options any #(table|nil) additional options
---                • on_list: (function) handler for list results. See
---                  |lsp-on-list-handler|
function vim.lsp.references(context, options) end

-- Refresh the codelens for the current buffer
function vim.lsp.refresh() end

-- Remove the folder at path from the workspace folders. If {path} is not
-- provided, the user will be prompted for a path using |input()|.
function vim.lsp.remove_workspace_folder(workspace_folder) end

-- Rename old_fname to new_fname
--- @param opts any #(table)
function vim.lsp.rename(old_fname, new_fname, opts) end

-- Sends a request to the LSP server and runs {callback} upon response.
--- @param method any #(string) The invoked LSP method
--- @param params any #(table?) Parameters for the invoked LSP
---                              method
--- @param callback any #fun(err: lsp.ResponseError | nil, result:
---                              any) Callback to invoke
--- @param notify_reply_callback any #(function?) Callback to invoke as soon as a
---                              request is no longer pending
--- @return any #(boolean) success, integer|nil request_id true, message_id if request
---     could be sent, `false` if not
function vim.lsp.request(method, params, callback, notify_reply_callback) end

-- Creates a normalized object describing LSP server capabilities.
--- @param server_capabilities any #(table) Table of capabilities supported by the
---                            server
--- @return any #lsp.ServerCapabilities|nil Normalized table of capabilities
function vim.lsp.resolve_capabilities(server_capabilities) end

-- Run the code lens in the current line
function vim.lsp.run() end

-- Store lenses for a specific buffer and client
--- @param lenses any #lsp.CodeLens[]|nil lenses to store
--- @param bufnr any #(integer)
--- @param client_id any #(integer)
function vim.lsp.save(lenses, bufnr, client_id) end

-- Sets formatting function used to format logs
--- @param handle any #(function) function to apply to logging arguments, pass
---               vim.inspect for multi-line formatting
function vim.lsp.set_format_func(handle) end

-- Sets the current log level.
--- @param level any #(string|integer) One of `vim.lsp.log.levels`
function vim.lsp.set_level(level) end

-- Checks whether the level is sufficient for logging.
--- @param level any #(integer) log level
--- @return any #(bool) true if would log, false if not
function vim.lsp.should_log(level) end

-- Shows document and optionally jumps to the location.
--- @param location any #(table) (`Location`|`LocationLink`)
--- @param offset_encoding any #(string|nil) utf-8|utf-16|utf-32
--- @param opts any #(table|nil) options
---                        • reuse_win (boolean) Jump to existing window if
---                          buffer is already open.
---                        • focus (boolean) Whether to focus/jump to location
---                          if possible. Defaults to true.
--- @return any #(boolean) `true` if succeeded
function vim.lsp.show_document(location, offset_encoding, opts) end

-- |lsp-handler| for the method "textDocument/signatureHelp".
--- @param result any #(table) Response from the language server
--- @param ctx any #lsp.HandlerContext Client context
--- @param config any #(table) Configuration table.
---               • border: (default=nil)
---                 • Add borders to the floating window
---                 • See |vim.lsp.util.open_floating_preview()| for more
---                   options
function vim.lsp.signature_help(_, result, ctx, config) end

-- Stop the semantic token highlighting engine for the given buffer with the
-- given client.
--- @param bufnr any #(integer)
--- @param client_id any #(integer)
function vim.lsp.stop(bufnr, client_id) end

-- Converts markdown into syntax highlighted regions by stripping the code
-- blocks and converting them into highlighted code. This will by default
-- insert a blank line separator after those code block regions to improve
-- readability.
--- @param contents any #(table) of lines to show in window
--- @param opts any #(table) with optional fields
---                 • height of floating window
---                 • width of floating window
---                 • wrap_at character to wrap at for computing height
---                 • max_width maximal width of floating window
---                 • max_height maximal height of floating window
---                 • separator insert separator after code block
--- @return any #(table) stripped content
function vim.lsp.stylize_markdown(bufnr, contents, opts) end

-- Converts symbols to quickfix list items.
--- @param symbols any #(table) DocumentSymbol[] or SymbolInformation[]
function vim.lsp.symbols_to_items(symbols, bufnr) end

-- Jumps to the definition of the type of the symbol under the cursor.
--- @param options any #(table|nil) additional options
---                • reuse_win: (boolean) Jump to existing window if buffer is
---                  already open.
---                • on_list: (function) |lsp-on-list-handler| replacing the
---                  default handler. Called for any non-empty result.
function vim.lsp.type_definition(options) end

-- Lists all symbols in the current workspace in the quickfix window.
--- @param query any #(string|nil) optional
--- @param options any #(table|nil) additional options
---                • on_list: (function) handler for list results. See
---                  |lsp-on-list-handler|
function vim.lsp.workspace_symbol(query, options) end

