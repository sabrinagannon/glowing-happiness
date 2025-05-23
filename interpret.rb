require 'pp'
require 'debug'

class Scanner
  attr_reader :source, :tokens

  def initialize(source)
    @source = source
    @tokens = []
  end

  def tokenize
    state, prev_state = nil
    long_token = ""
    source.each_char do |char|
      state = nil
      state = :word if char.match?(/[a-zA-Z+]/) # make this into something correct for lisp
      state = :number if char.match?(/\d/)
      case state
      when :word
          raise "Syntax error!" if prev_state == :number
          prev_state = :word
          long_token << char
      when :number
          raise "Syntax error!" if prev_state == :word
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
    tokens
  end
end


class Parser
  attr_accessor :tokens, :ast

  def initialize(tokens)
    @tokens = tokens
  end

  # [:"(", "first", :"(", "list", 1, :"(", :+, 2, 3, :")", 9, :")", :")"]
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
    else
      raise "Idk this token!"
    end
  end
end

class Interpreter
  raise "Too many arguments!" if ARGV.length > 1
  tokens = Scanner.new(ARGV[0]).tokenize
  puts "Tokens are #{tokens}"
  parsed = Parser.new(tokens).parse
  pp parsed
end
