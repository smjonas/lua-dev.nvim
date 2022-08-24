--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Return the sound-folded equivalent of {word}.  Uses the first
-- 		language in 'spelllang' for the current window that supports
-- 		soundfolding.  'spell' must be set.  When no sound folding is
-- 		possible the {word} is returned unmodified.
-- 		This can be used for making spelling suggestions.  Note that
-- 		the method can be quite slow.
function vim.fn.soundfold(word) end

-- The result is a String, which is whatever the user typed on
-- 		the command-line.  The {prompt} argument is either a prompt
-- 		string, or a blank string (for no prompt).  A '\n' can be used
-- 		in the prompt to start a new line.
--
-- 		In the second form it accepts a single dictionary with the
-- 		following keys, any of which may be omitted:
--
-- 		Key           Default  Description ~
-- 		prompt        ""       Same as {prompt} in the first form.
-- 		default       ""       Same as {text} in the first form.
-- 		completion    nothing  Same as {completion} in the first form.
-- 		cancelreturn  ""       Same as {cancelreturn} from
-- 		                       |inputdialog()|. Also works with
-- 		                       input().
-- 		highlight     nothing  Highlight handler: |Funcref|.
--
-- 		The highlighting set with |:echohl| is used for the prompt.
-- 		The input is entered just like a command-line, with the same
-- 		editing commands and mappings.  There is a separate history
-- 		for lines typed for input().
-- 		Example: >
-- 			:if input("Coffee or beer? ") == "beer"
-- 			:  echo "Cheers!"
-- 			:endif
-- <
-- 		If the optional {text} argument is present and not empty, this
-- 		is used for the default reply, as if the user typed this.
-- 		Example: >
-- 			:let color = input("Color? ", "white")
--
-- <		The optional {completion} argument specifies the type of
-- 		completion supported for the input.  Without it completion is
-- 		not performed.  The supported completion types are the same as
-- 		that can be supplied to a user-defined command using the
-- 		"-complete=" argument.  Refer to |:command-completion| for
-- 		more information.  Example: >
-- 			let fname = input("File: ", "", "file")
--
-- <					*input()-highlight* *E5400* *E5402*
-- 		The optional `highlight` key allows specifying function which
-- 		will be used for highlighting user input.  This function
-- 		receives user input as its only argument and must return
-- 		a list of 3-tuples [hl_start_col, hl_end_col + 1, hl_group]
-- 		where
-- 			hl_start_col is the first highlighted column,
-- 			hl_end_col is the last highlighted column (+ 1!),
-- 			hl_group is |:hi| group used for highlighting.
-- 					      *E5403* *E5404* *E5405* *E5406*
-- 		Both hl_start_col and hl_end_col + 1 must point to the start
-- 		of the multibyte character (highlighting must not break
-- 		multibyte characters), hl_end_col + 1 may be equal to the
-- 		input length.  Start column must be in range [0, len(input)),
-- 		end column must be in range (hl_start_col, len(input)],
-- 		sections must be ordered so that next hl_start_col is greater
-- 		then or equal to previous hl_end_col.
--
-- 		Example (try some input with parentheses): >
-- 			highlight RBP1 guibg=Red ctermbg=red
-- 			highlight RBP2 guibg=Yellow ctermbg=yellow
-- 			highlight RBP3 guibg=Green ctermbg=green
-- 			highlight RBP4 guibg=Blue ctermbg=blue
-- 			let g:rainbow_levels = 4
-- 			function! RainbowParens(cmdline)
-- 			  let ret = []
-- 			  let i = 0
-- 			  let lvl = 0
-- 			  while i < len(a:cmdline)
-- 			    if a:cmdline[i] is# '('
-- 			      call add(ret, [i, i + 1, 'RBP' . ((lvl % g:rainbow_levels) + 1)])
-- 			      let lvl += 1
-- 			    elseif a:cmdline[i] is# ')'
-- 			      let lvl -= 1
-- 			      call add(ret, [i, i + 1, 'RBP' . ((lvl % g:rainbow_levels) + 1)])
-- 			    endif
-- 			    let i += 1
-- 			  endwhile
-- 			  return ret
-- 			endfunction
-- 			call input({'prompt':'>','highlight':'RainbowParens'})
-- <
-- 		Highlight function is called at least once for each new
-- 		displayed input string, before command-line is redrawn.  It is
-- 		expected that function is pure for the duration of one input()
-- 		call, i.e. it produces the same output for the same input, so
-- 		output may be memoized.  Function is run like under |:silent|
-- 		modifier. If the function causes any errors, it will be
-- 		skipped for the duration of the current input() call.
--
-- 		Highlighting is disabled if command-line contains arabic
-- 		characters.
--
-- 		NOTE: This function must not be used in a startup file, for
-- 		the versions that only run in GUI mode (e.g., the Win32 GUI).
-- 		Note: When input() is called from within a mapping it will
-- 		consume remaining characters from that mapping, because a
-- 		mapping is handled like the characters were typed.
-- 		Use |inputsave()| before input() and |inputrestore()|
-- 		after input() to avoid that.  Another solution is to avoid
-- 		that further characters follow in the mapping, e.g., by using
-- 		|:execute| or |:normal|.
--
-- 		Example with a mapping: >
-- 			:nmap \x :call GetFoo()<CR>:exe "/" . Foo<CR>
-- 			:function GetFoo()
-- 			:  call inputsave()
-- 			:  let g:Foo = input("enter search pattern: ")
-- 			:  call inputrestore()
-- 			:endfunction
function vim.fn.input(prompt, text, completion) end

-- Return a |List| with all the keys of {dict}.  The |List| is in
-- 		arbitrary order.
--- @param dict dictionary
function vim.fn.keys(dict) end

-- Add {expr} to the list of matches.  Only to be used by the
-- 		function specified with the 'completefunc' option.
-- 		Returns 0 for failure (empty string or out of memory),
-- 		1 when the match was added, 2 when the match was already in
-- 		the list.
-- 		See |complete-functions| for an explanation of {expr}.  It is
-- 		the same as one item in the list that 'omnifunc' would return.
function vim.fn.complete_add(expr) end

