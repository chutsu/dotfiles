## Why does the order of '-l' option in gcc matter?

Because that's how the linking algorithm used by GNU linker works (a least when
it comes to linking static libraries).

A library is a collection (an archive) of object files. When you add a library
using the -l option, the linker does not unconditionally take all object files
from the library. It only takes those object files that are currently needed,
i.e. files that resolve some currently unresolved (pending) symbols. After
that, the linker completely forgets about that library.

The list of pending symbols is continuously maintained by the linker as the
linker processes input object files, one after another from left to right. As
it processes each object file, some symbols get resolved and removed from the
list, other newly discovered unresolved symbols get added to the list.

So, if you included some library by using -l, the linker uses that library to
resolve as many currently pending symbols as it can, and then completely
forgets about that library. If it later suddenly discovers that it now needs
some additional object file(s) from that library, the linker will not "return"
to that library to retrieve those additional object files. It is already too
late.

For this reason, it is always a good idea to use -l option late in the linker's
command line, so that by the time the linker gets to that -l it can reliably
determine which object files it needs and which it doesn't need. Placing the -l
option as the very first parameter to the linker generally makes no sense at
all: at the very beginning the list of pending symbols is empty (or, more
precisely, consists of single symbol main), meaning that the linker will not
take anything from the library at all.

In your case, your object file example.o contains references to symbols
ud_init, ud_set_input_file etc. The linker should receive that object file
first. It will add these symbols to the list of pending symbols. After that you
can use -l option to add the your library: -ludis86. The linker will search
your library and take everything from it that resolves those pending symbols.

If you place the -ludis86 option first in the command line, the linker will
effectively ignore your library, since at the beginning it does not know that
it will need ud_init, ud_set_input_file etc. Later, when processing example.o
it will discover these symbols and add them to the pending symbol list. But
these symbols will remain unresolved to the end, since -ludis86 was already
processed (and effectively ignored).

Sometimes, when two (or more) libraries refer to each other in circular
fashion, one might even need to use the -l option twice with the same library,
to give linker two chances to retrieve the necessary object files from that
library.
