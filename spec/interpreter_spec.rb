require 'interpreter'

RSpec.describe Interpreter do
  describe ".eval" do
    it "returns the expected tokens" do
      input = "(first (list 1 (+ 2 3) 9))"
      expect(described_class.eval(input)).to eq(["first", ["list", 1, ["+", 2, 3], 9]])
    end

    context "when the input string is missing a closing bracket" do
      it "raises a syntax error" do
        input = "(first (list 1 (+ 2 3) 9)"
        expect do
          described_class.eval(input)
        end.to raise_error(SyntaxError)
      end
    end

    context "when the input string is missing an opening bracket" do
      it "raises a syntax error" do
        skip 'TODO'
      end
    end

    it "evaluates the + expression" do
      skip 'TODO'
    end
  end
end