-- Return a list with information about timers.
-- 		When {id} is given only information about this timer is
-- 		returned.  When timer {id} does not exist an empty list is
-- 		returned.
-- 		When {id} is omitted information about all timers is returned.
--
-- 		For each timer the information is stored in a Dictionary with
-- 		these items:
-- 		    "id"	    the timer ID
-- 		    "time"	    time the timer was started with
-- 		    "repeat"	    number of times the timer will still fire;
-- 				    -1 means forever
-- 		    "callback"	    the callback
function vim.fn.timer_info(id) end

-- The result is a Number, which gives the byte index in
-- 		{haystack} of the first occurrence of the String {needle}.
-- 		If {start} is specified, the search starts at index {start}.
-- 		This can be used to find a second match: >
-- 			:let colon1 = stridx(line, ":")
-- 			:let colon2 = stridx(line, ":", colon1 + 1)
-- <		The search is done case-sensitive.
-- 		For pattern searches use |match()|.
-- 		-1 is returned if the {needle} does not occur in {haystack}.
-- 		See also |strridx()|.
-- 		Examples: >
-- 		  :echo stridx("An Example", "Example")	     3
-- 		  :echo stridx("Starting point", "Start")    0
-- 		  :echo stridx("Starting point", "start")   -1
-- <						*strstr()* *strchr()*
-- 		stridx() works similar to the C function strstr().  When used
-- 		with a single character it works similar to strchr().
function vim.fn.stridx(haystack, needle, start) end

-- Start logging channel activity to {fname}.
-- 		When {fname} is an empty string: stop logging.
--
-- 		When {mode} is omitted or "a" append to the file.
-- 		When {mode} is "w" start with an empty file.
--
-- 		Use |ch_log()| to write log messages.  The file is flushed
-- 		after every message, on Unix you can use "tail -f" to see what
-- 		is going on in real time.
--
-- 		This function is not available in the |sandbox|.
-- 		NOTE: the channel communication is stored in the file, be
-- 		aware that this may contain confidential and privacy sensitive
-- 		information, e.g. a password you type in a terminal window.
--
-- 		Can also be used as a |method|: >
-- 			'logfile'->ch_logfile('w')
function vim.fn.ch_logfile(fname, mode) end

-- Put up a file requester.  This only works when "has("browse")"
-- 		returns |TRUE| (only in some GUI versions).
-- 		The input fields are:
-- 		    {save}	when |TRUE|, select file to write
-- 		    {title}	title for the requester
-- 		    {initdir}	directory to start browsing in
-- 		    {default}	default file name
-- 		When the "Cancel" button is hit, something went wrong, or
-- 		browsing is not possible, an empty string is returned.
function vim.fn.browse(save, title, initdir, default) end

-- Set tab-local variable {varname} to {val} in tab page {tabnr}.
-- 		|t:var|
-- 		Note that the variable name without "t:" must be used.
-- 		Tabs are numbered starting with one.
-- 		This function is not available in the |sandbox|.
function vim.fn.settabvar(nr, varname, val) end

-- Move the Vim server with the name {server} to the foreground.
-- 		This works like: >
-- 			remote_expr({server}, "foreground()")
-- <		Except that on Win32 systems the client does the work, to work
-- 		around the problem that the OS doesn't always allow the server
-- 		to bring itself to the foreground.
-- 		Note: This does not restore the window if it was minimized,
-- 		like foreground() does.
-- 		This function is not available in the |sandbox|.
-- 		{only in the Win32 GUI and the Win32 console version}
function vim.fn.remote_foreground(server) end

-- Returns a |List| with all matches previously defined for the
-- 		current window by |matchadd()| and the |:match| commands.
-- 		|getmatches()| is useful in combination with |setmatches()|,
-- 		as |setmatches()| can restore a list of matches saved by
-- 		|getmatches()|.
-- 		Example: >
-- 			:echo getmatches()
-- <			[{'group': 'MyGroup1', 'pattern': 'TODO',
-- 			'priority': 10, 'id': 1}, {'group': 'MyGroup2',
-- 			'pattern': 'FIXME', 'priority': 10, 'id': 2}] >
-- 			:let m = getmatches()
-- 			:call clearmatches()
-- 			:echo getmatches()
-- <			[] >
-- 			:call setmatches(m)
-- 			:echo getmatches()
-- <			[{'group': 'MyGroup1', 'pattern': 'TODO',
-- 			'priority': 10, 'id': 1}, {'group': 'MyGroup2',
-- 			'pattern': 'FIXME', 'priority': 10, 'id': 2}] >
-- 			:unlet m
-- <
function vim.fn.getmatches() end

-- Only for an expression in a |:substitute| command or
-- 		substitute() function.
-- 		Returns the {nr}'th submatch of the matched text.  When {nr}
-- 		is 0 the whole matched text is returned.
-- 		Note that a NL in the string can stand for a line break of a
-- 		multi-line match or a NUL character in the text.
-- 		Also see |sub-replace-expression|.
--
-- 		If {list} is present and non-zero then submatch() returns
-- 		a list of strings, similar to |getline()| with two arguments.
-- 		NL characters in the text represent NUL characters in the
-- 		text.
-- 		Only returns more than one item for |:substitute|, inside
-- 		|substitute()| this list will always contain one or zero
-- 		items, since there are no real line breaks.
--
-- 		When substitute() is used recursively only the submatches in
-- 		the current (deepest) call can be obtained.
--
-- 		Examples: >
-- 			:s/\d\+/\=submatch(0) + 1/
-- 			:echo substitute(text, '\d\+', '\=submatch(0) + 1', '')
-- <		This finds the first number in the line and adds one to it.
-- 		A line break is included as a newline character.
--- @param list any[]
function vim.fn.submatch(nr, list) end

-- The result is a String, which is the read, write, and execute
-- 		permissions of the given file {fname}.
-- 		If {fname} does not exist or its directory cannot be read, an
-- 		empty string is returned.
-- 		The result is of the form "rwxrwxrwx", where each group of
-- 		"rwx" flags represent, in turn, the permissions of the owner
-- 		of the file, the group the file belongs to, and other users.
-- 		If a user does not have a given permission the flag for this
-- 		is replaced with the string "-".  Examples: >
-- 			:echo getfperm("/etc/passwd")
-- 			:echo getfperm(expand("~/.config/nvim/init.vim"))
-- <		This will hopefully (from a security point of view) display
-- 		the string "rw-r--r--" or even "rw-------".
--
-- 		For setting permissions use |setfperm()|.
function vim.fn.getfperm(fname) end

