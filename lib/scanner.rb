require 'pp'
require 'debug'
require_relative 'errors'

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
    tokens
  end
end
