---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- string	(default: "tab:> ,trail:-,nbsp:+"
-- 				 Vi default: "eol:$")
-- 			global or local to window |global-local|
-- 	Strings to use in 'list' mode and for the |:list| command.  It is a
-- 	comma separated list of string settings.
vim.wo.listchars = "tab:> ,trail:-,nbsp:+"
-- string (default: "#")
-- 			local to window
-- 	Used only when 'foldmethod' is "indent".  Lines starting with
-- 	characters in 'foldignore' will get their fold level from surrounding
-- 	lines.  White space is skipped before checking for this character.
-- 	The default "#" works well for C programs.  See |fold-indent|.
vim.wo.foldignore = "#"
-- string (default: "foldtext()")
-- 			local to window
-- 	An expression which is used to specify the text displayed for a closed
-- 	fold.  See |fold-foldtext|.
vim.wo.foldtext = "foldtext()"
-- boolean	(default on)
-- 			local to window
-- 	This option changes how text is displayed.  It doesn't change the text
-- 	in the buffer, see 'textwidth' for that.
-- 	When on, lines longer than the width of the window will wrap and
-- 	displaying continues on the next line.  When off lines will not wrap
-- 	and only part of long lines will be displayed.  When the cursor is
-- 	moved to a part that is not shown, the screen will scroll
-- 	horizontally.
-- 	The line will be broken in the middle of a word if necessary.  See
-- 	'linebreak' to get the break at a word boundary.
-- 	To make scrolling horizontally a bit more useful, try this: >
-- 		:set sidescroll=5
-- 		:set listchars+=precedes:<,extends:>
-- <	See 'sidescroll', 'listchars' and |wrap-off|.
-- 	This option can't be set from a |modeline| when the 'diff' option is
-- 	on.
vim.wo.wrap = "true"
-- string (default: "manual")
-- 			local to window
-- 	The kind of folding used for the current window.  Possible values:
-- 	|fold-manual|	manual	    Folds are created manually.
-- 	|fold-indent|	indent	    Lines with equal indent form a fold.
-- 	|fold-expr|	expr	    'foldexpr' gives the fold level of a line.
-- 	|fold-marker|	marker	    Markers are used to specify folds.
-- 	|fold-syntax|	syntax	    Syntax highlighting items specify folds.
-- 	|fold-diff|	diff	    Fold text that is not changed.
vim.wo.foldmethod = "manual"
-- string	(default "")
-- 			global
-- 	A comma separated list of these words:
-- 	    block	Allow virtual editing in Visual block mode.
-- 	    insert	Allow virtual editing in Insert mode.
-- 	    all		Allow virtual editing in all modes.
-- 	    onemore	Allow the cursor to move just past the end of the line
vim.wo.virtualedit = ""
-- string (default "0")
-- 			local to window
-- 	When and how to draw the foldcolumn. Valid values are:
-- 	    "auto":       resize to the maximum amount of folds to display.
-- 	    "auto:[1-9]": resize to accommodate multiple folds up to the
-- 			  selected level
--             0:            to disable foldcolumn
-- 	    "[1-9]":      to display a fixed number of columns
-- 	See |folding|.
vim.wo.foldcolumn = "0"
-- boolean (default off)
-- 			local to window
-- 	Identifies the preview window.  Only one window can have this option
-- 	set.  It's normally not set directly, but by using one of the commands
-- 	|:ptag|, |:pedit|, etc.
vim.wo.previewwindow = "false"
-- boolean  (default off)
-- 			local to window
-- 	See also |scroll-binding|.  When this option is set, the current
-- 	window scrolls as other scrollbind windows (windows that also have
-- 	this option set) scroll.  This option is useful for viewing the
-- 	differences between two versions of a file, see 'diff'.
-- 	See |'scrollopt'| for options that determine how this option should be
-- 	interpreted.
-- 	This option is mostly reset when splitting a window to edit another
-- 	file.  This means that ":split | edit file" results in two windows
-- 	with scroll-binding, but ":split file" does not.
vim.wo.scrollbind = "false"
-- boolean	(default off)
-- 			local to window
-- 	List mode: Show tabs as CTRL-I is displayed, display $ after end of
-- 	line.  Useful to see the difference between tabs and spaces and for
-- 	trailing blanks.  Further changed by the 'listchars' option.
vim.wo.list = "false"
-- number	(default: half the window height)
-- 			local to window
-- 	Number of lines to scroll with CTRL-U and CTRL-D commands.  Will be
-- 	set to half the number of lines in the window when the window size
-- 	changes.  If you give a count to the CTRL-U or CTRL-D command it will
-- 	be used as the new value for 'scroll'.  Reset to half the window
-- 	height with ":set scroll=0".
vim.wo.scroll = "0"
-- number (default 0)
-- 			local to window
-- 	Determine how text with the "conceal" syntax attribute |:syn-conceal|
-- 	is shown:
vim.wo.conceallevel = "0"
-- string	(default "")
-- 			global or local to window |global-local|
-- 	Characters to fill the statuslines and vertical separators.
-- 	It is a comma separated list of items:
vim.wo.fillchars = ""
-- number (default: 1)
-- 			local to window
-- 	Sets the number of screen lines above which a fold can be displayed
-- 	closed.  Also for manually closed folds.  With the default value of
-- 	one a fold can only be closed if it takes up two or more screen lines.
-- 	Set to zero to be able to close folds of just one screen line.
-- 	Note that this only has an effect on what is displayed.  After using
-- 	"zc" to close a fold, which is displayed open because it's smaller
-- 	than 'foldminlines', a following "zc" may close a containing fold.
vim.wo.foldminlines = "1"
-- string (default empty)
-- 			local to window
-- 	Settings for 'breakindent'. It can consist of the following optional
-- 	items and must be separated by a comma:
-- 		min:{n}	    Minimum text width that will be kept after
-- 			    applying 'breakindent', even if the resulting
-- 			    text should normally be narrower. This prevents
-- 			    text indented almost to the right window border
-- 			    occupying lot of vertical space when broken.
-- 		shift:{n}   After applying 'breakindent', the wrapped line's
-- 			    beginning will be shifted by the given number of
-- 			    characters.  It permits dynamic French paragraph
-- 			    indentation (negative) or emphasizing the line
-- 			    continuation (positive).
-- 		sbr	    Display the 'showbreak' value before applying the
-- 			    additional indent.
-- 	The default value for min is 20 and shift is 0.
vim.wo.breakindentopt = ""
-- boolean	(default off)
-- 			local to window
-- 	Show the line number relative to the line with the cursor in front of
-- 	each line. Relative line numbers help you use the |count| you can
-- 	precede some vertical motion commands (e.g. j k + -) with, without
-- 	having to calculate it yourself. Especially useful in combination with
-- 	other commands (e.g. y d c < > gq gw =).
-- 	When the 'n' option is excluded from 'cpoptions' a wrapped
-- 	line will not use the column of line numbers.
-- 	The 'numberwidth' option can be used to set the room used for the line
-- 	number.
-- 	When a long, wrapped line doesn't start with the first character, '-'
-- 	characters are put before the number.
-- 	See |hl-LineNr|  and |hl-CursorLineNr| for the highlighting used for
-- 	the number.
vim.wo.relativenumber = "false"
-- boolean	(default off)
-- 			local to window
-- 	Keep the window height when windows are opened or closed and
-- 	'equalalways' is set.  Also for |CTRL-W_=|.  Set by default for the
-- 	|preview-window| and |quickfix-window|.
-- 	The height may be changed anyway when running out of room.
vim.wo.winfixheight = "false"
-- string (default: "number,line")
-- 			local to window
-- 			{not available when compiled without the |+syntax|
-- 			feature}
-- 	Comma separated list of settings for how 'cursorline' is displayed.
-- 	Valid values:
-- 	"line"		Highlight the text line of the cursor with
-- 			CursorLine |hl-CursorLine|.
-- 	"screenline"	Highlight only the screen line of the cursor with
-- 			CursorLine |hl-CursorLine|.
-- 	"number"	Highlight the line number of the cursor with
-- 			CursorLineNr |hl-CursorLineNr|.
vim.wo.cursorlineopt = "both"
-- number (default: 20)
-- 			local to window
-- 	Sets the maximum nesting of folds for the "indent" and "syntax"
-- 	methods.  This avoids that too many folds will be created.  Using more
-- 	than 20 doesn't work, because the internal limit is 20.
vim.wo.foldnestmax = "20"
-- boolean	(default off)
-- 			local to window
-- 	When on, display orientation becomes right-to-left, i.e., characters
-- 	that are stored in the file appear from the right to the left.
-- 	Using this option, it is possible to edit files for languages that
-- 	are written from the right to the left such as Hebrew and Arabic.
-- 	This option is per window, so it is possible to edit mixed files
-- 	simultaneously, or to view the same file in both ways (this is
-- 	useful whenever you have a mixed text file with both right-to-left
-- 	and left-to-right strings so that both sets are displayed properly
-- 	in different windows).  Also see |rileft.txt|.
vim.wo.rightleft = "false"
-- number	(default 0)
-- 			local to window
-- 	Enables pseudo-transparency for a floating window. Valid values are in
-- 	the range of 0 for fully opaque window (disabled) to 100 for fully
-- 	transparent background. Values between 0-30 are typically most useful.
vim.wo.winblend = "0"
vim.wo.winbar = ""
-- string	(default "")
-- 			global
-- 	String to put at the start of lines that have been wrapped.  Useful
-- 	values are "> " or "+++ ": >
-- 		:set showbreak=>\
-- <	Note the backslash to escape the trailing space.  It's easier like
-- 	this: >
-- 		:let &showbreak = '+++ '
-- <	Only printable single-cell characters are allowed, excluding <Tab> and
-- 	comma (in a future version the comma might be used to separate the
-- 	part that is shown at the end and at the start of a line).
-- 	The |hl-NonText| highlight group determines the highlighting.
-- 	Note that tabs after the showbreak will be displayed differently.
-- 	If you want the 'showbreak' to appear in between line numbers, add the
-- 	"n" flag to 'cpoptions'.
vim.wo.showbreak = ""
-- boolean	(default off)
-- 			local to window
-- 	Keep the window width when windows are opened or closed and
-- 	'equalalways' is set.  Also for |CTRL-W_=|.
-- 	The width may be changed anyway when running out of room.
vim.wo.winfixwidth = "false"
-- number (default: 0)
-- 			local to window
-- 	Sets the fold level: Folds with a higher level will be closed.
-- 	Setting this option to zero will close all folds.  Higher numbers will
-- 	close fewer folds.
-- 	This option is set by commands like |zm|, |zM| and |zR|.
-- 	See |fold-foldlevel|.
vim.wo.foldlevel = "0"
-- string	(default "auto")
-- 			local to window
-- 	When and how to draw the signcolumn. Valid values are:
-- 	   "auto"   	only when there is a sign to display
-- 	   "auto:[1-9]" resize to accommodate multiple signs up to the
-- 	                given number (maximum 9), e.g. "auto:4"
-- 	   "no"	    	never
-- 	   "yes"    	always
-- 	   "yes:[1-9]"  always, with fixed space for signs up to the given
-- 	                number (maximum 9), e.g. "yes:3"
vim.wo.signcolumn = "auto"
-- number	(default 0)
-- 			global or local to window |global-local|
-- 	Minimal number of screen lines to keep above and below the cursor.
-- 	This will make some context visible around where you are working.  If
-- 	you set it to a very large value (999) the cursor line will always be
-- 	in the middle of the window (except at the start or end of the file or
-- 	when long lines wrap).
-- 	After using the local value, go back the global value with one of
-- 	these two: >
-- 		setlocal scrolloff<
-- 		setlocal scrolloff=-1
-- <	For scrolling horizontally see 'sidescrolloff'.
vim.wo.scrolloff = "0"
vim.wo.smoothscroll = "false"
-- boolean (default on)
-- 			local to window
-- 	When off, all folds are open.  This option can be used to quickly
-- 	switch between showing all text unfolded and viewing the text with
-- 	folds (including manually opened or closed folds).  It can be toggled
-- 	with the |zi| command.  The 'foldcolumn' will remain blank when
-- 	'foldenable' is off.
-- 	This option is set by commands that create a new fold or close a fold.
-- 	See |folding|.
vim.wo.foldenable = "true"
-- boolean (default off)
-- 			local to window
-- 	This option can be set to start editing Arabic text.
-- 	Setting this option will:
-- 	- Set the 'rightleft' option, unless 'termbidi' is set.
-- 	- Set the 'arabicshape' option, unless 'termbidi' is set.
-- 	- Set the 'keymap' option to "arabic"; in Insert mode CTRL-^ toggles
-- 	  between typing English and Arabic key mapping.
-- 	- Set the 'delcombine' option
vim.wo.arabic = "false"
-- number (default 0)
-- 			global or local to window |global-local|
-- 	The minimal number of screen columns to keep to the left and to the
-- 	right of the cursor if 'nowrap' is set.  Setting this option to a
-- 	value greater than 0 while having |'sidescroll'| also at a non-zero
-- 	value makes some context visible in the line you are scrolling in
-- 	horizontally (except at beginning of the line).  Setting this option
-- 	to a large value (like 999) has the effect of keeping the cursor
-- 	horizontally centered in the window, as long as one does not come too
-- 	close to the beginning of the line.
-- 	After using the local value, go back the global value with one of
-- 	these two: >
-- 		setlocal sidescrolloff<
-- 		setlocal sidescrolloff=-1
-- <
-- 	Example: Try this together with 'sidescroll' and 'listchars' as
-- 		 in the following example to never allow the cursor to move
-- 		 onto the "extends" character: >
vim.wo.sidescrolloff = "0"
-- string	(default "search")
-- 			local to window
-- 	Each word in this option enables the command line editing to work in
-- 	right-to-left mode for a group of commands:
vim.wo.rightleftcmd = "search"
vim.wo.statuscolumn = ""
-- string	(default "")
-- 			local to window
-- 	'colorcolumn' is a comma separated list of screen columns that are
-- 	highlighted with ColorColumn |hl-ColorColumn|.  Useful to align
-- 	text.  Will make screen redrawing slower.
-- 	The screen column can be an absolute number, or a number preceded with
-- 	'+' or '-', which is added to or subtracted from 'textwidth'. >
vim.wo.colorcolumn = ""
-- boolean	(default off)
-- 			local to window
-- 	When on spell checking will be done.  See |spell|.
-- 	The languages are specified with 'spelllang'.
vim.wo.spell = "false"
