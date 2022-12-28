---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Without {flags} or with {flags} empty: Deletes the file by the
-- 		name {fname}.  This also works when {fname} is a symbolic link.
-- 		A symbolic link itself is deleted, not what it points to.
--
-- 		When {flags} is "d": Deletes the directory by the name
-- 		{fname}.  This fails when directory {fname} is not empty.
--
-- 		When {flags} is "rf": Deletes the directory by the name
-- 		{fname} and everything in it, recursively.  BE CAREFUL!
-- 		Note: on MS-Windows it is not possible to delete a directory
-- 		that is being used.
--
-- 		The result is a Number, which is 0 if the delete operation was
-- 		successful and -1 when the deletion failed or partly failed.
--- @return number
function vim.fn.delete(fname, flags) end

-- Round off {expr} to the nearest integral value and return it
-- 		as a |Float|.  If {expr} lies halfway between two integral
-- 		values, then use the larger one (away from zero).
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			echo round(0.456)
-- <			0.0  >
-- 			echo round(4.5)
-- <			5.0 >
-- 			echo round(-4.5)
-- <			-5.0
--- @return float
function vim.fn.round(expr) end

-- Set the function name prefix to be used for the |terminal-api|
-- 		function in terminal {buf}.  For example: >
-- 		    :call term_setapi(buf, "Myapi_")
-- 		    :call term_setapi(buf, "")
-- <
-- 		The default is "Tapi_".  When {expr} is an empty string then
-- 		no |terminal-api| function can be used for {buf}.
--- @return none
function vim.fn.term_setapi(buf, expr) end

-- Perform glob() on all directories in {path} and concatenate
-- 		the results.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim")
-- <
-- 		{path} is a comma-separated list of directory names.  Each
-- 		directory name is prepended to {expr} and expanded like with
-- 		|glob()|.  A path separator is inserted when needed.
-- 		To add a comma inside a directory name escape it with a
-- 		backslash.  Note that on MS-Windows a directory may have a
-- 		trailing backslash, remove it if you put a comma after it.
-- 		If the expansion fails for one of the directories, there is no
-- 		error message.
--
-- 		Unless the optional {nosuf} argument is given and is |TRUE|,
-- 		the 'suffixes' and 'wildignore' options apply: Names matching
-- 		one of the patterns in 'wildignore' will be skipped and
-- 		'suffixes' affect the ordering of matches.
--
-- 		When {list} is present and it is |TRUE| the result is a List
-- 		with all matching files. The advantage of using a List is, you
-- 		also get filenames containing newlines correctly. Otherwise
-- 		the result is a String and when there are several matches,
-- 		they are separated by <NL> characters.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim", 0, 1)
-- <
-- 		{allinks} is used as with |glob()|.
--
-- 		The "**" item can be used to search in a directory tree.
-- 		For example, to find all "README.txt" files in the directories
-- 		in 'runtimepath' and below: >
-- 			:echo globpath(&rtp, "**/README.txt")
-- <		Upwards search and limiting the depth of "**" is not
-- 		supported, thus using 'path' will not always work properly.
--- @param list any[]
--- @return string
function vim.fn.globpath(path, expr, nosuf, list, alllinks) end

-- This is similar to |json_decode()| with these differences:
-- 		- Object key names do not have to be in quotes.
-- 		- Strings can be in single quotes.
-- 		- Empty items in an array (between two commas) are allowed and
-- 		  result in v:none items.
--
-- 		Can also be used as a |method|: >
-- 			ReadObject()->js_decode()
function vim.fn.js_decode(string) end

-- Return |TRUE| if {expr} is a float with value NaN. >
-- 			echo isnan(0.0 / 0.0)
-- <			1
--- @return number
function vim.fn.isnan(expr) end

-- current buffer.  The indent is counted in spaces, the value
-- 		of 'tabstop' is relevant.  {lnum} is used just like in
-- 		|getline()|.
-- 		When {lnum} is invalid -1 is returned.
--- @return number
function vim.fn.indent(lnum) end

-- Return the oldest available reply from {serverid} and consume
-- 		it.  Unless a {timeout} in seconds is given, it blocks until a
-- 		reply is available.
-- 		See also |clientserver|.
-- 		This function is not available in the |sandbox|.
-- 		Example: >
-- 			:echo remote_read(id)
-- <
--- @return string
function vim.fn.remote_read(serverid, timeout) end

-- {list}.
-- 		If you want a list to remain unmodified make a copy first: >
-- 			:let revlist = reverse(copy(mylist))
--- @param list any[]
--- @return list
function vim.fn.reverse(list) end

-- Cleanup unused |Lists| and |Dictionaries| that have circular
-- 		references.
--
-- 		There is hardly ever a need to invoke this function, as it is
-- 		automatically done when Vim runs out of memory or is waiting
-- 		for the user to press a key after 'updatetime'.  Items without
-- 		circular references are always freed when they become unused.
-- 		This is useful if you have deleted a very big |List| and/or
-- 		|Dictionary| with circular references in a script that runs
-- 		for a long time.
--
-- 		When the optional {atexit} argument is one, garbage
-- 		collection will also be done when exiting Vim, if it wasn't
-- 		done before.  This is useful when checking for memory leaks.
--
-- 		The garbage collection is not done immediately but only when
-- 		it's safe to perform.  This is when waiting for the user to
-- 		type a character.
--- @return none
function vim.fn.garbagecollect(atexit) end

-- Returns the number of filler lines above line {lnum}.
-- 		These are the lines that were inserted at this point in
-- 		another diff'ed window.  These filler lines are shown in the
-- 		display but don't exist in the buffer.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Returns 0 if the current window is not in diff mode.
--- @return number
function vim.fn.diff_filler(lnum) end

-- Return number value of the first char in {expr}.  Examples: >
-- 			char2nr(" ")		returns 32
-- 			char2nr("ABC")		returns 65
-- 			char2nr("á")		returns 225
-- 			char2nr("á"[0])		returns 195
-- 			char2nr("\<M-x>")	returns 128
-- <		Non-ASCII characters are always treated as UTF-8 characters.
-- 		{utf8} is ignored, it exists only for backwards-compatibility.
-- 		A combining character is a separate character.
-- 		|nr2char()| does the opposite.
--- @return number
function vim.fn.char2nr(expr, utf8) end

