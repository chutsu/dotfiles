## Why is list comprehension faster?

[**List comprehensions**][1] perform better here because you don’t need to load
the append attribute of the list and call it as a function!*

Consider the following example :

    >>> import dis
    >>> def f1():
    ...   for i in range(5):
    ...      l.append(i)
    ...
    >>> def f2():
    ...   [i for i in range(5)]
    ...
    >>> dis.dis(f1)
      2           0 SETUP_LOOP              33 (to 36)
                  3 LOAD_GLOBAL              0 (range)
                  6 LOAD_CONST               1 (5)
                  9 CALL_FUNCTION            1
                 12 GET_ITER
            >>   13 FOR_ITER                19 (to 35)
                 16 STORE_FAST               0 (i)

      3          19 LOAD_GLOBAL              1 (l)
                 22 LOAD_ATTR                2 (append)
                 25 LOAD_FAST                0 (i)
                 28 CALL_FUNCTION            1
                 31 POP_TOP
                 32 JUMP_ABSOLUTE           13
            >>   35 POP_BLOCK
            >>   36 LOAD_CONST               0 (None)
                 39 RETURN_VALUE
    >>> dis.dis(f2)
      2           0 BUILD_LIST               0
                  3 LOAD_GLOBAL              0 (range)
                  6 LOAD_CONST               1 (5)
                  9 CALL_FUNCTION            1
                 12 GET_ITER
            >>   13 FOR_ITER                12 (to 28)
                 16 STORE_FAST               0 (i)
                 19 LOAD_FAST                0 (i)
                 22 LIST_APPEND              2
                 25 JUMP_ABSOLUTE           13
            >>   28 POP_TOP
                 29 LOAD_CONST               0 (None)
                 32 RETURN_VALUE
    >>>

You can see that in byte-code 22 we have an `append` attribute in first
function since we have not such thing in second function using list
comprehension.

Also note that you'll have `append` attr loading in each iteration thus it
makes your code takes approximately 2 time slower than the second function
using list comprehension.

> Moreover, depending on your Python and code, list comprehensions might run
much faster than manual `for` loop statements (often roughly twice as fast)
because their iterations are **performed at C language speed** inside the
interpreter, rather than with manual Python code. Especially for larger data
sets, there is often a major performance advantage to using this expression.**

You can read more about [Efficiency of list comprehensions](
http://blog.cdleary.com/2010/04/efficiency-of-list-comprehensions/)
