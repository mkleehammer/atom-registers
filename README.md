# registers package

**This package has been unpublished because I am no longer using Atom.  Let me know if you are willing to take this project over.**

Provides "registers" which are like named clipboard entries.  Text can be saved to registers
and inserted from them later.

Registers are named using strings, so they can be given names as descriptive as necessary.  A
special register named "quick" can be accessed with the following keys:

* `cmd-k cmd-c` - copy to the "quick" register
* `cmd-k cmd-x` - cut to the "quick" register
* `cmd-k cmd-v` - paste from the "quick" register

## Commands

### Registers : Copy

The collection of registers begins empty.  To copy text into a register use the Register : Copy
function.  It will ask you to name the register and copy the current text to it.

![Screenshot](http://mkleehammer.github.com/atom-registers/images/save.png)

If there is a selection the selected text is copied, otherwise the current line is
copied.

At this time multiple selections are not supported -- the text from the last selection is
copied.

### Registers : Copy Quick

The `cmd-k cmd-c` shortcut executes this command which is a copy, but to a register named
"quick", skipping the "Save To Register" dialog.

### Registers : Paste

To paste a register that has been copied, use the Register : Paste command.  It will
display a list of all registers and you can use fuzzy matching for the name.  The matching does not
currently search the copied text.

![Screenshot](http://mkleehammer.github.com/atom-registers/images/list.png)

### Registers : Paste Quick

The `cmd-k cmd-v` shortcut executes this command which pastes the contents of the register
named "quick".

### Registers : Cut

Registers : Cut is simply a Register : Copy but then the selection is deleted.

### Registers : Cut Quick

The `cmd-k cmd-x` shortcut cuts the current text to a register named "quick".

### Registers : Delete

Displays the list of registers and deletes the selected one.

### Registers : Delete All

As you would expect, all registers are deleted.

## Restart

The contents of registers are serialized with the project so they are available
after restarting Atom.