-- When {dict} is omitted or zero: Return the rhs of mapping
-- 		{name} in mode {mode}.  The returned String has special
-- 		characters translated like in the output of the ":map" command
-- 		listing.
--
-- 		When there is no mapping for {name}, an empty String is
-- 		returned.  When the mapping for {name} is empty, then "<Nop>"
-- 		is returned.
--
-- 		The {name} can have special key names, like in the ":map"
-- 		command.
--
-- 		{mode} can be one of these strings:
-- 			"n"	Normal
-- 			"v"	Visual (including Select)
-- 			"o"	Operator-pending
-- 			"i"	Insert
-- 			"c"	Cmd-line
-- 			"s"	Select
-- 			"x"	Visual
-- 			"l"	langmap |language-mapping|
-- 			"t"	Terminal
-- 			""	Normal, Visual and Operator-pending
-- 		When {mode} is omitted, the modes for "" are used.
--
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.
--
-- 		When {dict} is there and it is |TRUE| return a dictionary
-- 		containing all the information of the mapping with the
-- 		following items:
-- 		  "lhs"	     The {lhs} of the mapping.
-- 		  "rhs"	     The {rhs} of the mapping as typed.
-- 		  "silent"   1 for a |:map-silent| mapping, else 0.
-- 		  "noremap"  1 if the {rhs} of the mapping is not remappable.
-- 		  "expr"     1 for an expression mapping (|:map-<expr>|).
-- 		  "buffer"   1 for a buffer local mapping (|:map-local|).
-- 		  "mode"     Modes for which the mapping is defined. In
-- 			     addition to the modes mentioned above, these
-- 			     characters will be used:
-- 			     " "     Normal, Visual and Operator-pending
-- 			     "!"     Insert and Commandline mode
-- 				     (|mapmode-ic|)
-- 		  "sid"	     The script local ID, used for <sid> mappings
-- 			     (|<SID>|).
-- 		  "lnum"     The line number in "sid", zero if unknown.
-- 		  "nowait"   Do not wait for other, longer mappings.
-- 			     (|:map-<nowait>|).
--
-- 		The mappings local to the current buffer are checked first,
-- 		then the global mappings.
-- 		This function can be used to map a key even when it's already
-- 		mapped, and have it do the original mapping too.  Sketch: >
-- 			exe 'nnoremap <Tab> ==' . maparg('<Tab>', 'n')
--- @param dict dictionary
--- @return string
function vim.fn.maparg(name, mode, abbr, dict) end

-- Stop playing sound {id}.  {id} must be previously returned by
-- 		`sound_playevent()` or `sound_playfile()`.
--
-- 		On MS-Windows, this does not work for event sound started by
-- 		`sound_playevent()`. To stop event sounds, use `sound_clear()`.
--
-- 		Can also be used as a |method|: >
-- 			soundid->sound_stop()
--
-- <		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_stop(id) end

-- Unstabilized interface for defining syntax hl in lua.
--
--                 This is not yet safe for general use, lua callbacks will need
--                 to be restricted, like textlock and probably other stuff.
--
--                 The API on_line/nvim__put_attr is quite raw and not intended
--                 to be the final shape. Ideally this should operate on chunks
--                 larger than a single line to reduce interpreter overhead, and
--                 generate annotation objects (bufhl/virttext) on the fly but
--                 using the same representation.
function vim.fn.nvim__buf_set_luahl(buffer, opts) end

-- Ensure the buffer {expr} is loaded.  When the buffer name
-- 		refers to an existing file then the file is read.  Otherwise
-- 		the buffer will be empty.  If the buffer was already loaded
-- 		then there is no change.
-- 		If there is an existing swap file for the file of the buffer,
-- 		there will be no dialog, the buffer will be loaded anyway.
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.bufload(expr) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the last line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @return number
function vim.fn.foldclosedend(lnum) end

-- Returns non-zero when the popup menu is visible, zero
-- 		otherwise.  See |ins-completion-menu|.
-- 		This can be used to avoid some things that would remove the
-- 		popup menu.
--- @return number
function vim.fn.pumvisible() end

-- The result is a Number, which is the last modification time of
-- 		the given file {fname}.  The value is measured as seconds
-- 		since 1st Jan 1970, and may be passed to strftime().  See also
-- 		|localtime()| and |strftime()|.
-- 		If the file {fname} can't be found -1 is returned.
--- @return number
function vim.fn.getftime(fname) end

-- Execute Lua code. Parameters (if any) are available as `...`
--                 inside the chunk. The chunk can return a value.
--
--                 Only statements are executed. To evaluate an expression,
--                 prefix it with `return` : return my_function(...)
--
--                 Parameters: ~
--                     {code}  Lua code to execute
--                     {args}  Arguments to the code
--
--                 Return: ~
--                     Return value of Lua code if present or NIL.
--- @param args any[]
function vim.fn.nvim_exec_lua(code, args) end

-- Return the remainder of {expr1} / {expr2}, even if the
-- 		division is not representable.  Returns {expr1} - i * {expr2}
-- 		for some integer i such that if {expr2} is non-zero, the
-- 		result has the same sign as {expr1} and magnitude less than
-- 		the magnitude of {expr2}.  If {expr2} is zero, the value
-- 		returned is zero.  The value returned is a |Float|.
-- 		{expr1} and {expr2} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo fmod(12.33, 1.22)
-- <			0.13 >
-- 			:echo fmod(-12.33, 1.22)
-- <			-0.13
--- @return float
function vim.fn.fmod(expr1, expr2) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.  See |channel-use|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 								*E917*
-- 		{options} must be a Dictionary.  It must not have a "callback"
-- 		entry.  It can have a "timeout" entry to specify the timeout
-- 		for this specific request.
--
-- 		ch_evalexpr() waits for a response and returns the decoded
-- 		expression.  When there is an error or timeout it returns an
-- 		empty string.
--
-- 		Note that while waiting for the response, Vim handles other
-- 		messages.  You need to make sure this doesn't cause trouble.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_evalexpr(expr)
function vim.fn.ch_evalexpr(handle, expr, options) end