--- @param list any[]
function vim.fn.sign_unplacelist(list) end

-- Return all of environment variables as dictionary. You can
-- 		check if an environment variable exists like this: >
-- 			:echo has_key(environ(), 'HOME')
-- <		Note that the variable name may be CamelCase; to ignore case
-- 		use this: >
-- 			:echo index(keys(environ()), 'HOME', 0, 1) != -1
function vim.fn.environ() end

-- Return a |List| that is null. Only useful for testing.
function vim.fn.test_null_list() end

-- Get the size of terminal {buf}. Returns a list with two
-- 		numbers: [rows, cols].  This is the size of the terminal, not
-- 		the window containing the terminal.
--
-- 		{buf} must be the buffer number of a terminal window.  Use an
-- 		empty string for the current buffer.  If the buffer does not
-- 		exist or is not a terminal window, an empty list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getsize()
function vim.fn.term_getsize(buf) end

-- Same as |search()|, but returns a |List| with the line and
-- 		column position of the match. The first element of the |List|
-- 		is the line number and the second element is the byte index of
-- 		the column position of the match. If no match is found,
-- 		returns [0, 0].
-- 		Example: >
-- 	:let [lnum, col] = searchpos('mypattern', 'n')
--
-- <		When the 'p' flag is given then there is an extra item with
-- 		the sub-pattern match number |search()-sub-match|.  Example: >
-- 	:let [lnum, col, submatch] = searchpos('\(\l\)\|\(\u\)', 'np')
-- <		In this example "submatch" is 2 when a lowercase letter is
-- 		found |/\l|, 3 when an uppercase letter is found |/\u|.
function vim.fn.searchpos(pattern, flags, stopline, timeout) end

-- {expr1} must be a |List| or a |Dictionary|.
-- 		For each item in {expr1} evaluate {expr2} and when the result
-- 		is zero remove the item from the |List| or |Dictionary|.
-- 		{expr2} must be a |string| or |Funcref|.
--
-- 		If {expr2} is a |string|, inside {expr2} |v:val| has the value
-- 		of the current item.  For a |Dictionary| |v:key| has the key
-- 		of the current item and for a |List| |v:key| has the index of
-- 		the current item.
-- 		For a |Dictionary| |v:key| has the key of the current item.
-- 		Examples: >
-- 			call filter(mylist, 'v:val !~ "OLD"')
-- <		Removes the items where "OLD" appears. >
-- 			call filter(mydict, 'v:key >= 8')
-- <		Removes the items with a key below 8. >
-- 			call filter(var, 0)
-- <		Removes all the items, thus clears the |List| or |Dictionary|.
--
-- 		Note that {expr2} is the result of expression and is then
-- 		used as an expression again.  Often it is good to use a
-- 		|literal-string| to avoid having to double backslashes.
--
-- 		If {expr2} is a |Funcref| it must take two arguments:
-- 			1. the key or the index of the current item.
-- 			2. the value of the current item.
-- 		The function must return |TRUE| if the item should be kept.
-- 		Example that keeps the odd items of a list: >
-- 			func Odd(idx, val)
-- 			  return a:idx % 2 == 1
-- 			endfunc
-- 			call filter(mylist, function('Odd'))
-- <		It is shorter when using a |lambda|: >
-- 			call filter(myList, {idx, val -> idx * val <= 42})
-- <		If you do not use "val" you can leave it out: >
-- 			call filter(myList, {idx -> idx % 2 == 1})
-- <
-- 		The operation is done in-place.  If you want a |List| or
-- 		|Dictionary| to remain unmodified make a copy first: >
-- 			:let l = filter(copy(mylist), 'v:val =~ "KEEP"')
--
-- <		Returns {expr1}, the |List| or |Dictionary| that was filtered.
-- 		When an error is encountered while evaluating {expr2} no
-- 		further items in {expr1} are processed. When {expr2} is a
-- 		Funcref errors inside a function are ignored, unless it was
-- 		defined with the "abort" flag.
function vim.fn.filter(expr1, expr2) end

-- The result is a String, which describes the last Visual mode
-- 		used in the current buffer.  Initially it returns an empty
-- 		string, but once Visual mode has been used, it returns "v",
-- 		"V", or "<CTRL-V>" (a single CTRL-V character) for
-- 		character-wise, line-wise, or block-wise Visual mode
-- 		respectively.
-- 		Example: >
-- 			:exe "normal " . visualmode()
-- <		This enters the same Visual mode as before.  It is also useful
-- 		in scripts if you wish to act differently depending on the
-- 		Visual mode that was used.
-- 		If Visual mode is active, use |mode()| to get the Visual mode
-- 		(e.g., in a |:vmap|).
-- 		If [expr] is supplied and it evaluates to a non-zero Number or
-- 		a non-empty String, then the Visual mode will be cleared and
-- 		the old value is returned.  See |non-zero-arg|.
function vim.fn.visualmode(expr) end

-- Float, String or a composition of them, then the result can be
-- 		parsed back with |eval()|.
-- 			{expr} type	result ~
-- 			String		'string'
-- 			Number		123
-- 			Float		123.123456 or 1.123456e8 or
-- 					`str2float('inf')`
-- 			Funcref		`function('name')`
-- 			List		[item, item]
-- 			Dictionary	{key: value, key: value}
-- 		Note that in String values the ' character is doubled.
-- 		Also see |strtrans()|.
-- 		Note 2: Output format is mostly compatible with YAML, except
-- 		for infinite and NaN floating-point values representations
-- 		which use |str2float()|.  Strings are also dumped literally,
-- 		only single quote is escaped, which does not allow using YAML
-- 		for parsing back binary strings.  |eval()| should always work for
-- 		strings and floats though and this is the only official
-- 		method, use |msgpackdump()| or |json_encode()| if you need to
-- 		share data with other application.
function vim.fn.string(expr) end

