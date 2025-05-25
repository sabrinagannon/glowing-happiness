require 'parser'

RSpec.describe Parser do
  describe "parse" do
    it "returns the expected tokens" do
      input = "(first (list 1 (+ 2 3) 9))"
      expect(described_class.new(input).parse).to eq(["first", ["list", 1, ["+", 2, 3], 9]])
    end

    context "when the input string is missing a closing bracket" do
      it "raises a syntax error" do
        input = "("
        expect do
          described_class.new(input).parse
        end.to raise_error(described_class::SyntaxError, 'Missing closing bracket')
      end
    end

    context "when the input string is missing an opening bracket" do
      it "raises a syntax error" do
        input = "())"
        expect do
          described_class.new(input).parse
        end.to raise_error(described_class::SyntaxError, 'Missing opening bracket')
      end
    end
  end
end
