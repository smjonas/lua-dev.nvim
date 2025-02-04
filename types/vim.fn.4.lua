---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Set the mouse position to be used for the next mouse action.
-- 		{row} and {col} are one based.
-- 		For example: >
-- 			call test_setmouse(4, 20)
-- 			call feedkeys("\<LeftMouse>", "xt")
--- @return none
function vim.fn.test_setmouse(row, col) end

-- Same as |match()|, but return a |List|.  The first item in the
-- 		list is the matched string, same as what matchstr() would
-- 		return.  Following items are submatches, like "\1", "\2", etc.
-- 		in |:substitute|.  When an optional submatch didn't match an
-- 		empty string is used.  Example: >
-- 			echo matchlist('acd', '\(a\)\?\(b\)\?\(c\)\?\(.*\)')
-- <		Results in: ['acd', 'a', '', 'c', 'd', '', '', '', '', '']
-- 		When there is no match an empty list is returned.
--- @return list
function vim.fn.matchlist(expr, pat, start, count) end

-- Return {text} as a String where any character in {mask} is
-- 		removed from the beginning and  end of {text}.
-- 		If {mask} is not given, {mask} is all characters up to 0x20,
-- 		which includes Tab, space, NL and CR, plus the non-breaking
-- 		space character 0xa0.
-- 		This code deals with multibyte characters properly.
--
-- 		Examples: >
-- 			echo trim("   some text ")
-- <		returns "some text" >
-- 			echo trim("  \r\t\t\r RESERVE \t\n\x0B\xA0") . "_TAIL"
-- <		returns "RESERVE_TAIL" >
-- 			echo trim("rm<Xrm<>X>rrm", "rm<>")
-- <		returns "Xrm<>X" (characters in the middle are not removed)
--- @return string
function vim.fn.trim(text, mask) end

-- Return the position of the cursor in the command line as a
-- 		byte count.  The first column is 1.
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns 0 otherwise.
-- 		Also see |getcmdtype()|, |setcmdpos()| and |getcmdline()|.
--- @return number
function vim.fn.getcmdpos() end

-- If [expr] is supplied and it evaluates to a non-zero Number or
-- 		a non-empty String (|non-zero-arg|), then the full mode is
-- 		returned, otherwise only the first letter is returned.
--
-- 		   n	    Normal
-- 		   no	    Operator-pending
-- 		   nov	    Operator-pending (forced charwise |o_v|)
-- 		   noV	    Operator-pending (forced linewise |o_V|)
-- 		   noCTRL-V Operator-pending (forced blockwise |o_CTRL-V|)
-- 		   niI	    Normal using |i_CTRL-O| in |Insert-mode|
-- 		   niR	    Normal using |i_CTRL-O| in |Replace-mode|
-- 		   niV	    Normal using |i_CTRL-O| in |Virtual-Replace-mode|
-- 		   v	    Visual by character
-- 		   V	    Visual by line
-- 		   CTRL-V   Visual blockwise
-- 		   s	    Select by character
-- 		   S	    Select by line
-- 		   CTRL-S   Select blockwise
-- 		   i	    Insert
-- 		   ic	    Insert mode completion |compl-generic|
-- 		   ix	    Insert mode |i_CTRL-X| completion
-- 		   R	    Replace |R|
-- 		   Rc	    Replace mode completion |compl-generic|
-- 		   Rv	    Virtual Replace |gR|
-- 		   Rx	    Replace mode |i_CTRL-X| completion
-- 		   c	    Command-line editing
-- 		   cv	    Vim Ex mode |gQ|
-- 		   ce	    Normal Ex mode |Q|
-- 		   r	    Hit-enter prompt
-- 		   rm	    The -- more -- prompt
-- 		   r?	    |:confirm| query of some sort
-- 		   !	    Shell or external command is executing
-- 		   t	    Terminal mode: keys go to the job
-- 		This is useful in the 'statusline' option or when used
-- 		with |remote_expr()| In most other places it always returns
-- 		"c" or "n".
-- 		Note that in the future more modes and more specific modes may
-- 		be added. It's better not to compare the whole string but only
-- 		the leading character(s).
-- 		Also see |visualmode()|.
--- @return string
function vim.fn.mode(expr) end

-- Return a |Partial| that is null. Only useful for testing.
--- @return funcref
function vim.fn.test_null_partial() end

-- with name {name}.  When the highlight group doesn't exist,
-- 		zero is returned.
-- 		This can be used to retrieve information about the highlight
-- 		group.  For example, to get the background color of the
-- 		"Comment" group: >
-- 	:echo synIDattr(synIDtrans(hlID("Comment")), "bg")
--- @return number
function vim.fn.hlID(name) end

-- Return the largest integral value less than or equal to
-- 		{expr} as a |Float| (round down).
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			echo floor(1.856)
-- <			1.0  >
-- 			echo floor(-5.456)
-- <			-6.0  >
-- 			echo floor(4.0)
-- <			4.0
--- @return float
function vim.fn.floor(expr) end

-- Set prompt callback for buffer {buf} to {expr}.  When {expr}
-- 		is an empty string the callback is removed.  This has only
-- 		effect if {buf} has 'buftype' set to "prompt".
--
-- 		The callback is invoked when pressing Enter.  The current
-- 		buffer will always be the prompt buffer.  A new line for a
-- 		prompt is added before invoking the callback, thus the prompt
-- 		for which the callback was invoked will be in the last but one
-- 		line.
-- 		If the callback wants to add text to the buffer, it must
-- 		insert it above the last line, since that is where the current
-- 		prompt is.  This can also be done asynchronously.
-- 		The callback is invoked with one argument, which is the text
-- 		that was entered at the prompt.  This can be an empty string
-- 		if the user only typed Enter.
-- 		Example: >
-- 		   call prompt_setcallback(bufnr(''), function('s:TextEntered'))
-- 		   func s:TextEntered(text)
-- 		     if a:text == 'exit' || a:text == 'quit'
-- 		       stopinsert
-- 		       close
-- 		     else
-- 		       call append(line('$') - 1, 'Entered: "' . a:text . '"')
-- 		       " Reset 'modified' to allow the buffer to be closed.
-- 		       set nomodified
-- 		     endif
-- 		   endfunc
--- @return none
function vim.fn.prompt_setcallback(buf, expr) end

