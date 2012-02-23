to_source for JRuby
===================

This is a simple library that wraps the "jrubyparser" jar
created by the JRuby team and used by several Java-based
Ruby IDEs. It adds #to_ast to String and the resulting
AST (a tree of org.jrubyparser.ast.Node subclasses) has
a #to_source method.

This library works from RJB as well, though I have not
done much testing there. RJB does not appear to be able
to decorate an individual Java class (and cascade to its
subclasses) so instead we just open the one RJB proxy
superclass.

jrubyparser is at https://github.com/jruby/jruby-parser

Round-Tripping
--------------

Because jrubyparser was created for use by IDEs, it has
the unique benefit of being able to round-trip code without
losing information. This means constructs normally collapsed
by other parsing libraries (like single vs double quotes, 
HERE docs, whitespace) are preserved and available.

Rewriting
---------

jrubyparser also contains an AST rewriting subsystem that
was originally created for experimental refactoring tools
in the Eclipse-based Ruby Development Tools project. The
rewriter is used in to_source to simply output the source
version of a given AST.

Example Use
-----------

```
require 'to_source'

src = "a = 123"

ast = src.to_ast
puts ast # (RootNode, (NewlineNode, (LocalAsgnNode:a, (FixnumNode))))

src2 = ast.to_source
p src2 # "a = 123"
```