-- The result is the number of files in the argument list.  See
-- 		|arglist|.
-- 		If {winid} is not supplied, the argument list of the current
-- 		window is used.
-- 		If {winid} is -1, the global argument list is used.
-- 		Otherwise {winid} specifies the window of which the argument
-- 		list is used: either the window number or the window ID.
-- 		Returns -1 if the {winid} argument is invalid.
--- @return number
function vim.fn.argc(winid) end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Uses Python 2 or 3, see |python_x| and 'pyxversion'.
-- 		See also: |pyeval()|, |py3eval()|
function vim.fn.pyxeval(expr) end

-- Return the hyperbolic tangent of {expr} as a |Float| in the
-- 		range [-1, 1].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo tanh(0.5)
-- <			0.462117 >
-- 			:echo tanh(-1)
-- <			-0.761594
--- @return float
function vim.fn.tanh(expr) end

-- The result is a List with currently three items:
-- 		1. The first item in the list is 0 if the character at the
-- 		   position {lnum} and {col} is not part of a concealable
-- 		   region, 1 if it is.
-- 		2. The second item in the list is a string. If the first item
-- 		   is 1, the second item contains the text which will be
-- 		   displayed in place of the concealed text, depending on the
-- 		   current setting of 'conceallevel' and 'listchars'.
-- 		3. The third and final item in the list is a number
-- 		   representing the specific syntax region matched in the
-- 		   line. When the character is not concealed the value is
-- 		   zero. This allows detection of the beginning of a new
-- 		   concealable region if there are two consecutive regions
-- 		   with the same replacement character.  For an example, if
-- 		   the text is "123456" and both "23" and "45" are concealed
-- 		   and replaced by the character "X", then:
-- 			call			returns ~
-- 		   	synconcealed(lnum, 1)   [0, '', 0]
-- 		   	synconcealed(lnum, 2)   [1, 'X', 1]
-- 		   	synconcealed(lnum, 3)   [1, 'X', 1]
-- 		   	synconcealed(lnum, 4)   [1, 'X', 2]
-- 		   	synconcealed(lnum, 5)   [1, 'X', 2]
-- 		   	synconcealed(lnum, 6)   [0, '', 0]
--- @return list
function vim.fn.synconcealed(lnum, col) end

-- Place the sign defined as {name} at line {lnum} in file {expr}
-- 		and assign {id} and {group} to sign.  This is similar to the
-- 		|:sign-place| command.
--
-- 		If the sign identifier {id} is zero, then a new identifier is
-- 		allocated.  Otherwise the specified number is used. {group} is
-- 		the sign group name. To use the global sign group, use an
-- 		empty string.  {group} functions as a namespace for {id}, thus
-- 		two groups can use the same IDs. Refer to |sign-identifier|
-- 		for more information.
--
-- 		{name} refers to a defined sign.
-- 		{expr} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.
--
-- 		The optional {dict} argument supports the following entries:
-- 			lnum		line number in the buffer {expr} where
-- 					the sign is to be placed. For the
-- 					accepted values, see |line()|.
-- 			priority	priority of the sign. See
-- 					|sign-priority| for more information.
--
-- 		If the optional {dict} is not specified, then it modifies the
-- 		placed sign {id} in group {group} to use the defined sign
-- 		{name}.
--
-- 		Returns the sign identifier on success and -1 on failure.
--
-- 		Examples: >
-- 			" Place a sign named sign1 with id 5 at line 20 in
-- 			" buffer json.c
-- 			call sign_place(5, '', 'sign1', 'json.c',
-- 							\ {'lnum' : 20})
--
-- 			" Updates sign 5 in buffer json.c to use sign2
-- 			call sign_place(5, '', 'sign2', 'json.c')
--
-- 			" Place a sign named sign3 at line 30 in
-- 			" buffer json.c with a new identifier
-- 			let id = sign_place(0, '', 'sign3', 'json.c',
-- 							\ {'lnum' : 30})
--
-- 			" Place a sign named sign4 with id 10 in group 'g3'
-- 			" at line 40 in buffer json.c with priority 90
-- 			call sign_place(10, 'g3', 'sign4', 'json.c',
-- 					\ {'lnum' : 40, 'priority' : 90})
--- @param dict dictionary
--- @return number
function vim.fn.sign_place(id, group, name, expr, dict) end

-- windows for the current tab and global popups.
--- @return none
function vim.fn.popup_clear() end

-- Return the number of the most recent change.  This is the same
-- 		number as what is displayed with |:undolist| and can be used
-- 		with the |:undo| command.
-- 		When a change was made it is the number of that change.  After
-- 		redo it is the number of the redone change.  After undo it is
-- 		one less than the number of the undone change.
--- @return number
function vim.fn.changenr() end

-- Call function {func} with the items in |List| {arglist} as
-- 		arguments.
-- 		{func} can either be a |Funcref| or the name of a function.
-- 		a:firstline and a:lastline are set to the cursor line.
-- 		Returns the return value of the called function.
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--- @param dict dictionary
function vim.fn.call(func, arglist, dict) end

-- Stop the {job}.  This can also be used to signal the job.
--
-- 		When {how} is omitted or is "term" the job will be terminated.
-- 		For Unix SIGTERM is sent.  On MS-Windows the job will be
-- 		terminated forcedly (there is no "gentle" way).
-- 		This goes to the process group, thus children may also be
-- 		affected.
--
-- 		Effect for Unix:
-- 			"term"	 SIGTERM (default)
-- 			"hup"	 SIGHUP
-- 			"quit"	 SIGQUIT
-- 			"int"	 SIGINT
-- 			"kill"	 SIGKILL (strongest way to stop)
-- 			number	 signal with that number
--
-- 		Effect for MS-Windows:
-- 			"term"	 terminate process forcedly (default)
-- 			"hup"	 CTRL_BREAK
-- 			"quit"	 CTRL_BREAK
-- 			"int"	 CTRL_C
-- 			"kill"	 terminate process forcedly
-- 			Others	 CTRL_BREAK
--
-- 		On Unix the signal is sent to the process group.  This means
-- 		that when the job is "sh -c command" it affects both the shell
-- 		and the command.
--
-- 		The result is a Number: 1 if the operation could be executed,
-- 		0 if "how" is not supported on the system.
-- 		Note that even when the operation was executed, whether the
-- 		job was actually stopped needs to be checked with
-- 		|job_status()|.
--
-- 		If the status of the job is "dead", the signal will not be
-- 		sent.  This is to avoid to stop the wrong job (esp. on Unix,
-- 		where process numbers are recycled).
--
-- 		When using "kill" Vim will assume the job will die and close
-- 		the channel.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_stop()
--- @return number
function vim.fn.job_stop(job, how) end

