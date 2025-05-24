require 'pp'
require 'debug'
require_relative 'errors'

class Parser
  attr_accessor :tokens, :ast

  def initialize(tokens)
    @tokens = tokens
  end

  def parse
    ast = consume

    raise SyntaxError.new("Missing opening bracket") if tokens.any?
    ast
  end

  def consume
    current = tokens.first
    case current
    when Integer, String
      tokens.shift
    when :"("
      node = []
      tokens.shift
      until tokens.first == :")"
        node << consume
      end
      tokens.shift
      node
    when nil
      raise SyntaxError.new("Missing closing bracket")
    else
      raise SyntaxError.new("Idk this token!")
    end
  end
end
