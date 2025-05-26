require 'interpreter'

RSpec.describe Interpreter do
  describe ".interpret" do
    it "evaluates the + expression" do
      input = "(+ 1 1)"

      expect(described_class.interpret(input)).to eq(2)
    end

    it "evaluates the + expression for nested expressions" do
      input = "(+ 2 (+ 1 1))"

      expect(described_class.interpret(input)).to eq(4)
    end
  end
end