-- Report a test failure directly, using {msg}.
-- 		Always returns one.
--- @return number
function vim.fn.assert_report(msg) end

-- Get a list of defined signs and their attributes.
-- 		This is similar to the |:sign-list| command.
--
-- 		If the {name} is not supplied, then a list of all the defined
-- 		signs is returned. Otherwise the attribute of the specified
-- 		sign is returned.
--
-- 		Each list item in the returned value is a dictionary with the
-- 		following entries:
-- 			icon	full path to the bitmap file of the sign
-- 			linehl	highlight group used for the whole line the
-- 				sign is placed in.
-- 			name	name of the sign
-- 			text	text that is displayed when there is no icon
-- 				or the GUI is not being used.
-- 			texthl	highlight group used for the text item
-- 			numhl	highlight group used for 'number' column at the
-- 				associated line. Overrides |hl-LineNr|,
-- 				|hl-CursorLineNr|.
--
-- 		Returns an empty List if there are no signs and when {name} is
-- 		not found.
--
-- 		Examples: >
-- 			" Get a list of all the defined signs
-- 			echo sign_getdefined()
--
-- 			" Get the attribute of the sign named mySign
-- 			echo sign_getdefined("mySign")
--- @return list
function vim.fn.sign_getdefined(name) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists.
-- 		If the {expr} argument is a number, buffer numbers are used.
-- 		Number zero is the alternate buffer for the current window.
--
-- 		If the {expr} argument is a string it must match a buffer name
-- 		exactly.  The name can be:
-- 		- Relative to the current directory.
-- 		- A full path.
-- 		- The name of a buffer with 'buftype' set to "nofile".
-- 		- A URL name.
-- 		Unlisted buffers will be found.
-- 		Note that help files are listed by their short name in the
-- 		output of |:buffers|, but bufexists() requires using their
-- 		long name to be able to find them.
-- 		bufexists() may report a buffer exists, but to use the name
-- 		with a |:buffer| command you may need to use |expand()|.  Esp
-- 		for MS-Windows 8.3 names in the form "c:\DOCUME~1"
-- 		Use "bufexists(0)" to test for the existence of an alternate
-- 		file name.
--- @return number
function vim.fn.bufexists(expr) end

-- Remove all text properties from line {lnum}.
-- 		When {lnum-end} is given, remove all text properties from line
-- 		{lnum} to {lnum-end} (inclusive).
--
-- 		When {props} contains a "bufnr" item use this buffer,
-- 		otherwise use the current buffer.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_clear()
-- <
--- @return none
function vim.fn.prop_clear(lnum, lnum_end, props) end

-- Create a timer and return the timer ID.
--
-- 		{time} is the waiting time in milliseconds. This is the
-- 		minimum time before invoking the callback.  When the system is
-- 		busy or Vim is not waiting for input the time will be longer.
--
-- 		{callback} is the function to call.  It can be the name of a
-- 		function or a |Funcref|.  It is called with one argument, which
-- 		is the timer ID.  The callback is only invoked when Vim is
-- 		waiting for input.
--
-- 		{options} is a dictionary.  Supported entries:
-- 		   "repeat"	Number of times to repeat the callback.
-- 				-1 means forever.  Default is 1.
-- 				If the timer causes an error three times in a
-- 				row the repeat is cancelled.
--
-- 		Example: >
-- 			func MyHandler(timer)
-- 			  echo 'Handler called'
-- 			endfunc
-- 			let timer = timer_start(500, 'MyHandler',
-- 				\ {'repeat': 3})
-- <		This invokes MyHandler() three times at 500 msec intervals.
--- @return number
function vim.fn.timer_start(time, callback, options) end

-- Remove a listener previously added with listener_add().
-- 		Returns zero when {id} could not be found, one when {id} was
-- 		removed.
--
-- 		Can also be used as a |method|: >
-- 			GetListenerId()->listener_remove()
--- @return none
function vim.fn.listener_remove(id) end

--- @param list any[]
--- @return list
function vim.fn.sign_placelist(list) end

-- Pushes the current editor state (|context|) on the
-- 		|context-stack|.
-- 		If {types} is given and is a |List| of |String|s, it specifies
-- 		which |context-types| to include in the pushed context.
-- 		Otherwise, all context types are included.
--- @return none
function vim.fn.ctxpush(types) end

-- Filter that can be used for a popup. These keys can be used:
-- 		    j <Down>		select item below
-- 		    k <Up>		select item above
-- 		    <Space> <Enter>	accept current selection
-- 		    x Esc CTRL-C	cancel the menu
-- 		Other keys are ignored.
--
-- 		A match is set on that line to highlight it, see
-- 		|popup_menu()|.
--
-- 		When the current selection is accepted the "callback" of the
-- 		popup menu is invoked with the index of the selected line as
-- 		the second argument.  The first entry has index one.
-- 		Cancelling the menu invokes the callback with -1.
--
-- 		To add shortcut keys, see the example here:
-- 		|popup_menu-shortcut-example|
--- @return number
function vim.fn.popup_filter_menu(id, key) end