-- Like |gettabwinvar()| for the current tabpage.
-- 		Examples: >
-- 			:let list_is_on = getwinvar(2, '&list')
-- 			:echo "myvar = " . getwinvar(1, 'myvar')
function vim.fn.getwinvar(nr, varname, def) end

-- Deletes a match with ID {id} previously defined by |matchadd()|
-- 		or one of the |:match| commands.  Returns 0 if successful,
-- 		otherwise -1.  See example for |matchadd()|.  All matches can
-- 		be deleted in one operation by |clearmatches()|.
--- @return number
function vim.fn.matchdelete(id) end

-- Set the text of the buffer in popup win {id}. {text} is the
-- 		same as supplied to |popup_create()|, except that a buffer
-- 		number is not allowed.
-- 		Does not change the window size or position, other than caused
-- 		by the different text.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_settext('hello')
--- @return none
function vim.fn.popup_settext(id, text) end

-- Return the position and size of popup {id}.  Returns a Dict
-- 		with these entries:
-- 		    col		screen column of the popup, one-based
-- 		    line	screen line of the popup, one-based
-- 		    width	width of the whole popup in screen cells
-- 		    height	height of the whole popup in screen cells
-- 		    core_col	screen column of the text box
-- 		    core_line	screen line of the text box
-- 		    core_width	width of the text box in screen cells
-- 		    core_height	height of the text box in screen cells
-- 		    firstline	line of the buffer at top (1 unless scrolled)
-- 				(not the value of the "firstline" property)
-- 		    lastline	line of the buffer at the bottom (updated when
-- 				the popup is redrawn)
-- 		    scrollbar	non-zero if a scrollbar is displayed
-- 		    visible	one if the popup is displayed, zero if hidden
-- 		Note that these are the actual screen positions.  They differ
-- 		from the values in `popup_getoptions()` for the sizing and
-- 		positioning mechanism applied.
--
-- 		The "core_" values exclude the padding and border.
--
-- 		If popup window {id} is not found an empty Dict is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_getpos()
--- @return dict
function vim.fn.popup_getpos(id) end

-- Selects the {nr} match item, as set with a |:match|,
-- 		|:2match| or |:3match| command.
-- 		Return a |List| with two elements:
-- 			The name of the highlight group used
-- 			The pattern used.
-- 		When {nr} is not 1, 2 or 3 returns an empty |List|.
-- 		When there is no match item set returns ['', ''].
-- 		This is useful to save and restore a |:match|.
-- 		Highlighting matches using the |:match| commands are limited
-- 		to three matches. |matchadd()| does not have this limitation.
--- @return list
function vim.fn.matcharg(nr) end

-- Return the tangent of {expr}, measured in radians, as a |Float|
-- 		in the range [-inf, inf].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo tan(10)
-- <			0.648361 >
-- 			:echo tan(-4.01)
-- <			-1.181502
--- @return float
function vim.fn.tan(expr) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

-- Set the register {regname} to {value}.
-- 		{value} may be any value returned by |getreg()|, including
-- 		a |List|.
-- 		If {options} contains "a" or {regname} is upper case,
-- 		then the value is appended.
-- 		{options} can also contain a register type specification:
-- 		    "c" or "v"	      |charwise| mode
-- 		    "l" or "V"	      |linewise| mode
-- 		    "b" or "<CTRL-V>" |blockwise-visual| mode
-- 		If a number immediately follows "b" or "<CTRL-V>" then this is
-- 		used as the width of the selection - if it is not specified
-- 		then the width of the block is set to the number of characters
-- 		in the longest line (counting a <Tab> as 1 character).
-- 		If {options} contains "u" or '"', then the unnamed register is
-- 		set to point to register {regname}.
--
-- 		If {options} contains no register settings, then the default
-- 		is to use character mode unless {value} ends in a <NL> for
-- 		string {value} and linewise mode for list {value}. Blockwise
-- 		mode is never selected automatically.
-- 		Returns zero for success, non-zero for failure.
--
-- 							*E883*
-- 		Note: you may not use |List| containing more than one item to
-- 		      set search and expression registers. Lists containing no
-- 		      items act like empty strings.
--
-- 		Examples: >
-- 			:call setreg(v:register, @*)
-- 			:call setreg('*', @%, 'ac')
-- 			:call setreg('a', "1\n2\n3", 'b5')
--
-- <		This example shows using the functions to save and restore a
-- 		register: >
-- 			:let var_a = getreg('a', 1, 1)
-- 			:let var_amode = getregtype('a')
-- 			    ....
-- 			:call setreg('a', var_a, var_amode)
-- <		Note: you may not reliably restore register value
-- 		without using the third argument to |getreg()| as without it
-- 		newlines are represented as newlines AND Nul bytes are
-- 		represented as newlines as well, see |NL-used-for-Nul|.
--
-- 		You can also change the type of a register by appending
-- 		nothing: >
-- 			:call setreg('a', '', 'al')
--- @return number
function vim.fn.setreg(n, v, opt) end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers and strings are returned as they are (strings are
-- 		copied though, Unicode strings are additionally converted to
-- 		UTF-8).
-- 		Lists are represented as Vim |List| type.
-- 		Dictionaries are represented as Vim |Dictionary| type with
-- 		keys converted to strings.
function vim.fn.py3eval(expr) end

-- Show the {what} for 3 seconds at the top of the Vim window.
-- 		This works like: >
-- 			call popup_create({what}, #{
-- 				\ line: 1,
-- 				\ col: 10,
-- 				\ minwidth: 20,
-- 				\ time: 3000,
-- 				\ tabpage: -1,
-- 				\ zindex: 300,
-- 				\ drag: 1,
-- 				\ highlight: 'WarningMsg',
-- 				\ border: [],
-- 				\ close: 'click',
-- 				\ padding: [0,1,0,1],
-- 				\ })
-- <		The PopupNotification highlight group is used instead of
-- 		WarningMsg if it is defined.
--
-- 		Without the |+timers| feature the popup will not disappear
-- 		automatically, the user has to click in it.
--
-- 		The position will be adjusted to avoid overlap with other
-- 		notifications.
-- 		Use {options} to change the properties.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_notification({})
--- @return number
function vim.fn.popup_notification(what, options) end

