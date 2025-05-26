require_relative 'lib/interpreter'

class MyLilLisp
  raise "Too many arguments!" if ARGV.length > 1
  raise "Too few arguments!" if ARGV.length == 0
  pp Interpreter.interpret(ARGV[0])
end