-- Same as |matchadd()|, but requires a list of positions {pos}
-- 		instead of a pattern. This command is faster than |matchadd()|
-- 		because it does not require to handle regular expressions and
-- 		sets buffer line boundaries to redraw screen. It is supposed
-- 		to be used when fast match additions and deletions are
-- 		required, for example to highlight matching parentheses.
-- 							*E5030* *E5031*
-- 		The list {pos} can contain one of these items:
-- 		- A number.  This whole line will be highlighted.  The first
-- 		  line has number 1.
-- 		- A list with one number, e.g., [23]. The whole line with this
-- 		  number will be highlighted.
-- 		- A list with two numbers, e.g., [23, 11]. The first number is
-- 		  the line number, the second one is the column number (first
-- 		  column is 1, the value must correspond to the byte index as
-- 		  |col()| would return).  The character at this position will
-- 		  be highlighted.
-- 		- A list with three numbers, e.g., [23, 11, 3]. As above, but
-- 		  the third number gives the length of the highlight in bytes.
--
-- 		Entries with zero and negative line numbers are silently
-- 		ignored, as well as entries with negative column numbers and
-- 		lengths.
--
-- 		The maximum number of positions is 8.
--
-- 		Example: >
-- 			:highlight MyGroup ctermbg=green guibg=green
-- 			:let m = matchaddpos("MyGroup", [[23, 24], 34])
-- <		Deletion of the pattern: >
-- 			:call matchdelete(m)
--
-- <		Matches added by |matchaddpos()| are returned by
-- 		|getmatches()| with an entry "pos1", "pos2", etc., with the
-- 		value a list like the {pos} item.
--- @param list any[]
--- @return number
function vim.fn.matchaddpos(group, list, priority, id) end

-- Positions the cursor at the column (byte count) {col} in the
-- 		line {lnum}.  The first column is one.
--
-- 		When there is one argument {list} this is used as a |List|
-- 		with two, three or four item:
-- 			[{lnum}, {col}]
-- 			[{lnum}, {col}, {off}]
-- 			[{lnum}, {col}, {off}, {curswant}]
-- 		This is like the return value of |getpos()| or |getcurpos()|,
-- 		but without the first item.
--
-- 		Does not change the jumplist.
-- 		If {lnum} is greater than the number of lines in the buffer,
-- 		the cursor will be positioned at the last line in the buffer.
-- 		If {lnum} is zero, the cursor will stay in the current line.
-- 		If {col} is greater than the number of bytes in the line,
-- 		the cursor will be positioned at the last character in the
-- 		line.
-- 		If {col} is zero, the cursor will stay in the current column.
-- 		If {curswant} is given it is used to set the preferred column
-- 		for vertical movement.  Otherwise {col} is used.
--
-- 		When 'virtualedit' is used {off} specifies the offset in
-- 		screen columns from the start of the character.  E.g., a
-- 		position within a <Tab> or after the last character.
-- 		Returns 0 when the position could be set, -1 otherwise.
--- @param list any[]
--- @return number
function vim.fn.cursor(list) end

-- Convert a file pattern, as used by glob(), into a search
-- 		pattern.  The result can be used to match with a string that
-- 		is a file name.  E.g. >
-- 			if filename =~ glob2regpat('Make*.mak')
-- <		This is equivalent to: >
-- 			if filename =~ '^Make.*\.mak$'
-- <		When {expr} is an empty string the result is "^$", match an
-- 		empty string.
-- 		Note that the result depends on the system.  On MS-Windows
-- 		a backslash usually means a path separator.
--- @return string
function vim.fn.glob2regpat(expr) end

-- Connect a socket to an address. If {mode} is "pipe" then
-- 		{address} should be the path of a named pipe. If {mode} is
-- 		"tcp" then {address} should be of the form "host:port" where
-- 		the host should be an ip adderess or host name, and port the
-- 		port number.
--
-- 		Returns a |channel| ID. Close the socket with |chanclose()|.
-- 		Use |chansend()| to send data over a bytes socket, and
-- 		|rpcrequest()| and |rpcnotify()| to communicate with a RPC
-- 		socket.
--
-- 		{opts} is a dictionary with these keys:
-- 		  |on_data| : callback invoked when data was read from socket
-- 		  data_buffered : read socket data in |channel-buffered| mode.
-- 		  rpc     : If set, |msgpack-rpc| will be used to communicate
-- 			    over the socket.
-- 		Returns:
-- 		  - The channel ID on success (greater than zero)
-- 		  - 0 on invalid arguments or connection failure.
--- @return number
function vim.fn.sockconnect(mode, address, opts) end

-- When the files {fname-one} and {fname-two} do not contain
-- 		exactly the same text an error message is added to |v:errors|.
-- 		Also see |assert-return|.
-- 		When {fname-one} or {fname-two} does not exist the error will
-- 		mention that.
--- @return number
function vim.fn.assert_equalfile(fname_one, fname_two) end

-- the default function used for the 'foldtext' option and should
-- 		only be called from evaluating 'foldtext'.  It uses the
-- 		|v:foldstart|, |v:foldend| and |v:folddashes| variables.
-- 		The returned string looks like this: >
-- 			+-- 45 lines: abcdef
-- <		The number of leading dashes depends on the foldlevel.  The
-- 		"45" is the number of lines in the fold.  "abcdef" is the text
-- 		in the first non-blank line of the fold.  Leading white space,
-- 		"//" or "/*" and the text from the 'foldmarker' and
-- 		'commentstring' options is removed.
-- 		When used to draw the actual foldtext, the rest of the line
-- 		will be filled with the fold char from the 'fillchars'
-- 		setting.
--- @return string
function vim.fn.foldtext() end

-- The result is the swap file path of the buffer {expr}.
-- 		For the use of {expr}, see |bufname()| above.
-- 		If buffer {expr} is the current buffer, the result is equal to
-- 		|:swapname| (unless no swap file).
-- 		If buffer {expr} has no swap file, returns an empty string.
--- @return string
function vim.fn.swapname(expr) end

-- Set the time Vim uses internally.  Currently only used for
-- 		timestamps in the history, as they are used in viminfo, and
-- 		for undo.
-- 		Using a value of 1 makes Vim not sleep after a warning or
-- 		error message.
-- 		{expr} must evaluate to a number.  When the value is zero the
-- 		normal behavior is restored.
--
-- 		Can also be used as a |method|: >
-- 			GetTime()->test_settime()
--- @return none
function vim.fn.test_settime(expr) end