-- When {expected} and {actual} are not equal an error message is
-- 		added to |v:errors| and 1 is returned.  Otherwise zero is
-- 		returned |assert-return|.
-- 		There is no automatic conversion, the String "4" is different
-- 		from the Number 4.  And the number 4 is different from the
-- 		Float 4.0.  The value of 'ignorecase' is not used here, case
-- 		always matters.
-- 		When {msg} is omitted an error in the form "Expected
-- 		{expected} but got {actual}" is produced.
-- 		Example: >
-- 	assert_equal('foo', 'bar')
-- <		Will result in a string to be added to |v:errors|:
-- 	test.vim line 12: Expected 'foo' but got 'bar' ~
--- @return number
function vim.fn.assert_equal(exp, act, msg) end

-- When {expr} is a |List| then this returns the index of the
-- 		first item where {pat} matches.  Each item is used as a
-- 		String, |Lists| and |Dictionaries| are used as echoed.
--
-- 		Otherwise, {expr} is used as a String.  The result is a
-- 		Number, which gives the index (byte offset) in {expr} where
-- 		{pat} matches.
--
-- 		A match at the first character or |List| item returns zero.
-- 		If there is no match -1 is returned.
--
-- 		For getting submatches see |matchlist()|.
-- 		Example: >
-- 			:echo match("testing", "ing")	" results in 4
-- 			:echo match([1, 'x'], '\a')	" results in 1
-- <		See |string-match| for how {pat} is used.
-- 								*strpbrk()*
-- 		Vim doesn't have a strpbrk() function.  But you can do: >
-- 			:let sepidx = match(line, '[.,;: \t]')
-- <								*strcasestr()*
-- 		Vim doesn't have a strcasestr() function.  But you can add
-- 		"\c" to the pattern to ignore case: >
-- 			:let idx = match(haystack, '\cneedle')
-- <
-- 		If {start} is given, the search starts from byte index
-- 		{start} in a String or item {start} in a |List|.
-- 		The result, however, is still the index counted from the
-- 		first character/item.  Example: >
-- 			:echo match("testing", "ing", 2)
-- <		result is again "4". >
-- 			:echo match("testing", "ing", 4)
-- <		result is again "4". >
-- 			:echo match("testing", "t", 2)
-- <		result is "3".
-- 		For a String, if {start} > 0 then it is like the string starts
-- 		{start} bytes later, thus "^" will match at {start}.  Except
-- 		when {count} is given, then it's like matches before the
-- 		{start} byte are ignored (this is a bit complicated to keep it
-- 		backwards compatible).
-- 		For a String, if {start} < 0, it will be set to 0.  For a list
-- 		the index is counted from the end.
-- 		If {start} is out of range ({start} > strlen({expr}) for a
-- 		String or {start} > len({expr}) for a |List|) -1 is returned.
--
-- 		When {count} is given use the {count}'th match.  When a match
-- 		is found in a String the search for the next one starts one
-- 		character further.  Thus this example results in 1: >
-- 			echo match("testing", "..", 0, 2)
-- <		In a |List| the search continues in the next item.
-- 		Note that when {count} is added the way {start} works changes,
-- 		see above.
--
-- 		See |pattern| for the patterns that are accepted.
-- 		The 'ignorecase' option is used to set the ignore-caseness of
-- 		the pattern.  'smartcase' is NOT used.  The matching is always
-- 		done like 'magic' is set and 'cpoptions' is empty.
--- @return number
function vim.fn.match(expr, pat, start, count) end

-- The result is a String, which is a copy of {expr}, in which
-- 		the first match of {pat} is replaced with {sub}.
-- 		When {flags} is "g", all matches of {pat} in {expr} are
-- 		replaced.  Otherwise {flags} should be "".
--
-- 		This works like the ":substitute" command (without any flags).
-- 		But the matching with {pat} is always done like the 'magic'
-- 		option is set and 'cpoptions' is empty (to make scripts
-- 		portable).  'ignorecase' is still relevant, use |/\c| or |/\C|
-- 		if you want to ignore or match case and ignore 'ignorecase'.
-- 		'smartcase' is not used.  See |string-match| for how {pat} is
-- 		used.
--
-- 		A "~" in {sub} is not replaced with the previous {sub}.
-- 		Note that some codes in {sub} have a special meaning
-- 		|sub-replace-special|.  For example, to replace something with
-- 		"\n" (two characters), use "\\\\n" or '\\n'.
--
-- 		When {pat} does not match in {expr}, {expr} is returned
-- 		unmodified.
--
-- 		Example: >
-- 			:let &path = substitute(&path, ",\\=[^,]*$", "", "")
-- <		This removes the last component of the 'path' option. >
-- 			:echo substitute("testing", ".*", "\\U\\0", "")
-- <		results in "TESTING".
--
-- 		When {sub} starts with "\=", the remainder is interpreted as
-- 		an expression. See |sub-replace-expression|.  Example: >
-- 			:echo substitute(s, '%\(\x\x\)',
-- 			   \ '\=nr2char("0x" . submatch(1))', 'g')
--
-- <		When {sub} is a Funcref that function is called, with one
-- 		optional argument.  Example: >
-- 		   :echo substitute(s, '%\(\x\x\)', SubNr, 'g')
-- <		The optional argument is a list which contains the whole
-- 		matched string and up to nine submatches, like what
-- 		|submatch()| returns.  Example: >
-- 		   :echo substitute(s, '%\(\x\x\)', {m -> '0x' . m[1]}, 'g')
--- @return string
function vim.fn.substitute(expr, pat, sub, flags) end

-- The result is the {nr}th file in the argument list.  See
-- 		|arglist|.  "argv(0)" is the first one.  Example: >
-- 	:let i = 0
-- 	:while i < argc()
-- 	:  let f = escape(fnameescape(argv(i)), '.')
-- 	:  exe 'amenu Arg.' . f . ' :e ' . f . '<CR>'
-- 	:  let i = i + 1
-- 	:endwhile
-- <		Without the {nr} argument, or when {nr} is -1, a |List| with
-- 		the whole |arglist| is returned.
--
-- 		The {winid} argument specifies the window ID, see |argc()|.
--- @return list
function vim.fn.argv(_1, winid) end

