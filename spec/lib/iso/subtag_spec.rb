require 'spec_helper'

class Subtag < ISO::Subtag
  DEFINITIONS_FILE = "spec/fixtures/base.yml"
  DEFAULT_CODE     = "fr"
private
  def i18n_scope
    super << ".languages"
  end
end

describe ISO::Subtag do
  describe "#==(object)" do
    it "returns true when both have the same code" do
      expect(ISO::Region.find('SY')).to eq ISO::Region.find('SY')
    end

    it "returns false when they have different codes" do
      expect(ISO::Region.find('FR')).to_not eq ISO::Region.find('GB')
    end
  end

  describe "#name" do
    let(:fake_region)  { ISO::Subtag.new('FR', name: 'This is a lie') }
    let(:mars)  { ISO::Subtag.new('MRS') }

    it 'will accept a name option' do
      expect(I18n).to_not receive(:t)
      expect(fake_region.name).to eq 'This is a lie'
    end

    it 'falls back to the translation' do
      expect(I18n).to receive(:t).with('MRS', scope: 'vendor.iso').and_return('Mars')
      expect(mars.name).to eq 'Mars'
    end

  end

  describe "#full_name" do
    it "is composed of the code and the name" do
      full_name = Subtag.find('fr').full_name
      expect(full_name).to match(/fr/)
      expect(full_name).to match(/French/)
    end
  end

  describe ".all" do
    it "gets its definition from the DEFINITIONS_FILE" do
      subtags = Subtag.all
      expect(subtags[0]).to eq Subtag.find('en')
      expect(subtags[1]).to eq Subtag.find('fr')
      expect(subtags[2]).to eq Subtag.find('de')
    end
  end

  describe ".find(code)" do
    it "finds a subtag by code" do
      subtag = Subtag.find('de')
      expect(subtag.code).to eq 'de'
      expect(subtag.name).to eq 'German'
    end

    it "returns nil when no language can be found" do
      expect(Subtag.find('xxxx')).to be_nil
    end
  end

  describe ".default" do
    it "finds from DEFAULT_CODE" do
      expect(Subtag.default).to eq Subtag.find('fr')
    end
  end

  describe ".codes" do
    it "returns an array of all codes" do
      expect(Subtag.codes).to eq %w(en fr de)
    end
  end
end