-- Make a |List| out of {expr}.  When {pattern} is omitted or
-- 		empty each white-separated sequence of characters becomes an
-- 		item.
-- 		Otherwise the string is split where {pattern} matches,
-- 		removing the matched characters. 'ignorecase' is not used
-- 		here, add \c to ignore case. |/\c|
-- 		When the first or last item is empty it is omitted, unless the
-- 		{keepempty} argument is given and it's non-zero.
-- 		Other empty items are kept when {pattern} matches at least one
-- 		character or when {keepempty} is non-zero.
-- 		Example: >
-- 			:let words = split(getline('.'), '\W\+')
-- <		To split a string in individual characters: >
-- 			:for c in split(mystring, '\zs')
-- <		If you want to keep the separator you can also use '\zs' at
-- 		the end of the pattern: >
-- 			:echo split('abc:def:ghi', ':\zs')
-- <			['abc:', 'def:', 'ghi'] ~
-- 		Splitting a table where the first element can be empty: >
-- 			:let items = split(line, ':', 1)
-- <		The opposite function is |join()|.
--- @return list
function vim.fn.split(expr, pat, keepempty) end

-- The result is a Number, which is the screen column of the file
-- 		position given with {expr}.  That is, the last screen position
-- 		occupied by the character at that position, when the screen
-- 		would be of unlimited width.  When there is a <Tab> at the
-- 		position, the returned Number will be the column at the end of
-- 		the <Tab>.  For example, for a <Tab> in column 1, with 'ts'
-- 		set to 8, it returns 8. |conceal| is ignored.
-- 		For the byte position use |col()|.
-- 		For the use of {expr} see |col()|.
-- 		When 'virtualedit' is used {expr} can be [lnum, col, off], where
-- 		"off" is the offset in screen columns from the start of the
-- 		character.  E.g., a position within a <Tab> or after the last
-- 		character.  When "off" is omitted zero is used.
-- 		When Virtual editing is active in the current mode, a position
-- 		beyond the end of the line can be returned. |'virtualedit'|
-- 		The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of displayed characters in the cursor line
-- 			    plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
--   virtcol(".")	   with text "foo^Lbar", with cursor on the "^L", returns 5
--   virtcol("$")	   with text "foo^Lbar", returns 9
--   virtcol("'t")    with text "	  there", with 't at 'h', returns 6
-- <		The first column is 1.  0 is returned for an error.
-- 		A more advanced example that echoes the maximum length of
-- 		all lines: >
-- 		    echo max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
--- @return number
function vim.fn.virtcol(expr) end

-- Set the position for {expr}.  Possible values:
-- 			.	the cursor
-- 			'x	mark x
--
-- 		{list} must be a |List| with four or five numbers:
-- 		    [bufnum, lnum, col, off]
-- 		    [bufnum, lnum, col, off, curswant]
--
-- 		"bufnum" is the buffer number.	Zero can be used for the
-- 		current buffer.  When setting an uppercase mark "bufnum" is
-- 		used for the mark position.  For other marks it specifies the
-- 		buffer to set the mark in.  You can use the |bufnr()| function
-- 		to turn a file name into a buffer number.
-- 		For setting the cursor and the ' mark "bufnum" is ignored,
-- 		since these are associated with a window, not a buffer.
-- 		Does not change the jumplist.
--
-- 		"lnum" and "col" are the position in the buffer.  The first
-- 		column is 1.  Use a zero "lnum" to delete a mark.  If "col" is
-- 		smaller than 1 then 1 is used.
--
-- 		The "off" number is only used when 'virtualedit' is set. Then
-- 		it is the offset in screen columns from the start of the
-- 		character.  E.g., a position within a <Tab> or after the last
-- 		character.
--
-- 		The "curswant" number is only used when setting the cursor
-- 		position.  It sets the preferred column for when moving the
-- 		cursor vertically.  When the "curswant" number is missing the
-- 		preferred column is not set.  When it is present and setting a
-- 		mark position it is not used.
--
-- 		Note that for '< and '> changing the line number may result in
-- 		the marks to be effectively be swapped, so that '< is always
-- 		before '>.
--
-- 		Returns 0 when the position could be set, -1 otherwise.
-- 		An error message is given if {expr} is invalid.
--
-- 		Also see |getpos()| and |getcurpos()|.
--
-- 		This does not restore the preferred column for moving
-- 		vertically; if you set the cursor position with this, |j| and
-- 		|k| motions will jump to previous columns!  Use |cursor()| to
-- 		also set the preferred column.  Also see the "curswant" key in
-- 		|winrestview()|.
--- @param list any[]
--- @return number
function vim.fn.setpos(expr, list) end

-- Just like |function()|, but the returned Funcref will lookup
-- 		the function by reference, not by name.  This matters when the
-- 		function {name} is redefined later.
--
-- 		Unlike |function()|, {name} must be an existing user function.
-- 		Also for autoloaded functions. {name} cannot be a builtin
-- 		function.
--- @param dict dictionary
--- @return funcref
function vim.fn.funcref(name, arglist, dict) end

-- Restore typeahead that was saved with a previous |inputsave()|.
-- 		Should be called the same number of times inputsave() is
-- 		called.  Calling it more often is harmless though.
-- 		Returns 1 when there is nothing to restore, 0 otherwise.
--- @return number
function vim.fn.inputrestore() end

-- Return the current command-line type. Possible return values
-- 		are:
-- 		    :	normal Ex command
-- 		    >	debug mode command |debug-mode|
-- 		    /	forward search command
-- 		    ?	backward search command
-- 		    @	|input()| command
-- 		    -	|:insert| or |:append| command
-- 		    =	|i_CTRL-R_=|
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns an empty string otherwise.
-- 		Also see |getcmdpos()|, |setcmdpos()| and |getcmdline()|.
--- @return string
function vim.fn.getcmdtype() end

-- Get the Job associated with terminal window {buf}.
-- 		{buf} is used as with |term_getsize()|.
-- 		Returns |v:null| when there is no job.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getjob()
--- @return job
function vim.fn.term_getjob(buf) end

