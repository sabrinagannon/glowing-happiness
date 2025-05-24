require_relative 'scanner'
require_relative 'parser'

class Interpreter
  def self.eval(input)
    # TODO: make this evaluate the parsed expressions
    tokens = Scanner.new(input).tokenize
    parsed = Parser.new(tokens).parse
    pp parsed
  end
end

