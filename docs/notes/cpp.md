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


## Why should I prefer to use member initialization list?

For [POD](https://stackoverflow.com/a/146454/626796) class members, it makes no
difference, it's just a matter of style.  For class members which are classes,
then it avoids an unnecessary call to a default constructor.  Consider:

    class A
    {
    public:
        A() { x = 0; }
        A(int x_) { x = x_; }
        int x;
    };

    class B
    {
    public:
        B()
        {
            a.x = 3;
        }
    private:
        A a;
    };

In this case, the constructor for `B` will call the default constructor for
`A`, and then initialize `a.x` to 3.  A better way would be for `B`'s
constructor to directly call `A`'s constructor in the initializer list:

    B()
      : a(3)
    {
    }

This would only call `A`'s `A(int)` constructor and not its default
constructor.  In this example, the difference is negligible, but imagine if you
will that `A`'s default constructor did more, such as allocating memory or
opening files.  You wouldn't want to do that unnecessarily.

Furthermore, if a class doesn't have a default constructor, or you have a
`const` member variable, you *must* use an initializer list:

    class A
    {
    public:
        A(int x_) { x = x_; }
        int x;
    }

    class B
    {
    public:
        B() : a(3), y(2)  // 'a' and 'y' MUST be initialized in an initializer list;
        {                 // it is an error not to do so
        }
    private:
        A a;
        const int y;
    };



## Why use brace initialization

Brace initialization has many benefits. It will prevent narrowing of
conversions from floating-point type to integer, conversions from long double
to double or to float, and conversions from double to float.

		int number = 2.12; // 2.12 will be narrowed and number becomes 2
		int number2{2.12}; // floating-point to integer conversion: Error
		// Note:
		int num{2.12}; // this is equivalent to int num = {2.12}

Of the three ways of initializing an expression ('=', '()' and '{}') in C++ the
braces are the safest option to use.

		SomeClass c1("Message"); // A constructor with argument "Message"
		SomeClass c2(); // Bad: declares a function c2 that returns SomeClass
		SomeClass c3{}; // Good: calls the SomeClass constructor with no arguments

In the above example if you intended to declare a function that returns
SomeClass then you are lucky, but the usage is ambiguous and should be avoided.

That being said there are some gotchas:

1. If you are using 'auto' you might want to keep it mind that the type deduced
   for braced-init-list will be a  std::initializer_list
2. In cases where there are calls to any constructor if any constructor declare
   a parameter of type  std::initializer_list  the calls that use
	 brace-initialization will prefer the constructors that take the initializer
	 list. Example:

		class SomeClass {
		public:
				SomeClass(int a, bool b); // one
				SomeClass(std::initializer_list<int> iList); // two
				SomeClass(); // three
		};

		// Calls constructor one
		SomeClass c1(1, true);

		// Calls constructor two and true is converted to int
		SomeClass c2{1, true};

		// Calls constructor two even though the types don't match and this will
		// result in an error because of narrowing conversions
		SomeClass c3{12.112, 12.12};

		// Calls the default constructor three
		SomeClass c4();

		// Also calls the default constructor three
		SomeClass c5{};

In the above example empty braces do not mean an empty initializer list and as
a result it doesn't call constructor two. If you wanted to use the second
constructor you would use a call like ```SomeClass c6{{}}; // or SomeClass
c6({});```