-- Override options in popup {id} with entries in {options}.
-- 		These options can be set:
-- 			border
-- 			borderchars
-- 			borderhighlight
-- 			callback
-- 			close
-- 			cursorline
-- 			drag
-- 			filter
-- 			firstline
-- 			flip
-- 			highlight
-- 			mapping
-- 			mask
-- 			moved
-- 			padding
-- 			resize
-- 			scrollbar
-- 			scrollbarhighlight
-- 			thumbhighlight
-- 			time
-- 			title
-- 			wrap
-- 			zindex
-- 		The options from |popup_move()| can also be used.
-- 		For "hidden" use |popup_hide()| and |popup_show()|.
-- 		"tabpage" cannot be changed.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_setoptions(options)
function vim.fn.popup_setoptions(id, options) end

-- This function checks if an executable with the name {expr}
-- 		exists.  {expr} must be the name of the program without any
-- 		arguments.
-- 		executable() uses the value of $PATH and/or the normal
-- 		searchpath for programs.		*PATHEXT*
-- 		On Windows the ".exe", ".bat", etc. can
-- 		optionally be included.  Then the extensions in $PATHEXT are
-- 		tried.  Thus if "foo.exe" does not exist, "foo.exe.bat" can be
-- 		found.  If $PATHEXT is not set then ".exe;.com;.bat;.cmd" is
-- 		used.  A dot by itself can be used in $PATHEXT to try using
-- 		the name without an extension.  When 'shell' looks like a
-- 		Unix shell, then the name is also tried without adding an
-- 		extension.
-- 		On Windows it only checks if the file exists and
-- 		is not a directory, not if it's really executable.
-- 		On Windows an executable in the same directory as Vim is
-- 		always found (it is added to $PATH at |startup|).
-- 		The result is a Number:
-- 			1	exists
-- 			0	does not exist
-- 			-1	not implemented on this system
-- 		|exepath()| can be used to get the full path of an executable.
function vim.fn.executable(expr) end

-- Split {msg} into lines to be displayed in a balloon.  The
-- 		splits are made for the current window size and optimize to
-- 		show debugger output.
-- 		Returns a |List| with the split lines.
-- 		Can also be used as a |method|: >
-- 			GetText()->balloon_split()->balloon_show()
--
-- <		{only available when compiled with the |+balloon_eval_term|
-- 		feature}
function vim.fn.balloon_split(msg) end

-- Just like |finddir()|, but find a file instead of a directory.
-- 		Uses 'suffixesadd'.
-- 		Example: >
-- 			:echo findfile("tags.vim", ".;")
-- <		Searches from the directory of the current file upwards until
-- 		it finds the file "tags.vim".
function vim.fn.findfile(name, path, count) end

-- Become the server {name}.  This fails if already running as a
-- 		server, when |v:servername| is not empty.
function vim.fn.remote_startserver(name) end

-- Wait for pending updates of {buf} to be handled.
-- 		{buf} is used as with |term_getsize()|.
-- 		{time} is how long to wait for updates to arrive in msec.  If
-- 		not set then 10 msec will be used.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_wait()
function vim.fn.term_wait(buf, time) end

-- {expr} in bytes.
-- 		If the argument is a Number it is first converted to a String.
-- 		For other types an error is given.
-- 		If you want to count the number of multi-byte characters use
-- 		|strchars()|.
-- 		Also see |len()|, |strdisplaywidth()| and |strwidth()|.
function vim.fn.strlen(expr) end

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce a beep or visual bell.
-- 		Also see |assert_fails()| and |assert-return|.
function vim.fn.assert_beeps(cmd) end

-- The result is a Number, which is the current screen column of
-- 		the cursor. The leftmost column has number 1.
-- 		This function is mainly used for testing.
--
-- 		Note: Always returns the current screen column, thus if used
-- 		in a command (e.g. ":echo screencol()") it will return the
-- 		column inside the command line, which is 1 when the command is
-- 		executed. To get the cursor position in the file use one of
-- 		the following mappings: >
-- 			nnoremap <expr> GG ":echom ".screencol()."\n"
-- 			nnoremap <silent> GG :echom screencol()<CR>
-- 			noremap GG <Cmd>echom screencol()<Cr>
function vim.fn.screencol() end

-- Call function {func} with the items in |List| {arglist} as
-- 		arguments.
-- 		{func} can either be a |Funcref| or the name of a function.
-- 		a:firstline and a:lastline are set to the cursor line.
-- 		Returns the return value of the called function.
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--- @param dict dictionary
function vim.fn.call(func, arglist, dict) end

-- The result is a Number, which is the |window-ID| of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinid(1))
-- <
-- 		Only deals with the current tab page.
function vim.fn.bufwinid(expr) end

-- Returns the single letter name of the register being executed.
-- 		Returns an empty string when no register is being executed.
-- 		See |@|.
function vim.fn.reg_executing() end

-- Add the String {item} to the history {history} which can be
-- 		one of:					*hist-names*
-- 			"cmd"	 or ":"	  command line history
-- 			"search" or "/"   search pattern history
-- 			"expr"	 or "="   typed expression history
-- 			"input"  or "@"	  input line history
-- 			"debug"  or ">"   debug command history
-- 			empty		  the current or last used history
-- 		The {history} string does not need to be the whole name, one
-- 		character is sufficient.
-- 		If {item} does already exist in the history, it will be
-- 		shifted to become the newest entry.
-- 		The result is a Number: 1 if the operation was successful,
-- 		otherwise 0 is returned.
--
-- 		Example: >
-- 			:call histadd("input", strftime("%Y %b %d"))
-- 			:let date=input("Enter date: ")
-- <		This function is not available in the |sandbox|.
function vim.fn.histadd(history, item) end

-- Read from {handle} and return the received message.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		For a NL channel this waits for a NL to arrive, except when
-- 		there is nothing more to read (channel was closed).
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_read()
function vim.fn.ch_read(handle, options) end

-- Initialize seed used by |rand()|:
-- 		- If {expr} is not given, seed values are initialized by
-- 		  reading from /dev/urandom, if possible, or using time(NULL)
-- 		  a.k.a. epoch time otherwise; this only has second accuracy.
-- 		- If {expr} is given it must be a Number.  It is used to
-- 		  initialize the seed values.  This is useful for testing or
-- 		  when a predictable sequence is intended.
--
-- 		Examples: >
-- 			:let seed = srand()
-- 			:let seed = srand(userinput)
-- 			:echo rand(seed)
function vim.fn.srand(expr) end

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
function vim.fn.ctxset(context, index) end

