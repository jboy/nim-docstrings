# Copyright (c) 2015 SnapDisco Pty Ltd <james@snapdisco.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# This module is a simple demonstration of how to use the ``docstrings`` module
# in "docstrings.nim".
#
# Compile this module for a demonstration of the docstrings being extracted
# and printed to the console at compile-time.

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

    HOLDEN:  Maybe you're fed up.  Maybe you want to be by yourself, who knows?
    So you look down and see a tortoise.  It's crawling toward you --

    LEON:  A tortoise?  What's that?
    """

    docstring"""The ``extractdocstrings`` pragma (or better yet, your own
    custom pragma that invokes the ``extractAnyDocstrings`` proc, which is
    defined in the ``docstrings`` module) will extract all docstrings.
    """

    return int(x.float64 + z)

discard myProc(1, "2", 3.0)

