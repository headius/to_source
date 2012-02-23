require 'rjb'

found = $:.find do |path|
  jar_path = File.join(path, 'jrubyparser-0.2.jar')
  if File.exist? jar_path
    Rjb::load(classpath = jar_path, jvmargs=[])
    true
  end
end
raise "jrubyparser-0.2.jar not found" unless found

module ToSource
  SR = Rjb::import('java.io.StringReader')
  PC = Rjb::import('org.jrubyparser.parser.ParserConfiguration')
  P = Rjb::import('org.jrubyparser.Parser')
  RWV = Rjb::import('org.jrubyparser.rewriter.ReWriteVisitor')
  SW = Rjb::import('java.io.StringWriter')
end

class String
  def to_ast
    ToSource::P.new.parse('(string)', ToSource::SR.new(self), ToSource::PC.new)
  end
end

class Rjb::Rjb_JavaProxy
  def to_s
    toString
  end

  # FIXME: Yeah, I think this is adding to all proxies.
  def to_source
    sw = ToSource::SW.new
    rwv = ToSource::RWV.new(sw, '(string)')
    accept(rwv)
    sw.toString
  end
end