-- Close a channel or a specific stream associated with it.
-- 		For a job, {stream} can be one of "stdin", "stdout",
-- 		"stderr" or "rpc" (closes stdin/stdout for a job started
-- 		with `"rpc":v:true`) If {stream} is omitted, all streams
-- 		are closed. If the channel is a pty, this will then close the
-- 		pty master, sending SIGHUP to the job process.
-- 		For a socket, there is only one stream, and {stream} should be
-- 		ommited.
function vim.fn.chanclose(id, stream) end

-- Returns the effective value of 'shiftwidth'. This is the
-- 		'shiftwidth' value unless it is zero, in which case it is the
-- 		'tabstop' value.  To be backwards compatible in indent
-- 		plugins, use this: >
-- 			if exists('*shiftwidth')
-- 			  func s:sw()
-- 			    return shiftwidth()
-- 			  endfunc
-- 			else
-- 			  func s:sw()
-- 			    return &sw
-- 			  endfunc
-- 			endif
-- <		And then use s:sw() instead of &sw.
function vim.fn.shiftwidth() end

-- Return a |List|, which is the stack of syntax items at the
-- 		position {lnum} and {col} in the current window.  Each item in
-- 		the List is an ID like what |synID()| returns.
-- 		The first item in the List is the outer region, following are
-- 		items contained in that one.  The last one is what |synID()|
-- 		returns, unless not the whole item is highlighted or it is a
-- 		transparent item.
-- 		This function is useful for debugging a syntax file.
-- 		Example that shows the syntax stack under the cursor: >
-- 			for id in synstack(line("."), col("."))
-- 			   echo synIDattr(id, "name")
-- 			endfor
-- <		When the position specified with {lnum} and {col} is invalid
-- 		nothing is returned.  The position just after the last
-- 		character in a line and the first column in an empty line are
-- 		valid positions.
function vim.fn.synstack(lnum, col) end

-- Returns Dictionary of |api-metadata|.
--
-- 		View it in a nice human-readable format: >
-- 		       :lua print(vim.inspect(vim.fn.api_info()))
function vim.fn.api_info() end

-- Spawns {cmd} as a job.
-- 		If {cmd} is a List it runs directly (no 'shell').
-- 		If {cmd} is a String it runs in the 'shell', like this: >
-- 		  :call jobstart(split(&shell) + split(&shellcmdflag) + ['{cmd}'])
-- <		(See |shell-unquoting| for details.)
--
-- 		Example: >
-- 		  :call jobstart('nvim -h', {'on_stdout':{j,d,e->append(line('.'),d)}})
-- <
-- 		Returns |job-id| on success, 0 on invalid arguments (or job
-- 		table is full), -1 if {cmd}[0] or 'shell' is not executable.
-- 		The returned job-id is a valid |channel-id| representing the
-- 		job's stdio streams. Use |chansend()| (or |rpcnotify()| and
-- 		|rpcrequest()| if "rpc" was enabled) to send data to stdin and
-- 		|chanclose()| to close the streams without stopping the job.
--
-- 		See |job-control| and |RPC|.
--
-- 		NOTE: on Windows if {cmd} is a List:
-- 		  - cmd[0] must be an executable (not a "built-in"). If it is
-- 		    in $PATH it can be called by name, without an extension: >
-- 		      :call jobstart(['ping', 'neovim.io'])
-- <		    If it is a full or partial path, extension is required: >
-- 		      :call jobstart(['System32\ping.exe', 'neovim.io'])
-- <		  - {cmd} is collapsed to a string of quoted args as expected
-- 		    by CommandLineToArgvW https://msdn.microsoft.com/bb776391
-- 		    unless cmd[0] is some form of "cmd.exe".
--
-- 							*jobstart-options*
-- 		{opts} is a dictionary with these keys:
-- 		  clear_env:  (boolean) `env` defines the job environment
-- 			      exactly, instead of merging current environment.
-- 		  cwd:	      (string, default=|current-directory|) Working
-- 			      directory of the job.
-- 		  detach:     (boolean) Detach the job process: it will not be
-- 			      killed when Nvim exits. If the process exits
-- 			      before Nvim, `on_exit` will be invoked.
-- 		  env:	      (dict) Map of environment variable name:value
-- 			      pairs extending (or replacing if |clear_env|)
-- 			      the current environment.
-- 		  height:     (number) Height of the `pty` terminal.
-- 		  |on_exit|:    (function) Callback invoked when the job exits.
-- 		  |on_stdout|:  (function) Callback invoked when the job emits
-- 			      stdout data.
-- 		  |on_stderr|:  (function) Callback invoked when the job emits
-- 			      stderr data.
-- 		  pty:	      (boolean) Connect the job to a new pseudo
-- 			      terminal, and its streams to the master file
-- 			      descriptor. Then  `on_stderr` is ignored,
-- 			      `on_stdout` receives all output.
-- 		  rpc:	      (boolean) Use |msgpack-rpc| to communicate with
-- 			      the job over stdio. Then `on_stdout` is ignored,
-- 			      but `on_stderr` can still be used.
-- 		  stderr_buffered: (boolean) Collect data until EOF (stream closed)
-- 			      before invoking `on_stderr`. |channel-buffered|
-- 		  stdout_buffered: (boolean) Collect data until EOF (stream
-- 			      closed) before invoking `on_stdout`. |channel-buffered|
-- 		  TERM:	      (string) Sets the `pty` $TERM environment variable.
-- 		  width:      (number) Width of the `pty` terminal.
--
-- 		{opts} is passed as |self| dictionary to the callback; the
-- 		caller may set other keys to pass application-specific data.
--
-- 		Returns:
-- 		  - |channel-id| on success
-- 		  - 0 on invalid arguments
-- 		  - -1 if {cmd}[0] is not executable.
-- 		See also |job-control|, |channel|, |msgpack-rpc|.
function vim.fn.jobstart(cmd, opts) end

-- Close {handle}.  See |channel-close|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close()
function vim.fn.ch_close(handle) end

