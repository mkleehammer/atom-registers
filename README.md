# registers package

Provides "registers" which are like named clipboard entries.  Text can be saved
to registers and inserted from it.

A special register named "quick" can be accessed with the following keys:

* `cmd-k cmd-c` - copy to the "quick" register
* `cmd-k cmd-x` - cut to the "quick" register
* `cmd-k cmd-v` - past from "quick" register

## Commands

### Register Copy

The collection of registers begins empty.  To copy text into a register use the
Register Copy function.  It will ask you to name the register and copy the current
text to it.

If there is a single selection, the selected text is copied.  


, overwriting the register if one already exis


## Future Improvements

At this time only a single selection is used.  If there are multiple selections,
Insert Selection will save the last.  I do not how multiple selections would be
put back into the document.

There are no rectangular registers.  Ideally the register should record whether
or not the selection was rectangular and it could paste appropriately.
