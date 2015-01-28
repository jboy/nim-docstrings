# nim-docstrings
Python-like docstrings for code written in the
[Nim programming language](http://nim-lang.org).

Introduction
------------
This module implements Python-style docstrings that can be embedded in the
source code of a proc, along with some simple procs and macros that enable
those docstrings to be extracted by pragmas at compile-time.

These docstrings are used for automatic extraction of introspection
documentation from documented procs.

This is an alternative to Nim's built-in double-hash documentation comments,
since (at the time of writing) it was not possible for non-compiler code
to extract the text from the
[nnkCommentStmt](http://nim-lang.org/macros.html#TNimrodNodeKind)
nodes in the AST.

The most important procs and macros provided are:

1. the `docstring` proc, which is used to declare that the string literal
   is a docstring (using the syntax of
   [generalized raw string literals](http://nim-lang.org/manual.html#generalized-raw-string-literals))
2. the `extractdocstrings` macro, which is a simple example of a macro that
   can be annotated on your docstring-containing proc
   [as a pragma](http://nim-lang.org/manual.html#macros-as-pragmas),
   in order to extract and process docstrings
3. the `extractAnyDocstrings` compile-time proc, which is invoked by the
   `extractdocstrings` pragma (or better yet, your own custom more-useful
   pragma) to extract any docstrings in the proc
4. the `splitDocstringLines` compile-time proc, which you can optionally use
   to split a sequence of long docstrings (that may well contain newlines)
   into a sequence of single-line strings

Example usage
-------------
This example usage code is also provided in the accompanying Nim source file
`testDocstrings.nim`:

    import docstrings

    proc myProc(x: int, y: string, z: float64): int {. extractdocstrings .} =
        ## This double-hashed comment is a Nim documentation comment:
        ##  http://nim-lang.org/docgen.html#documentation-comments
        ##
        ## It's recognised by Nim's "docgen" utility, which is how the official
        ## Nim docs are generated.  However, I can't work out how to extract the
        ## text content of the documentation comment from my own code.
        ##
        ## Hence, I present extractable Python-style docstrings:
        docstring"""This is a Python-style docstring!

        It doesn't do anything by itself, but it can be extracted by pragmas like
        the ``extractdocstrings`` pragma, enabling non-compiler/non-docgen code
        to extract and process the text content of the docstring at compile-time.
        """
        echo($x, y, $z)  # just something to document...

        docstring"""This is another Python-style docstring in the same proc.
        There can be any number of docstrings amongst the top-level statements
        of a proc.  But why would you want multiple docstrings in your proc?

        Maybe you don't want a big slab of documentation right between your
        function prototype and your function body, pushing the body way down
        from the parameters in the prototype.  Maybe you want to document your
        algorithm step-by-step, integrated with the code.
        """

        docstring"""The ``extractdocstrings`` pragma (or better yet, your own
        custom pragma that invokes the ``extractAnyDocstrings`` proc, which is
        defined in the ``docstrings`` module) will extract all docstrings.
        """

        return int(x.float64 + z)

    discard myProc(1, "2", 3.0)

When you compile `testDocstrings.nim`, the docstrings will be extracted
and printed to the console at compile-time (in the midst of the compiler
output).  The output will look like this:

    Extracted docstrings:
    | This is a Python-style docstring!
    |
    | It doesn't do anything by itself, but it can be extracted by pragmas like
    | the ``extractdocstrings`` pragma, enabling non-compiler/non-docgen code
    | to extract and process the text content of the docstring at compile-time.
    |
    | This is another Python-style docstring in the same proc.
    | There can be any number of docstrings amongst the top-level statements
    | of a proc.  But why would you want multiple docstrings in your proc?
    |
    | Maybe you don't want a big slab of documentation right between your
    | function prototype and your function body, pushing the body way down
    | from the parameters in the prototype.  Maybe you want to document your
    | algorithm step-by-step, integrated with the code.
    |
    | The ``extractdocstrings`` pragma (or better yet, your own
    | custom pragma that invokes the ``extractAnyDocstrings`` proc, which is
    | defined in the ``docstrings`` module) will extract all docstrings.
    CC: testDocstrings
