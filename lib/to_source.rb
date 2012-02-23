require 'java'
# http://search.maven.org/#search%7Cga%7C1%7Cjrubyparser
require 'jrubyparser-0.2.jar'

module ToSource
  SR = java.io.StringReader
  PC = org.jrubyparser.parser.ParserConfiguration
  P = org.jrubyparser.Parser
  RWV = org.jrubyparser.rewriter.ReWriteVisitor
  SW = java.io.StringWriter
end

class String
  def to_ast
    ToSource::P.new.parse('(string)', ToSource::SR.new(self), ToSource::PC.new)
  end
end

class org::jrubyparser::ast::Node
  def to_source
    sw = ToSource::SW.new
    rwv = ToSource::RWV.new(sw, '(string)')
    accept(rwv)
    sw.to_s
  end
end