-- Return the current character search information as a {dict}
-- 		with the following entries:
--
-- 		    char	character previously used for a character
-- 				search (|t|, |f|, |T|, or |F|); empty string
-- 				if no character search has been performed
-- 		    forward	direction of character search; 1 for forward,
-- 				0 for backward
-- 		    until	type of character search; 1 for a |t| or |T|
-- 				character search, 0 for an |f| or |F|
-- 				character search
--
-- 		This can be useful to always have |;| and |,| search
-- 		forward/backward regardless of the direction of the previous
-- 		character search: >
-- 			:nnoremap <expr> ; getcharsearch().forward ? ';' : ','
-- 			:nnoremap <expr> , getcharsearch().forward ? ',' : ';'
-- <		Also see |setcharsearch()|.
function vim.fn.getcharsearch() end

-- Return the sine of {expr}, measured in radians, as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo sin(100)
-- <			-0.506366 >
-- 			:echo sin(-4.01)
-- <			0.763301
function vim.fn.sin(expr) end

-- Rename the file by the name {from} to the name {to}.  This
-- 		should also work to move files across file systems.  The
-- 		result is a Number, which is 0 if the file was renamed
-- 		successfully, and non-zero when the renaming failed.
-- 		NOTE: If {to} exists it is overwritten without warning.
-- 		This function is not available in the |sandbox|.
function vim.fn.rename(from, to) end

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
function vim.fn.byte2line(byte) end

-- Return the Number 1 if {expr} is empty, zero otherwise.
-- 		A |List| or |Dictionary| is empty when it does not have any
-- 		items.  A Number is empty when its value is zero.  Special
-- 		variable is empty when it is |v:false| or |v:null|.
function vim.fn.empty(expr) end

-- Set a flag to enable the effect of 'autochdir' before Vim
-- 		startup has finished.
function vim.fn.test_autochdir() end

-- Write {msg} in the channel log file, if it was opened with
-- 		|ch_logfile()|.
-- 		When {handle} is passed the channel number is used for the
-- 		message.
-- 		{handle} can be a Channel or a Job that has a Channel.  The
-- 		Channel must be open for the channel number to be used.
--
-- 		Can also be used as a |method|: >
-- 			'did something'->ch_log()
function vim.fn.ch_log(msg, handle) end

-- Set option or local variable {varname} in window {winnr} to
-- 		{val}.
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |setwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global or local buffer option, but it
-- 		doesn't work for a global or local buffer variable.
-- 		For a local buffer option the global value is unchanged.
-- 		Note that the variable name without "w:" must be used.
-- 		Examples: >
-- 			:call settabwinvar(1, 1, "&list", 0)
-- 			:call settabwinvar(3, 2, "myvar", "foobar")
-- <		This function is not available in the |sandbox|.
function vim.fn.settabwinvar(tabnr, winnr, varname, val) end

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies on the screen when it starts at {col}
-- 		(first column is zero).  When {col} is omitted zero is used.
-- 		Otherwise it is the screen column where to start.  This
-- 		matters for Tab characters.
-- 		The option settings of the current window are used.  This
-- 		matters for anything that's displayed differently, such as
-- 		'tabstop' and 'display'.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strwidth()| and |strchars()|.
function vim.fn.strdisplaywidth(expr, col) end

-- The result is a nested List containing the layout of windows
-- 		in a tabpage.
--
-- 		Without {tabnr} use the current tabpage, otherwise the tabpage
-- 		with number {tabnr}. If the tabpage {tabnr} is not found,
-- 		returns an empty list.
--
-- 		For a leaf window, it returns:
-- 			['leaf', {winid}]
-- 		For horizontally split windows, which form a column, it
-- 		returns:
-- 			['col', [{nested list of windows}]]
-- 		For vertically split windows, which form a row, it returns:
-- 			['row', [{nested list of windows}]]
--
-- 		Example: >
-- 			" Only one window in the tab page
-- 			:echo winlayout()
-- 			['leaf', 1000]
-- 			" Two horizontally split windows
-- 			:echo winlayout()
-- 			['col', [['leaf', 1000], ['leaf', 1001]]]
-- 			" Three horizontally split windows, with two
-- 			" vertically split windows in the middle window
-- 			:echo winlayout(2)
-- 			['col', [['leaf', 1002], ['row', ['leaf', 1003],
-- 					     ['leaf', 1001]]], ['leaf', 1000]]
-- <
function vim.fn.winlayout(tabnr) end

-- Like |settabwinvar()| for the current tab page.
-- 		Examples: >
-- 			:call setwinvar(1, "&list", 0)
-- 			:call setwinvar(2, "myvar", "foobar")
function vim.fn.setwinvar(nr, varname, val) end

-- Returns a |String| which is a unique identifier of the
-- 		container type (|List|, |Dict| and |Partial|). It is
-- 		guaranteed that for the mentioned types `id(v1) ==# id(v2)`
-- 		returns true iff `type(v1) == type(v2) && v1 is v2` (note:
-- 		|v:_null_list| and |v:_null_dict| have the same `id()` with
-- 		different types because they are internally represented as
-- 		a NULL pointers). Currently `id()` returns a hexadecimal
-- 		representanion of the pointers to the containers (i.e. like
-- 		`0x994a40`), same as `printf("%p", {expr})`, but it is advised
-- 		against counting on exact format of return value.
--
-- 		It is not guaranteed that `id(no_longer_existing_container)`
-- 		will not be equal to some other `id()`: new containers may
-- 		reuse identifiers of the garbage-collected ones.
function vim.fn.id(expr) end

-- Return a string with a single character, which has the number
-- 		value {expr}.  Examples: >
-- 			nr2char(64)		returns "@"
-- 			nr2char(32)		returns " "
-- <		Example for "utf-8": >
-- 			nr2char(300)		returns I with bow character
-- <		UTF-8 encoding is always used, {utf8} option has no effect,
-- 		and exists only for backwards-compatibility.
-- 		Note that a NUL character in the file is specified with
-- 		nr2char(10), because NULs are represented with newline
-- 		characters.  nr2char(0) is a real NUL and terminates the
-- 		string, thus results in an empty string.
--
-- nvim_...({...})					*E5555* *nvim_...()* *eval-api*
-- 		Call nvim |api| functions. The type checking of arguments will
-- 		be stricter than for most other builtins. For instance,
-- 		if Integer is expected, a |Number| must be passed in, a
-- 		|String| will not be autoconverted.
-- 		Buffer numbers, as returned by |bufnr()| could be used as
-- 		first argument to nvim_buf_... functions.  All functions
-- 		expecting an object (buffer, window or tabpage) can
-- 		also take the numerical value 0 to indicate the current
-- 		(focused) object.
function vim.fn.nr2char(expr, utf8) end

