require 'pp'
require 'debug'
require_relative 'errors'

class Parser
  attr_accessor :tokens

  def initialize(tokens)
    @tokens = tokens
  end

  def parse
    current = tokens.first
    case current
    when Integer, String
      tokens.shift
    when :"("
      node = []
      tokens.shift
      until tokens.first == :")"
        node << parse
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
