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
    state = nil
    long_token = ""
    source.each_char do |char|
      case char
      when "("
        state = nil
        tokens << long_token unless long_token.empty?
        long_token = ""
        tokens << :open
      when ")"
        state = nil
        tokens << long_token unless long_token.empty?
        long_token = ""
        tokens << :close
      when /[a-zA-Z]/
        raise "Syntax error!" if state == :number
        state = :word if state.nil?
        long_token << char
      when /\d/
        raise "Syntax error!" if state == :word
        state = :number if state.nil?
        long_token << char
      else
        state = nil
        tokens << long_token unless long_token.empty?
        tokens << char unless char.match?(/\s/)
        long_token = ""
      end
    end
  end

  def lex
    tokens.each do |token|
    end
  end
end

class Lisp
  raise "Too many arguments!" if ARGV.length > 1
  Scanner.new(ARGV[0]).scan
end
