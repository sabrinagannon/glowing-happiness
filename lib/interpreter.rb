require 'debug'
require_relative 'parser'

class Interpreter
  def self.interpret(input)
    parsed = Parser.new(input).parse

    evaluate(parsed)
  end

  def self.evaluate(expression)
    current_term = if expression.is_a?(Array)
                     expression.first
                   else
                     expression
                   end

    case current_term
    when Integer
      current_term
    when Array
      evaluate(current_term)
    when '+'
      expression[1..].map { |e| evaluate(e) }.sum
    end
  end
end