-- Checks for the existence of a |cscope| connection.  If no
-- 		parameters are specified, then the function returns:
-- 			0, if cscope was not available (not compiled in), or
-- 			   if there are no cscope connections;
-- 			1, if there is at least one cscope connection.
--
-- 		If parameters are specified, then the value of {num}
-- 		determines how existence of a cscope connection is checked:
--
-- 		{num}	Description of existence check
-- 		-----	------------------------------
-- 		0	Same as no parameters (e.g., "cscope_connection()").
-- 		1	Ignore {prepend}, and use partial string matches for
-- 			{dbpath}.
-- 		2	Ignore {prepend}, and use exact string matches for
-- 			{dbpath}.
-- 		3	Use {prepend}, use partial string matches for both
-- 			{dbpath} and {prepend}.
-- 		4	Use {prepend}, use exact string matches for both
-- 			{dbpath} and {prepend}.
--
-- 		Note: All string comparisons are case sensitive!
--
-- 		Examples.  Suppose we had the following (from ":cs show"): >
--
--   # pid    database name			prepend path
--   0 27664  cscope.out				/usr/local
-- <
-- 		Invocation					Return Val ~
-- 		----------					---------- >
-- 		cscope_connection()					1
-- 		cscope_connection(1, "out")				1
-- 		cscope_connection(2, "out")				0
-- 		cscope_connection(3, "out")				0
-- 		cscope_connection(3, "out", "local")			1
-- 		cscope_connection(4, "out")				0
-- 		cscope_connection(4, "out", "local")			0
-- 		cscope_connection(4, "cscope.out", "/usr/local")	1
-- <
function vim.fn.cscope_connection(num, dbpath, prepend) end

-- The result is a Dict, which is the tag stack of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is not specified, the current window is used.
-- 		When window {nr} doesn't exist, an empty Dict is returned.
--
-- 		The returned dictionary contains the following entries:
-- 			curidx		Current index in the stack. When at
-- 					top of the stack, set to (length + 1).
-- 					Index of bottom of the stack is 1.
-- 			items		List of items in the stack. Each item
-- 					is a dictionary containing the
-- 					entries described below.
-- 			length		Number of entries in the stack.
--
-- 		Each item in the stack is a dictionary with the following
-- 		entries:
-- 			bufnr		buffer number of the current jump
-- 			from		cursor position before the tag jump.
-- 					See |getpos()| for the format of the
-- 					returned list.
-- 			matchnr		current matching tag number. Used when
-- 					multiple matching tags are found for a
-- 					name.
-- 			tagname		name of the tag
--
-- 		See |tagstack| for more information about the tag stack.
function vim.fn.gettagstack(nr) end

-- Set environment variable {name} to {val}.
-- 		When {val} is |v:null| the environment variable is deleted.
-- 		See also |expr-env|.
function vim.fn.setenv(name, val) end

-- position given with {expr}.  The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of bytes in the cursor line plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Additionally {expr} can be [lnum, col]: a |List| with the line
-- 		and column number. Most useful when the column is "$", to get
-- 		the last column of a specific line.  When "lnum" or "col" is
-- 		out of range then col() returns zero.
-- 		To get the line number use |line()|.  To get both use
-- 		|getpos()|.
-- 		For the screen column position use |virtcol()|.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
-- 			col(".")		column of cursor
-- 			col("$")		length of cursor line plus one
-- 			col("'t")		column of mark t
-- 			col("'" . markname)	column of mark markname
-- <		The first column is 1.  0 is returned for an error.
-- 		For an uppercase mark the column may actually be in another
-- 		buffer.
-- 		For the cursor position, when 'virtualedit' is active, the
-- 		column is one higher if the cursor is after the end of the
-- 		line.  This can be used to obtain the column in Insert mode: >
-- 			:imap <F2> <C-O>:let save_ve = &ve<CR>
-- 				\<C-O>:set ve=all<CR>
-- 				\<C-O>:echo col(".") . "\n" <Bar>
-- 				\let &ve = save_ve<CR>
-- <
function vim.fn.col(expr) end

-- The opposite of `assert_equal()`: add an error message to
-- 		|v:errors| when {expected} and {actual} are equal.
-- 		Also see |assert-return|.
function vim.fn.assert_notequal(exp, act, msg) end

-- the current window sizes.  Only works properly when no windows
-- 		are opened or closed and the current window and tab page is
-- 		unchanged.
-- 		Example: >
-- 			:let cmd = winrestcmd()
-- 			:call MessWithWindowSizes()
-- 			:exe cmd
-- <
function vim.fn.winrestcmd() end

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

-- Convert each number in {list} to a character string can
-- 		concatenate them all.  Examples: >
-- 			list2str([32])		returns " "
-- 			list2str([65, 66, 67])	returns "ABC"
-- <		The same can be done (slowly) with: >
-- 			join(map(list, {nr, val -> nr2char(val)}), '')
-- <		|str2list()| does the opposite.
--
-- 		When {utf8} is omitted or zero, the current 'encoding' is used.
-- 		With {utf8} is 1, always return utf-8 characters.
-- 		With utf-8 composing characters work as expected: >
-- 			list2str([97, 769])	returns "á"
--- @param list any[]
function vim.fn.list2str(list, utf8) end

-- see |line()|.  For getting the cursor position see
-- 		|getcurpos()|.
-- 		The result is a |List| with four numbers:
-- 		    [bufnum, lnum, col, off]
-- 		"bufnum" is zero, unless a mark like '0 or 'A is used, then it
-- 		is the buffer number of the mark.
-- 		"lnum" and "col" are the position in the buffer.  The first
-- 		column is 1.
-- 		The "off" number is zero, unless 'virtualedit' is used.  Then
-- 		it is the offset in screen columns from the start of the
-- 		character.  E.g., a position within a <Tab> or after the last
-- 		character.
-- 		Note that for '< and '> Visual mode matters: when it is "V"
-- 		(visual line mode) the column of '< is zero and the column of
-- 		'> is a large number.
-- 		This can be used to save and restore the position of a mark: >
-- 			let save_a_mark = getpos("'a")
-- 			...
-- 			call setpos("'a", save_a_mark)
-- <		Also see |getcurpos()| and |setpos()|.
function vim.fn.getpos(expr) end

