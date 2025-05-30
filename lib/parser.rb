require 'pp'
require 'debug'

class Parser
  class SyntaxError < StandardError; end

  attr_accessor :source, :tokens, :ast

  def initialize(source)
    @source = source
    @tokens = []
  end

  def tokenize
    state, prev_state = nil
    long_token = ""
    source.each_char do |char|
      state = nil
      state = :word if char.match?(/[a-zA-Z+-\/\*]/)
      state = :number if char.match?(/\d/)
      case state
      when :word
        raise SyntaxError.new("Expected number char, recieved word char") if prev_state == :number
        prev_state = :word
        long_token << char
      when :number
        raise SyntaxError.new("Expected word char, recieved number char") if prev_state == :word
        prev_state = :number
        long_token << char
      else
        long_token = if prev_state == :number

                       long_token.to_i
                     else
                       long_token
                     end
        state, prev_state = nil
        tokens << long_token unless !long_token.is_a?(Integer) && long_token.empty?
        tokens << char.to_sym unless char.match?(/\s/)
        long_token = ""
      end
    end
    tokens = tokens
  end

  def parse
    tokenize if tokens.empty?
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