-- Change the current working directory to {dir}.  The scope of
-- 		the directory change depends on the directory of the current
-- 		window:
-- 			- If the current window has a window-local directory
-- 			  (|:lcd|), then changes the window local directory.
-- 			- Otherwise, if the current tabpage has a local
-- 			  directory (|:tcd|) then changes the tabpage local
-- 			  directory.
-- 			- Otherwise, changes the global directory.
-- 		If successful, returns the previous working directory.  Pass
-- 		this to another chdir() to restore the directory.
-- 		On failure, returns an empty string.
--
-- 		Example: >
-- 			let save_dir = chdir(newdir)
-- 			if save_dir != ""
-- 			   " ... do some work
-- 			   call chdir(save_dir)
-- 			endif
--
-- <		Can also be used as a |method|: >
-- 			GetDir()->chdir()
--- @return string
function vim.fn.chdir(dir) end

-- Set prompt for buffer {buf} to {text}.  You most likely want
-- 		{text} to end in a space.
-- 		The result is only visible if {buf} has 'buftype' set to
-- 		"prompt".  Example: >
-- 			call prompt_setprompt(bufnr(''), 'command: ')
--- @return none
function vim.fn.prompt_setprompt(buf, text) end

-- The result is a List of Numbers.  The first number is the same
-- 		as what |screenchar()| returns.  Further numbers are
-- 		composing characters on top of the base character.
-- 		This is mainly to be used for testing.
-- 		Returns an empty List when row or col is out of range.
--
-- 		Can also be used as a |method|: >
-- 			GetRow()->screenchars(col)
--- @return list
function vim.fn.screenchars(row, col) end

-- Sends a request to {channel} to invoke {method} via
-- 		|RPC| and blocks until a response is received.
-- 		Example: >
-- 			:let result = rpcrequest(rpc_chan, "func", 1, 2, 3)
--- @return sends
function vim.fn.rpcrequest(channel, method, ...) end

-- Get the virtual text (annotation) for a buffer line.
--
--                 The virtual text is returned as list of lists, whereas the
--                 inner lists have either one or two elements. The first element
--                 is the actual text, the optional second element is the
--                 highlight group.
--
--                 The format is exactly the same as given to
--                 nvim_buf_set_virtual_text().
--
--                 If there is no virtual text associated with the given line, an
--                 empty list is returned.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--                     {line}    Line to get the virtual text from (zero-indexed)
--
--                 Return: ~
--                     List of virtual text chunks
function vim.fn.nvim_buf_get_virtual_text(buffer, lnum) end

-- Return the argument list ID.  This is a number which
-- 		identifies the argument list being used.  Zero is used for the
-- 		global argument list.  See |arglist|.
-- 		Returns -1 if the arguments are invalid.
--
-- 		Without arguments use the current window.
-- 		With {winnr} only use this window in the current tab page.
-- 		With {winnr} and {tabnr} use the window in the specified tab
-- 		page.
-- 		{winnr} can be the window number or the |window-ID|.
--- @return number
function vim.fn.arglistid(winnr, tabnr) end

-- Show the {what} above the cursor, and close it when the cursor
-- 		moves.  This works like: >
-- 			call popup_create({what}, #{
-- 				\ pos: 'botleft',
-- 				\ line: 'cursor-1',
-- 				\ col: 'cursor',
-- 				\ moved: 'WORD',
-- 				\ })
-- <		Use {options} to change the properties.
-- 		If "pos" is passed as "topleft" then the default for "line"
-- 		becomes "cursor+1".
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_atcursor({})
--- @return number
function vim.fn.popup_atcursor(what, options) end

-- Read file {fname} and return a |List|, each line of the file
-- 		as an item.  Lines are broken at NL characters.  Macintosh
-- 		files separated with CR will result in a single long line
-- 		(unless a NL appears somewhere).
-- 		All NUL characters are replaced with a NL character.
-- 		When {binary} contains "b" binary mode is used:
-- 		- When the last line ends in a NL an extra empty list item is
-- 		  added.
-- 		- No CR characters are removed.
-- 		Otherwise:
-- 		- CR characters that appear before a NL are removed.
-- 		- Whether the last line ends in a NL or not does not matter.
-- 		- Any UTF-8 byte order mark is removed from the text.
-- 		When {max} is given this specifies the maximum number of lines
-- 		to be read.  Useful if you only want to check the first ten
-- 		lines of a file: >
-- 			:for line in readfile(fname, '', 10)
-- 			:  if line =~ 'Date' | echo line | endif
-- 			:endfor
-- <		When {max} is negative -{max} lines from the end of the file
-- 		are returned, or as many as there are.
-- 		When {max} is zero the result is an empty list.
-- 		Note that without {max} the whole file is read into memory.
-- 		Also note that there is no recognition of encoding.  Read a
-- 		file into a buffer if you need to.
-- 		When the file can't be opened an error message is given and
-- 		the result is an empty list.
-- 		Also see |writefile()|.
--- @return list
function vim.fn.readfile(fname, binary, max) end

-- Ignore any error containing {expr}.  A normal message is given
-- 		instead.
-- 		This is only meant to be used in tests, where catching the
-- 		error with try/catch cannot be used (because it skips over
-- 		following code).
-- 		{expr} is used literally, not as a pattern.
-- 		When the {expr} is the string "RESET" then the list of ignored
-- 		errors is made empty.
--
-- 		Can also be used as a |method|: >
-- 			GetErrorText()->test_ignore_error()
--- @return none
function vim.fn.test_ignore_error(expr) end

-- Show the {what} near the cursor, handle selecting one of the
-- 		items with cursorkeys, and close it an item is selected with
-- 		Space or Enter. {what} should have multiple lines to make this
-- 		useful.  This works like: >
-- 			call popup_create({what}, #{
-- 				\ pos: 'center',
-- 				\ zindex: 200,
-- 				\ drag: 1,
-- 				\ wrap: 0,
-- 				\ border: [],
-- 				\ cursorline: 1,
-- 				\ padding: [0,1,0,1],
-- 				\ filter: 'popup_filter_menu',
-- 				\ mapping: 0,
-- 				\ })
-- <		The current line is highlighted with a match using
-- 		"PopupSelected", or "PmenuSel" if that is not defined.
--
-- 		Use {options} to change the properties.  Should at least set
-- 		"callback" to a function that handles the selected item.
-- 		Example: >
-- 			func ColorSelected(id, result)
-- 			   " use a:result
-- 			endfunc
-- 			call popup_menu(['red', 'green', 'blue'], #{
-- 				\ callback: 'ColorSelected',
-- 				\ })
--
-- <		Can also be used as a |method|: >
-- 			GetChoices()->popup_menu({})
--- @return number
function vim.fn.popup_menu(what, options) end

