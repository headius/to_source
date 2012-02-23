require 'to_source'

src = "a = 123"

ast = src.to_ast
puts ast # (RootNode, (NewlineNode, (LocalAsgnNode:a, (FixnumNode))))

src2 = ast.to_source
p src2 # "a = 123"