-- Return a string which contains characters indicating the
-- 		current state.  Mostly useful in callbacks that want to do
-- 		work that may not always be safe.  Roughly this works like:
-- 		- callback uses state() to check if work is safe to do.
-- 		  Yes: then do it right away.
-- 		  No:  add to work queue and add a |SafeState| and/or
-- 		       |SafeStateAgain| autocommand (|SafeState| triggers at
-- 		       toplevel, |SafeStateAgain| triggers after handling
-- 		       messages and callbacks).
-- 		- When SafeState or SafeStateAgain is triggered and executes
-- 		  your autocommand, check with `state()` if the work can be
-- 		  done now, and if yes remove it from the queue and execute.
-- 		  Remove the autocommand if the queue is now empty.
-- 		Also see |mode()|.
--
-- 		When {what} is given only characters in this string will be
-- 		added.  E.g, this checks if the screen has scrolled: >
-- 			if state('s') == ''
-- 			   " screen has not scrolled
-- <
-- 		These characters indicate the state, generally indicating that
-- 		something is busy:
-- 		    m	halfway a mapping, :normal command, feedkeys() or
-- 			stuffed command
-- 		    o	operator pending or waiting for a command argument,
-- 		        e.g. after |f|
-- 		    a	Insert mode autocomplete active
-- 		    x	executing an autocommand
-- 		    w	blocked on waiting, e.g. ch_evalexpr(), ch_read() and
-- 			ch_readraw() when reading json.
-- 		    S	not triggering SafeState or SafeStateAgain
-- 		    c	callback invoked, including timer (repeats for
-- 			recursiveness up to "ccc")
-- 		    s	screen has scrolled for messages
--- @return string
function vim.fn.state(what) end

-- {not implemented yet}
-- 		Search for a text property as specified with {props}:
-- 		   id		property with this ID
-- 		   type		property with this type name
-- 		   bufnr	buffer to search in; when present a
-- 				start position with "lnum" and "col"
-- 				must be given; when omitted the
-- 				current buffer is used
-- 		   lnum		start in this line (when omitted start
-- 				at the cursor)
-- 		   col		start at this column (when omitted
-- 				and "lnum" is given: use column 1,
-- 				otherwise start at the cursor)
-- 		   skipstart	do not look for a match at the start
-- 				position
--
-- 		{direction} can be "f" for forward and "b" for backward.  When
-- 		omitted forward search is performed.
--
-- 		If a match is found then a Dict is returned with the entries
-- 		as with prop_list(), and additionally an "lnum" entry.
-- 		If no match is found then an empty Dict is returned.
--
-- 		See |text-properties| for information about text properties.
--- @return dict
function vim.fn.prop_find(props, direction) end

-- Set the current character search information to {dict},
-- 		which contains one or more of the following entries:
--
-- 		    char	character which will be used for a subsequent
-- 				|,| or |;| command; an empty string clears the
-- 				character search
-- 		    forward	direction of character search; 1 for forward,
-- 				0 for backward
-- 		    until	type of character search; 1 for a |t| or |T|
-- 				character search, 0 for an |f| or |F|
-- 				character search
--
-- 		This can be useful to save/restore a user's character search
-- 		from a script: >
-- 			:let prevsearch = getcharsearch()
-- 			:" Perform a command which clobbers user's search
-- 			:call setcharsearch(prevsearch)
-- <		Also see |getcharsearch()|.
--- @param dict dictionary
--- @return dict
function vim.fn.setcharsearch(dict) end

-- different from using {expr} directly.
-- 		When {expr} is a |List| a shallow copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  But the items are identical, thus
-- 		changing an item changes the contents of both |Lists|.
-- 		A |Dictionary| is copied in a similar way as a |List|.
-- 		Also see |deepcopy()|.
function vim.fn.copy(expr) end

-- The result is a Number, which is the number of characters
-- 		in String {expr}.
-- 		When {skipcc} is omitted or zero, composing characters are
-- 		counted separately.
-- 		When {skipcc} set to 1, Composing characters are ignored.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strwidth()|.
--
-- 		{skipcc} is only available after 7.4.755.  For backward
-- 		compatibility, you can define a wrapper function: >
-- 		    if has("patch-7.4.755")
-- 		      function s:strchars(str, skipcc)
-- 			return strchars(a:str, a:skipcc)
-- 		      endfunction
-- 		    else
-- 		      function s:strchars(str, skipcc)
-- 			if a:skipcc
-- 			  return strlen(substitute(a:str, ".", "x", "g"))
-- 			else
-- 			  return strchars(a:str)
-- 			endif
-- 		      endfunction
-- 		    endif
--- @return number
function vim.fn.strchars(expr, skipcc) end

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
--- @return string
function vim.fn.nr2char(expr, utf8) end

-- window.  The top window has number 1.
--
-- 		The optional argument {arg} supports the following values:
-- 			$	the number of the last window (the window
-- 				count).
-- 			#	the number of the last accessed window (where
-- 				|CTRL-W_p| goes to).  If there is no previous
-- 				window or it is in another tab page 0 is
-- 				returned.
-- 			{N}j	the number of the Nth window below the
-- 				current window (where |CTRL-W_j| goes to).
-- 			{N}k	the number of the Nth window above the current
-- 				window (where |CTRL-W_k| goes to).
-- 			{N}h	the number of the Nth window left of the
-- 				current window (where |CTRL-W_h| goes to).
-- 			{N}l	the number of the Nth window right of the
-- 				current window (where |CTRL-W_l| goes to).
-- 		The number can be used with |CTRL-W_w| and ":wincmd w"
-- 		|:wincmd|.
-- 		Also see |tabpagewinnr()| and |win_getid()|.
-- 		Examples: >
-- 			let window_count = winnr('$')
-- 			let prev_window = winnr('#')
-- 			let wnum = winnr('3k')
-- <
--- @return number
function vim.fn.winnr(expr) end

-- Get the amount of indent for line {lnum} according the lisp
-- 		indenting rules, as with 'lisp'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid or Vim was not compiled the
-- 		|+lispindent| feature, -1 is returned.
--- @return number
function vim.fn.lispindent(lnum) end

-- The result is a Number, which is a unix timestamp representing
-- 		the date and time in {timestring}, which is expected to match
-- 		the format specified in {format}.
--
-- 		The accepted {format} depends on your system, thus this is not
-- 		portable!  See the manual page of the C function strptime()
-- 		for the format.  Especially avoid "%c".  The value of $TZ also
-- 		matters.
--
-- 		If the {timestring} cannot be parsed with {format} zero is
-- 		returned.  If you do not know the format of {timestring} you
-- 		can try different {format} values until you get a non-zero
-- 		result.
--
-- 		See also |strftime()|.
-- 		Examples: >
-- 		  :echo strptime("%Y %b %d %X", "1997 Apr 27 11:49:23")
-- <		  862156163 >
-- 		  :echo strftime("%c", strptime("%y%m%d %T", "970427 11:53:55"))
-- <		  Sun Apr 27 11:53:55 1997 >
-- 		  :echo strftime("%c", strptime("%Y%m%d%H%M%S", "19970427115355") + 3600)
-- <		  Sun Apr 27 12:53:55 1997
--
-- 		Not available on all systems.  To check use: >
-- 			:if exists("*strptime")
--- @return number
function vim.fn.strptime(format, timestring) end