-- The result is a Number, which is the width of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero, the width of the current window is
-- 		returned.  When window {nr} doesn't exist, -1 is returned.
-- 		An existing window always has a width of zero or more.
-- 		Examples: >
--   :echo "The current window has " . winwidth(0) . " columns."
--   :if winwidth(0) <= 50
--   :  50 wincmd |
--   :endif
-- <		For getting the terminal or screen size, see the 'columns'
-- 		option.
--- @return number
function vim.fn.winwidth(nr) end

-- Get the ANSI color palette in use by terminal {buf}.
-- 		Returns a List of length 16 where each element is a String
-- 		representing a color in hexadecimal "#rrggbb" format.
-- 		Also see |term_setansicolors()| and |g:terminal_ansi_colors|.
-- 		If neither was used returns the default colors.
--
-- 		{buf} is used as with |term_getsize()|.  If the buffer does not
-- 		exist or is not a terminal window, an empty list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getansicolors()
--
-- <		{only available when compiled with GUI enabled and/or the
-- 		|+termguicolors| feature}
--- @return list
function vim.fn.term_getansicolors(buf) end

-- Expand the file wildcards in {expr}.  See |wildcards| for the
-- 		use of special characters.
--
-- 		Unless the optional {nosuf} argument is given and is |TRUE|,
-- 		the 'suffixes' and 'wildignore' options apply: Names matching
-- 		one of the patterns in 'wildignore' will be skipped and
-- 		'suffixes' affect the ordering of matches.
-- 		'wildignorecase' always applies.
--
-- 		When {list} is present and it is |TRUE| the result is a List
-- 		with all matching files. The advantage of using a List is,
-- 		you also get filenames containing newlines correctly.
-- 		Otherwise the result is a String and when there are several
-- 		matches, they are separated by <NL> characters.
--
-- 		If the expansion fails, the result is an empty String or List.
--
-- 		You can also use |readdir()| if you need to do complicated
-- 		things, such as limiting the number of matches.
--
-- 		A name for a non-existing file is not included.  A symbolic
-- 		link is only included if it points to an existing file.
-- 		However, when the {alllinks} argument is present and it is
-- 		|TRUE| then all symbolic links are included.
--
-- 		For most systems backticks can be used to get files names from
-- 		any external command.  Example: >
-- 			:let tagfiles = glob("`find . -name tags -print`")
-- 			:let &tags = substitute(tagfiles, "\n", ",", "g")
-- <		The result of the program inside the backticks should be one
-- 		item per line.  Spaces inside an item are allowed.
--
-- 		See |expand()| for expanding special Vim variables.  See
-- 		|system()| for getting the raw output of an external command.
--- @param list any[]
function vim.fn.glob(expr, nosuf, list, alllinks) end

-- Return a list containing the number values which represent
-- 		each character in String {expr}.  Examples: >
-- 			str2list(" ")		returns [32]
-- 			str2list("ABC")		returns [65, 66, 67]
-- <		|list2str()| does the opposite.
--
-- 		When {utf8} is omitted or zero, the current 'encoding' is used.
-- 		With {utf8} set to 1, always treat the String as utf-8
-- 		characters.  With utf-8 composing characters are handled
-- 		properly: >
-- 			str2list("á")		returns [97, 769]
--- @return list
function vim.fn.str2list(expr, utf8) end

-- Stop a timer.  The timer callback will no longer be invoked.
-- 		{timer} is an ID returned by timer_start(), thus it must be a
-- 		Number.  If {timer} does not exist there is no error.
--- @return none
function vim.fn.timer_stop(timer) end

-- The result is the name of a buffer, as it is displayed by the
-- 		":ls" command.
-- +		If {expr} is omitted the current buffer is used.
-- 		If {expr} is a Number, that buffer number's name is given.
-- 		Number zero is the alternate buffer for the current window.
-- 		If {expr} is a String, it is used as a |file-pattern| to match
-- 		with the buffer names.  This is always done like 'magic' is
-- 		set and 'cpoptions' is empty.  When there is more than one
-- 		match an empty string is returned.
-- 		"" or "%" can be used for the current buffer, "#" for the
-- 		alternate buffer.
-- 		A full match is preferred, otherwise a match at the start, end
-- 		or middle of the buffer name is accepted.  If you only want a
-- 		full match then put "^" at the start and "$" at the end of the
-- 		pattern.
-- 		Listed buffers are found first.  If there is a single match
-- 		with a listed buffer, that one is returned.  Next unlisted
-- 		buffers are searched for.
-- 		If the {expr} is a String, but you want to use it as a buffer
-- 		number, force it to be a Number by adding zero to it: >
-- 			:echo bufname("3" + 0)
-- <		If the buffer doesn't exist, or doesn't have a name, an empty
-- 		string is returned. >
-- 	bufname("#")		alternate buffer name
-- 	bufname(3)		name of buffer 3
-- 	bufname("%")		name of current buffer
-- 	bufname("file2")	name of buffer where "file2" matches.
--- @return string
function vim.fn.bufname(expr) end

-- Remove the text property type {name}.  When text properties
-- 		using the type {name} are still in place, they will not have
-- 		an effect and can no longer be removed by name.
--
-- 		{props} can contain a "bufnr" item.  When it is given, delete
-- 		a property type from this buffer instead of from the global
-- 		property types.
--
-- 		When text property type {name} is not found there is no error.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_delete()
--- @return none
function vim.fn.prop_type_delete(name, props) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the first line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @return number
function vim.fn.foldclosed(lnum) end

-- This function acts much like the |input()| function with but
-- 		two exceptions:
-- 		a) the user's response will be displayed as a sequence of
-- 		asterisks ("*") thereby keeping the entry secret, and
-- 		b) the user's response will not be recorded on the input
-- 		|history| stack.
-- 		The result is a String, which is whatever the user actually
-- 		typed on the command-line in response to the issued prompt.
-- 		NOTE: Command-line completion is not supported.
--- @return string
function vim.fn.inputsecret(prompt, text) end

