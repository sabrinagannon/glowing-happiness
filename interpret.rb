# https://ruby-doc.org/3.2.2/stdlibs/optparse/OptionParser.html

# require 'optparse'
# require 'optparse/time'
# require 'ostruct'
# require 'pp'
# require 'cli/ui'
require 'debug'

class Scanner
  attr_reader :source, :tokens

  def initialize(source)
    @source = source
    @tokens = []
  end

  def scan
    state, prev_state = nil
    long_token = ""
    source.each_char do |char|
      state = nil
      state = :word if char.match?(/[a-zA-Z]/)
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
  end
end


class Parser
  attr_accessor :tokens, :ast

  def initialize(tokens)
    @tokens = tokens
    @ast = []
  end

  # [:"(", "first", :"(", "list", 1, :"(", :+, 2, 3, :")", 9, :")", :")"]
  def parse
    until tokens.empty?
      current = tokens.shift
      # case current
      #   # handle based on type of token here
      # end
    end
  end

  def parse_expression
    if :open

    end
  end
end

class Lisp
  raise "Too many arguments!" if ARGV.length > 1
  Scanner.new(ARGV[0]).scan
end