-- TODO: Documentation
function vim.fn.nvim_ui_try_resize(width, height) end

-- Without an argument returns the name of the normal font being
-- 		used.  Like what is used for the Normal highlight group
-- 		|hl-Normal|.
-- 		With an argument a check is done whether {name} is a valid
-- 		font name.  If not then an empty string is returned.
-- 		Otherwise the actual font name is returned, or {name} if the
-- 		GUI does not support obtaining the real name.
-- 		Only works when the GUI is running, thus not in your vimrc or
-- 		gvimrc file.  Use the |GUIEnter| autocommand to use this
-- 		function just after the GUI has started.
function vim.fn.getfontname(name) end

-- Without {end} the result is a String, which is line {lnum}
-- 		from the current buffer.  Example: >
-- 			getline(1)
-- <		When {lnum} is a String that doesn't start with a
-- 		digit, |line()| is called to translate the String into a Number.
-- 		To get the line under the cursor: >
-- 			getline(".")
-- <		When {lnum} is smaller than 1 or bigger than the number of
-- 		lines in the buffer, an empty string is returned.
--
-- 		When {end} is given the result is a |List| where each item is
-- 		a line from the current buffer in the range {lnum} to {end},
-- 		including line {end}.
-- 		{end} is used in the same way as {lnum}.
-- 		Non-existing lines are silently omitted.
-- 		When {end} is before {lnum} an empty |List| is returned.
-- 		Example: >
-- 			:let start = line('.')
-- 			:let end = search("^$") - 1
-- 			:let lines = getline(start, end)
--
-- <		To get lines from another buffer see |getbufline()|
function vim.fn.getline(lnum, _end) end

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies.  A Tab character is counted as one
-- 		cell, alternatively use |strdisplaywidth()|.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strchars()|.
function vim.fn.strwidth(expr) end

-- includes an extra item in the list:
-- 		    [bufnum, lnum, col, off, curswant] ~
--  		The "curswant" number is the preferred column when moving the
-- 		cursor vertically.  Also see |getpos()|.
--
--  		This can be used to save and restore the cursor position: >
--  			let save_cursor = getcurpos()
--  			MoveTheCursorAround
--  			call setpos('.', save_cursor)
-- <		Note that this only works within the window.  See
-- 		|winrestview()| for restoring more state.
function vim.fn.getcurpos() end

-- Return the absolute value of {expr}.  When {expr} evaluates to
-- 		a |Float| abs() returns a |Float|.  When {expr} can be
-- 		converted to a |Number| abs() returns a |Number|.  Otherwise
-- 		abs() gives an error message and returns -1.
-- 		Examples: >
-- 			echo abs(1.456)
-- <			1.456  >
-- 			echo abs(-5.456)
-- <			5.456  >
-- 			echo abs(-4)
-- <			4
function vim.fn.abs(expr) end

-- Get information about buffers as a List of Dictionaries.
--
-- 		Without an argument information about all the buffers is
-- 		returned.
--
-- 		When the argument is a Dictionary only the buffers matching
-- 		the specified criteria are returned.  The following keys can
-- 		be specified in {dict}:
-- 			buflisted	include only listed buffers.
-- 			bufloaded	include only loaded buffers.
-- 			bufmodified	include only modified buffers.
--
-- 		Otherwise, {expr} specifies a particular buffer to return
-- 		information for.  For the use of {expr}, see |bufname()|
-- 		above.  If the buffer is found the returned List has one item.
-- 		Otherwise the result is an empty list.
--
-- 		Each returned List item is a dictionary with the following
-- 		entries:
-- 			bufnr		buffer number.
-- 			changed		TRUE if the buffer is modified.
-- 			changedtick	number of changes made to the buffer.
-- 			hidden		TRUE if the buffer is hidden.
-- 			listed		TRUE if the buffer is listed.
-- 			lnum		current line number in buffer.
-- 			linecount	number of lines in the buffer (only
-- 					valid when loaded)
-- 			loaded		TRUE if the buffer is loaded.
-- 			name		full path to the file in the buffer.
-- 			signs		list of signs placed in the buffer.
-- 					Each list item is a dictionary with
-- 					the following fields:
-- 					    id	  sign identifier
-- 					    lnum  line number
-- 					    name  sign name
-- 			variables	a reference to the dictionary with
-- 					buffer-local variables.
-- 			windows		list of |window-ID|s that display this
-- 					buffer
--
-- 		Examples: >
-- 			for buf in getbufinfo()
-- 			    echo buf.name
-- 			endfor
-- 			for buf in getbufinfo({'buflisted':1})
-- 			    if buf.changed
-- 				....
-- 			    endif
-- 			endfor
-- <
-- 		To get buffer-local options use: >
-- 			getbufvar({bufnr}, '&option_name')
--
-- <
function vim.fn.getbufinfo(expr) end

-- The result is a Number, which is |TRUE| when {expr} is the
-- 		name of a locked variable.
-- 		{expr} must be the name of a variable, |List| item or
-- 		|Dictionary| entry, not the variable itself!  Example: >
-- 			:let alist = [0, ['a', 'b'], 2, 3]
-- 			:lockvar 1 alist
-- 			:echo islocked('alist')		" 1
-- 			:echo islocked('alist[1]')	" 0
--
-- <		When {expr} is a variable that does not exist you get an error
-- 		message.  Use |exists()| to check for existence.
function vim.fn.islocked(expr) end

-- Deactivates buffer-update events on the channel.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--
--                 Return: ~
--                     False if detach failed (because the buffer isn't loaded);
--                     otherwise True.
--
--                 See also: ~
--                     |nvim_buf_attach()|
--                     |api-lua-detach| for detaching Lua callbacks
function vim.fn.nvim_buf_detach(buffer) end