-- the top of the GUI Vim window.  The result will be -1 if the
-- 		information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposy() end

-- The result is a String, which is part of {src}, starting from
-- 		byte {start}, with the byte length {len}.
-- 		To count characters instead of bytes use |strcharpart()|.
--
-- 		When bytes are selected which do not exist, this doesn't
-- 		result in an error, the bytes are simply omitted.
-- 		If {len} is missing, the copy continues from {start} till the
-- 		end of the {src}. >
-- 			strpart("abcdefg", 3, 2)    == "de"
-- 			strpart("abcdefg", -2, 4)   == "ab"
-- 			strpart("abcdefg", 5, 4)    == "fg"
-- 			strpart("abcdefg", 3)	    == "defg"
--
-- <		Note: To get the first character, {start} must be 0.  For
-- 		example, to get three bytes under and after the cursor: >
-- 			strpart(getline("."), col(".") - 1, 3)
--- @return string
function vim.fn.strpart(str, start, len) end

-- Make a copy of {expr}.  For Numbers and Strings this isn't
-- 		different from using {expr} directly.
-- 		When {expr} is a |List| a full copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  When an item is a |List|, a copy for it
-- 		is made, recursively.  Thus changing an item in the copy does
-- 		not change the contents of the original |List|.
-- 		When {noref} is omitted or zero a contained |List| or
-- 		|Dictionary| is only copied once.  All references point to
-- 		this single copy.  With {noref} set to 1 every occurrence of a
-- 		|List| or |Dictionary| results in a new copy.  This also means
-- 		that a cyclic reference causes deepcopy() to fail.
-- 								*E724*
-- 		Nesting is possible up to 100 levels.  When there is an item
-- 		that refers back to a higher level making a deep copy with
-- 		{noref} set to 1 will fail.
-- 		Also see |copy()|.
function vim.fn.deepcopy(expr, noref) end

-- If {id} is a hidden popup, show it now.
-- 		For {id} see `popup_hide()`.
-- 		If {id} is the info popup it will be positioned next to the
-- 		current popup menu item.
--- @return none
function vim.fn.popup_show(id) end

-- Invoke listener callbacks for buffer {buf}.  If there are no
-- 		pending changes then no callbacks are invoked.
--
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
--
-- 		Can also be used as a |method|: >
-- 			GetBuffer()->listener_flush()
--- @return none
function vim.fn.listener_flush(buf) end

-- Returns the |changelist| for the buffer {expr}. For the use
-- 		of {expr}, see |bufname()| above. If buffer {expr} doesn't
-- 		exist, an empty list is returned.
--
-- 		The returned list contains two entries: a list with the change
-- 		locations and the current position in the list.  Each
-- 		entry in the change list is a dictionary with the following
-- 		entries:
-- 			col		column number
-- 			coladd		column offset for 'virtualedit'
-- 			lnum		line number
-- 		If buffer {expr} is the current buffer, then the current
-- 		position refers to the position in the list. For other
-- 		buffers, it is set to the length of the list.
--- @return list
function vim.fn.getchangelist(expr) end

-- Set the cursor position in the command line to byte position
-- 		{pos}.  The first position is 1.
-- 		Use |getcmdpos()| to obtain the current position.
-- 		Only works while editing the command line, thus you must use
-- 		|c_CTRL-\_e|, |c_CTRL-R_=| or |c_CTRL-R_CTRL-R| with '='.  For
-- 		|c_CTRL-\_e| and |c_CTRL-R_CTRL-R| with '=' the position is
-- 		set after the command line is set to the expression.  For
-- 		|c_CTRL-R_=| it is set after evaluating the expression but
-- 		before inserting the resulting text.
-- 		When the number is too big the cursor is put at the end of the
-- 		line.  A number smaller than one has undefined results.
-- 		Returns 0 when successful, 1 when not editing the command
-- 		line.
--- @return number
function vim.fn.setcmdpos(pos) end

-- Return a |Blob| that is null. Only useful for testing.
--- @return blob
function vim.fn.test_null_blob() end

-- The result is the number of a buffer, as it is displayed by
-- 		the ":ls" command.  For the use of {expr}, see |bufname()|
-- 		above.
-- 		If the buffer doesn't exist, -1 is returned.  Or, if the
-- 		{create} argument is present and not zero, a new, unlisted,
-- 		buffer is created and its number is returned.
-- 		bufnr("$") is the last buffer: >
-- 			:let last_buffer = bufnr("$")
-- <		The result is a Number, which is the highest buffer number
-- 		of existing buffers.  Note that not all buffers with a smaller
-- 		number necessarily exist, because ":bwipeout" may have removed
-- 		them.  Use bufexists() to test for the existence of a buffer.
--- @return number
function vim.fn.bufnr(expr, create) end

-- Get the |window-ID| for the specified window.
-- 		When {win} is missing use the current window.
-- 		With {win} this is the window number.  The top window has
-- 		number 1.
-- 		Without {tab} use the current tab, otherwise the tab with
-- 		number {tab}.  The first tab has number one.
-- 		Return zero if the window cannot be found.
--- @return number
function vim.fn.win_getid(win, tab) end

