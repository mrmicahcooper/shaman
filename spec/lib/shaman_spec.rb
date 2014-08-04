require 'shaman'

describe Shaman do

  describe "#valid_json_body?" do
    subject { described_class.new(body) }
    context "when #body can be parsed to a Hash" do
      let(:body) { %q[{"foo":"bar"}] }
      it "returns true" do
        expect(subject.valid_json_body?).to be true
      end
    end
    context "when #body can't be parsed to a Hash" do
      let(:body) { %q["{foo"] }
      it "returns false" do
        expect(subject.valid_json_body?).to be false
      end
    end
    context "when #body cannot be parsed" do
      let(:body) { %q[{foo] }
      it "returns false" do
        expect(subject.valid_json_body?).to be false
      end
    end

    describe "#sha" do
      subject { described_class.new(body).sha }
      context "when request is valid JSON" do
        let(:body) { %q[{"foo":"bar"}] }
        it "creates a sha of the parsed JSON" do
          expect(subject).to eq('f59494512dabbab0cd0a421c43834271')
        end
      end
      context "when request is not valid JSON"
      let(:body) { %q[{foo] }
      it "creates a sha of the body" do
        expect(subject).to eq('594b979db0ddeee4bed8d10e9a2d21b1')
      end
    end

  end
end
