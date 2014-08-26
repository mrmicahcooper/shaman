require 'shaman'

describe Shaman do

  subject do
    described_class.new(body)
  end

  context "when #body can be parsed to a Hash" do
    let(:body) { %q[{"foo":"bar"}] }
    it "returns true" do
      expect(subject.valid_json_body?).to be true
    end
  end

  context "when #body can't be parsed to a Hash" do
    let(:body) { %q["{foo"] }
    it "returns false" do
      expect(subject.valid_json?).to be false
    end
  end

  context "when #body cannot be parsed" do
    let(:body) { %q[{foo] }
    it "returns false" do
      expect(subject.valid_json?).to be false
    end
  end

  describe "#sha" do

    subject do
      described_class.new(body).sha
    end

    context "when request is valid JSON" do
      let(:body) { %q[{"foo":"bar"}] }
      it "creates a sha of the parsed JSON" do
        expect(subject).to eq('f59494512dabbab0cd0a421c43834271')
      end
    end
    context "when request is not valid JSON"
    let(:body) { %q[{foo] }
    it "creates a sha of the form encoded parsed body" do
      expect(subject).to eq('c22147b34317edaa3ab976ae1bff8712')
    end

    context "with nested valid JSON" do
      let(:body) do
        foo = {
          z: {yar: "dar"},
          a: {c: "baz"},
          b: {
            d: "mother",
            a: "father"
          }
        }
        Oj.dump(foo)
      end

      it "creates a sha of the parsed sorted json" do
        expect(subject).to eq("f246fa6a718144a0ec677a1db58fac52")
      end
    end
  end

  describe "valid xml body" do
    context "when #body can be parsed to a Hash" do
      let(:body) { %q[<xml><foo>bar></foo></xml>] }
      it "returns true" do
        expect(subject.valid_xml?).to be true
      end
    end
  end

end