-- Characters in {string} are queued for processing as if they
-- 		come from a mapping or were typed by the user.
--
-- 		By default the string is added to the end of the typeahead
-- 		buffer, thus if a mapping is still being executed the
-- 		characters come after them.  Use the 'i' flag to insert before
-- 		other characters, they will be executed next, before any
-- 		characters from a mapping.
--
-- 		The function does not wait for processing of keys contained in
-- 		{string}.
--
-- 		To include special keys into {string}, use double-quotes
-- 		and "\..." notation |expr-quote|. For example,
-- 		feedkeys("\<CR>") simulates pressing of the <Enter> key. But
-- 		feedkeys('\<CR>') pushes 5 characters.
-- 		The |<Ignore>| keycode may be used to exit the
-- 		wait-for-character without doing anything.
--
-- 		{mode} is a String, which can contain these character flags:
-- 		'm'	Remap keys. This is default.  If {mode} is absent,
-- 			keys are remapped.
-- 		'n'	Do not remap keys.
-- 		't'	Handle keys as if typed; otherwise they are handled as
-- 			if coming from a mapping.  This matters for undo,
-- 			opening folds, etc.
-- 		'i'	Insert the string instead of appending (see above).
-- 		'x'	Execute commands until typeahead is empty.  This is
-- 			similar to using ":normal!".  You can call feedkeys()
-- 			several times without 'x' and then one time with 'x'
-- 			(possibly with an empty {string}) to execute all the
-- 			typeahead.  Note that when Vim ends in Insert mode it
-- 			will behave as if <Esc> is typed, to avoid getting
-- 			stuck, waiting for a character to be typed before the
-- 			script continues.
-- 			Note that if you manage to call feedkeys() while
-- 			executing commands, thus calling it recursively, the
-- 			all typehead will be consumed by the last call.
-- 		'!'	When used with 'x' will not end Insert mode. Can be
-- 			used in a test when a timer is set to exit Insert mode
-- 			a little later.  Useful for testing CursorHoldI.
--
-- 		Return value is always 0.
--- @return number
function vim.fn.feedkeys(string, mode) end

-- Return the screen position of window {nr} as a list with two
-- 		numbers: [row, col].  The first window always has position
-- 		[1, 1], unless there is a tabline, then it is [2, 1].
-- 		{nr} can be the window number or the |window-ID|.
-- 		Return [0, 0] if the window cannot be found in the current
-- 		tabpage.
--- @return list
function vim.fn.win_screenpos(nr) end

-- The opposite of `assert_match()`: add an error message to
-- 		|v:errors| when {pattern} matches {actual}.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notmatch(pat, text, msg) end

-- Find directory {name} in {path}.  Supports both downwards and
-- 		upwards recursive directory searches.  See |file-searching|
-- 		for the syntax of {path}.
-- 		Returns the path of the first found match.  When the found
-- 		directory is below the current directory a relative path is
-- 		returned.  Otherwise a full path is returned.
-- 		If {path} is omitted or empty then 'path' is used.
-- 		If the optional {count} is given, find {count}'s occurrence of
-- 		{name} in {path} instead of the first one.
-- 		When {count} is negative return all the matches in a |List|.
-- 		This is quite similar to the ex-command |:find|.
--- @return string
function vim.fn.finddir(name, path, count) end

-- Get the value of window-local variable {varname} in window
-- 		{winnr} in tab page {tabnr}.
-- 		When {varname} is empty a dictionary with all window-local
-- 		variables is returned.
-- 		When {varname} is equal to "&" get the values of all
-- 		window-local options in a Dictionary.
-- 		Otherwise, when {varname} starts with "&" get the value of a
-- 		window-local option.
-- 		Note that {varname} must be the name without "w:".
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |getwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global option, buffer-local option and
-- 		window-local option, but it doesn't work for a global variable
-- 		or buffer-local variable.
-- 		When the tab, window or variable doesn't exist {def} or an
-- 		empty string is returned, there is no error message.
-- 		Examples: >
-- 			:let list_is_on = gettabwinvar(1, 2, '&list')
-- 			:echo "myvar = " . gettabwinvar(3, 1, 'myvar')
-- <
-- 		To obtain all window-local variables use: >
-- 			gettabwinvar({tabnr}, {winnr}, '&')
function vim.fn.gettabwinvar(tabnr, winnr, name, def) end

-- for the current buffer.  This is the 'tags' option expanded.
--- @return list
function vim.fn.tagfiles() end

-- Remove a matching text property from line {lnum}.  When
-- 		{lnum-end} is given, remove matching text properties from line
-- 		{lnum} to {lnum-end} (inclusive).
-- 		When {lnum} is omitted remove matching text properties from
-- 		all lines.
--
-- 		{props} is a dictionary with these fields:
-- 		   id		remove text properties with this ID
-- 		   type		remove text properties with this type name
-- 		   bufnr	use this buffer instead of the current one
-- 		   all		when TRUE remove all matching text properties,
-- 				not just the first one
-- 		A property matches when either "id" or "type" matches.
-- 		If buffer "bufnr" does not exist you get an error message.
-- 		If buffer "bufnr" is not loaded then nothing happens.
--
-- 		Returns the number of properties that were removed.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetProps()->prop_remove()
--- @return number
function vim.fn.prop_remove(props, lnum, lnum_end) end

-- Add a callback function that will be invoked when changes have
-- 		been made to buffer {buf}.
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
-- 		Returns a unique ID that can be passed to |listener_remove()|.
--
-- 		The {callback} is invoked with five arguments:
-- 		    a:bufnr	the buffer that was changed
-- 		    a:start	first changed line number
-- 		    a:end	first line number below the change
-- 		    a:added	number of lines added, negative if lines were
-- 				deleted
-- 		    a:changes	a List of items with details about the changes
--
-- 		Example: >
-- 	    func Listener(bufnr, start, end, added, changes)
-- 	      echo 'lines ' .. a:start .. ' until ' .. a:end .. ' changed'
-- 	    endfunc
-- 	    call listener_add('Listener', bufnr)
--
-- <		The List cannot be changed.  Each item in a:changes is a
-- 		dictionary with these entries:
-- 		    lnum	the first line number of the change
-- 		    end		the first line below the change
-- 		    added	number of lines added; negative if lines were
-- 				deleted
-- 		    col		first column in "lnum" that was affected by
-- 				the change; one if unknown or the whole line
-- 				was affected; this is a byte index, first
-- 				character has a value of one.
-- 		When lines are inserted the values are:
-- 		    lnum	line above which the new line is added
-- 		    end		equal to "lnum"
-- 		    added	number of lines inserted
-- 		    col		1
-- 		When lines are deleted the values are:
-- 		    lnum	the first deleted line
-- 		    end		the line below the first deleted line, before
-- 				the deletion was done
-- 		    added	negative, number of lines deleted
-- 		    col		1
-- 		When lines are changed:
-- 		    lnum	the first changed line
-- 		    end		the line below the last changed line
-- 		    added	0
-- 		    col		first column with a change or 1
--
-- 		The entries are in the order the changes were made, thus the
-- 		most recent change is at the end.  The line numbers are valid
-- 		when the callback is invoked, but later changes may make them
-- 		invalid, thus keeping a copy for later might not work.
--
-- 		The {callback} is invoked just before the screen is updated,
-- 		when |listener_flush()| is called or when a change is being
-- 		made that changes the line count in a way it causes a line
-- 		number in the list of changes to become invalid.
--
-- 		The {callback} is invoked with the text locked, see
-- 		|textlock|.  If you do need to make changes to the buffer, use
-- 		a timer to do this later |timer_start()|.
--
-- 		The {callback} is not invoked when the buffer is first loaded.
-- 		Use the |BufReadPost| autocmd event to handle the initial text
-- 		of a buffer.
-- 		The {callback} is also not invoked when the buffer is
-- 		unloaded, use the |BufUnload| autocmd event for that.
--
-- 		Can also be used as a |method|, the base is passed as the
-- 		second argument: >
-- 			GetBuffer()->listener_add(callback)
--- @return number
function vim.fn.listener_add(callback, buf) end

