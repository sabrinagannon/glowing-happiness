require_relative 'parser'

class Interpreter
  def self.eval(input)
    # TODO: make this evaluate the parsed expressions
    parsed = Parser.new(input).parse
    pp parsed
  end
end

