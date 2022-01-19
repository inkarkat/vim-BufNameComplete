BUF NAME COMPLETE
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

The built-in filename completion i\_CTRL-X\_CTRL-F searches the file system
based on the current directory, so potentially there can be many matches.
But often, the file one wants to refer to is already open inside Vim.

This plugin offers an alternative filename completion that just considers
buffers loaded in Vim. Matches can start at any path component, so the mapping
is especially useful for inserting relative paths, e.g. in
```
    #include "lib/f|
```

### SOURCE

- [This completion type was motivated by this Stack Overflow question:](http://stackoverflow.com/questions/13406751/vim-completion-based-on-buffer-name)

### SEE ALSO

- Check out the CompleteHelper.vim plugin page ([vimscript #3914](http://www.vim.org/scripts/script.php?script_id=3914)) for a full
  list of insert mode completions powered by it.

USAGE
------------------------------------------------------------------------------

    In insert mode, invoke the completion via CTRL-X f
    You can then search forward and backward via CTRL-N / CTRL-P, as usual.

    CTRL-X f                Search for filenames loaded in Vim buffers (:ls)
                            that start with the same 'isfname' characters as
                            before the cursor.
                            Any path component or the file name itself can start
                            with the characters. When there are no filename
                            characters before the cursor, both filename and
                            filespec (relative to the current directory) of all
                            loaded buffers are listed.

    {Visual}CTRL-X f        Search for filenames loaded in Vim buffers (:ls)
                            that start with the selected text.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-BufNameComplete
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim BufNameComplete*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the CompleteHelper.vim plugin ([vimscript #3914](http://www.vim.org/scripts/script.php?script_id=3914)), version 1.10 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

If you want to use a different mapping, map your keys to the
&lt;Plug&gt;(BufNameComplete) mapping target _before_ sourcing the script (e.g. in
your vimrc):

    imap <C-x>f <Plug>(BufNameComplete)

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-BufNameComplete/issues or email (address
below).

HISTORY
------------------------------------------------------------------------------

##### 1.01    RELEASEME
- Add visual mode mapping to select the used base.

##### 1.00    16-Nov-2012
- First published version.

------------------------------------------------------------------------------
Copyright: (C) 2012-2022 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