-- Return a Float that represents the time value of {time}.
-- 		Unit of time is seconds.
-- 		Example:
-- 			let start = reltime()
-- 			call MyFunction()
-- 			let seconds = reltimefloat(reltime(start))
-- 		See the note of reltimestr() about overhead.
--  		Also see |profiling|.
--- @return float
function vim.fn.reltimefloat(time) end

-- Execute {command} and capture its output.
-- 		If {command} is a |String|, returns {command} output.
-- 		If {command} is a |List|, returns concatenated outputs.
-- 		Examples: >
-- 			echo execute('echon "foo"')
-- <			foo >
-- 			echo execute(['echon "foo"', 'echon "bar"'])
-- <			foobar
--
-- 		The optional {silent} argument can have these values:
-- 			""		no `:silent` used
-- 			"silent"	`:silent` used
-- 			"silent!"	`:silent!` used
-- 		The default is "silent".  Note that with "silent!", unlike
-- 		`:redir`, error messages are dropped.
--
-- 		To get a list of lines use |split()| on the result: >
-- 			split(execute('args'), "\n")
--
-- <		This function is not available in the |sandbox|.
-- 		Note: If nested, an outer execute() will not observe output of
-- 		the inner calls.
-- 		Note: Text attributes (highlights) are not captured.
--- @return string
function vim.fn.execute(command) end

-- The result is a Number, which is |TRUE| when the IME status is
-- 		active.
-- 		See 'imstatusfunc'.
--- @return number
function vim.fn.getimstatus() end

-- Set a callback for buffer {buf} to {expr}.  When {expr} is an
-- 		empty string the callback is removed.  This has only effect if
-- 		{buf} has 'buftype' set to "prompt".
--
-- 		This callback will be invoked when pressing CTRL-C in Insert
-- 		mode.  Without setting a callback Vim will exit Insert mode,
-- 		as in any buffer.
--- @return none
function vim.fn.prompt_setinterrupt(buf, text) end

-- Get the value of a tab-local variable {varname} in tab page
-- 		{tabnr}. |t:var|
-- 		Tabs are numbered starting with one.
-- 		When {varname} is empty a dictionary with all tab-local
-- 		variables is returned.
-- 		Note that the name without "t:" must be used.
-- 		When the tab or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
function vim.fn.gettabvar(nr, varname, def) end

-- Return a |Job| that is null. Only useful for testing.
-- 		{only available when compiled with the +job feature}
--- @return job
function vim.fn.test_null_job() end

-- Set the flag to call the garbagecollector as if in the main
-- 		loop.  Only to be used in tests.
--- @return none
function vim.fn.test_garbagecollect_soon() end

-- Return the name of the undo file that would be used for a file
-- 		with name {name} when writing.  This uses the 'undodir'
-- 		option, finding directories that exist.  It does not check if
-- 		the undo file exists.
-- 		{name} is always expanded to the full path, since that is what
-- 		is used internally.
-- 		If {name} is empty undofile() returns an empty string, since a
-- 		buffer without a file name will not write an undo file.
-- 		Useful in combination with |:wundo| and |:rundo|.
-- 		When compiled without the |+persistent_undo| option this always
-- 		returns an empty string.
--- @return string
function vim.fn.undofile(name) end

-- The result is a String, which is the {what} attribute of
-- 		syntax ID {synID}.  This can be used to obtain information
-- 		about a syntax item.
-- 		{mode} can be "gui", "cterm" or "term", to get the attributes
-- 		for that mode.  When {mode} is omitted, or an invalid value is
-- 		used, the attributes for the currently active highlighting are
-- 		used (GUI, cterm or term).
-- 		Use synIDtrans() to follow linked highlight groups.
-- 		{what}		result
-- 		"name"		the name of the syntax item
-- 		"fg"		foreground color (GUI: color name used to set
-- 				the color, cterm: color number as a string,
-- 				term: empty string)
-- 		"bg"		background color (as with "fg")
-- 		"font"		font name (only available in the GUI)
-- 				|highlight-font|
-- 		"sp"		special color (as with "fg") |highlight-guisp|
-- 		"fg#"		like "fg", but for the GUI and the GUI is
-- 				running the name in "#RRGGBB" form
-- 		"bg#"		like "fg#" for "bg"
-- 		"sp#"		like "fg#" for "sp"
-- 		"bold"		"1" if bold
-- 		"italic"	"1" if italic
-- 		"reverse"	"1" if reverse
-- 		"inverse"	"1" if inverse (= reverse)
-- 		"standout"	"1" if standout
-- 		"underline"	"1" if underlined
-- 		"undercurl"	"1" if undercurled
-- 		"strikethrough"	"1" if struckthrough
--
-- 		Example (echoes the color of the syntax item under the
-- 		cursor): >
-- 	:echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
--- @return string
function vim.fn.synIDattr(synID, what, mode) end

-- Show {expr} inside the balloon.  For the GUI {expr} is used as
-- 		a string.  For a terminal {expr} can be a list, which contains
-- 		the lines of the balloon.  If {expr} is not a list it will be
-- 		split with |balloon_split()|.
-- 		If {expr} is an empty string any existing balloon is removed.
--
-- 		Example: >
-- 			func GetBalloonContent()
-- 			   " ... initiate getting the content
-- 			   return ''
-- 			endfunc
-- 			set balloonexpr=GetBalloonContent()
--
-- 			func BalloonCallback(result)
-- 			  call balloon_show(a:result)
-- 			endfunc
-- <		Can also be used as a |method|: >
-- 			GetText()->balloon_show()
-- <
-- 		The intended use is that fetching the content of the balloon
-- 		is initiated from 'balloonexpr'.  It will invoke an
-- 		asynchronous method, in which a callback invokes
-- 		balloon_show().  The 'balloonexpr' itself can return an
-- 		empty string or a placeholder.
--
-- 		When showing a balloon is not possible nothing happens, no
-- 		error message.
-- 		{only available when compiled with the |+balloon_eval| or
-- 		|+balloon_eval_term| feature}
--- @return none
function vim.fn.balloon_show(expr) end

-- Return a String that represents the time value of {time}.
-- 		This is the number of seconds, a dot and the number of
-- 		microseconds.  Example: >
-- 			let start = reltime()
-- 			call MyFunction()
-- 			echo reltimestr(reltime(start))
-- <		Note that overhead for the commands will be added to the time.
-- 		Leading spaces are used to make the string align nicely.  You
-- 		can use split() to remove it. >
-- 			echo split(reltimestr(reltime(start)))[0]
-- <		Also see |profiling|.
--- @return string
function vim.fn.reltimestr(time) end

-- Filter that can be used for a popup. It handles only the keys
-- 		'y', 'Y' and 'n' or 'N'.  Invokes the "callback" of the
-- 		popup menu with the 1 for 'y' or 'Y' and zero for 'n' or 'N'
-- 		as the second argument.  Pressing Esc and 'x' works like
-- 		pressing 'n'.  CTRL-C invokes the callback with -1.  Other
-- 		keys are ignored.
-- 		See the example here: |popup_dialog-example|
--- @return number
function vim.fn.popup_filter_yesno(id, key) end

-- Get character {index} from {str}.  This uses a character
-- 		index, not a byte index.  Composing characters are considered
-- 		separate characters here.
-- 		Also see |strcharpart()| and |strchars()|.
--- @return number
function vim.fn.strgetchar(str, index) end

-- Bitwise XOR on the two arguments.  The arguments are converted
-- 		to a number.  A List, Dict or Float argument causes an error.
-- 		Example: >
-- 			:let bits = xor(bits, 0x80)
-- <
--- @return number
function vim.fn.xor(expr, expr) end

-- Unsubscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_unsubscribe(event) end

-- Like byteidx(), except that a composing character is counted
-- 		as a separate character.  Example: >
-- 			let s = 'e' . nr2char(0x301)
-- 			echo byteidx(s, 1)
-- 			echo byteidxcomp(s, 1)
-- 			echo byteidxcomp(s, 2)
-- <		The first and third echo result in 3 ('e' plus composing
-- 		character is 3 bytes), the second echo results in 1 ('e' is
-- 		one byte).
--- @return number
function vim.fn.byteidxcomp(expr, nr) end

-- Given {attr}, a value returned by term_scrape() in the "attr"
-- 		item, return whether {what} is on.  {what} can be one of:
-- 			bold
-- 			italic
-- 			underline
-- 			strike
-- 			reverse
--
-- 		Can also be used as a |method|: >
-- 			GetAttr()->term_getattr()
--- @return number
function vim.fn.term_getattr(attr, what) end

-- When v:exception does not contain the string {error} an error
-- 		message is added to |v:errors|.  Also see |assert-return|.
-- 		This can be used to assert that a command throws an exception.
-- 		Using the error number, followed by a colon, avoids problems
-- 		with translations: >
-- 			try
-- 			  commandthatfails
-- 			  call assert_false(1, 'command should have failed')
-- 			catch
-- 			  call assert_exception('E492:')
-- 			endtry
--- @return number
function vim.fn.assert_exception(error, msg) end

-- in the window.  This is counting screen lines from the top of
-- 		the window.  The first line is one.
-- 		If the cursor was moved the view on the file will be updated
-- 		first, this may cause a scroll.
--- @return number
function vim.fn.winline() end

-- Open a new window displaying the contents of {filename}
-- 		The file must have been created with |term_dumpwrite()|.
-- 		Returns the buffer number or zero when it fails.
-- 		Also see |terminal-diff|.
--
-- 		For {options} see |term_dumpdiff()|.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpload()
-- <
--- @return number
function vim.fn.term_dumpload(filename, options) end

-- the view of the current window.  Use |winrestview()| to
-- 		restore the view.
-- 		This is useful if you have a mapping that jumps around in the
-- 		buffer and you want to go back to the original view.
-- 		This does not save fold information.  Use the 'foldenable'
-- 		option to temporarily switch off folding, so that folds are
-- 		not opened when moving around. This may have side effects.
-- 		The return value includes:
-- 			lnum		cursor line number
-- 			col		cursor column (Note: the first column
-- 					zero, as opposed to what getpos()
-- 					returns)
-- 			coladd		cursor column offset for 'virtualedit'
-- 			curswant	column for vertical movement
-- 			topline		first line in the window
-- 			topfill		filler lines, only in diff mode
-- 			leftcol		first column displayed
-- 			skipcol		columns skipped
-- 		Note that no option values are saved.
--- @return dict
function vim.fn.winsaveview() end

-- Set the ANSI color palette used by terminal {buf}.
-- 		{colors} must be a List of 16 valid color names or hexadecimal
-- 		color codes, like those accepted by |highlight-guifg|.
-- 		Also see |term_getansicolors()| and |g:terminal_ansi_colors|.
--
-- 		The colors normally are:
-- 			0    black
-- 			1    dark red
-- 			2    dark green
-- 			3    brown
-- 			4    dark blue
-- 			5    dark magenta
-- 			6    dark cyan
-- 			7    light grey
-- 			8    dark grey
-- 			9    red
-- 			10   green
-- 			11   yellow
-- 			12   blue
-- 			13   magenta
-- 			14   cyan
-- 			15   white
--
-- 		These colors are used in the GUI and in the terminal when
-- 		'termguicolors' is set.  When not using GUI colors (GUI mode
-- 		or 'termguicolors'), the terminal window always uses the 16
-- 		ANSI colors of the underlying terminal.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setansicolors(colors)
--
-- <		{only available with GUI enabled and/or the |+termguicolors|
-- 		feature}
--- @return none
function vim.fn.term_setansicolors(buf, colors) end

