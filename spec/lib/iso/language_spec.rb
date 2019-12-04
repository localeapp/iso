require 'spec_helper'

describe ISO::Language do
  let(:language) { ISO::Language.new('de', name: 'German') }

  it "is a ISO Subtag" do
    expect(language).to be_kind_of(ISO::Subtag)
  end

  it "has a code" do
    expect(language.code).to eq 'de'
  end

  it "has a name" do
    expect(language.name).to eq 'German'
  end

  describe "#plural_rule_names" do
    it "defaults to %w(one other)" do
      expect(language.plural_rule_names).to eq ISO::Language::DEFAULT_PLURAL_RULE_NAMES
    end

    it "is overwriteable" do
      language = ISO::Language.new('ja', plural_rule_names: ['other'])
      expect(language.plural_rule_names).to eq ['other']
    end
  end

  describe "#direction" do
    it "defaults to 'ltr'" do
      expect(language.direction).to eq 'ltr'
    end

    it "is overwriteable" do
      language = ISO::Language.new('ar', direction: :rtl)
      expect(language.direction).to eq :rtl
    end
  end

  describe ".identify(full_code)" do
    it "identifies from 'de'" do
      expect(ISO::Language.identify('de')).to eq ISO::Language.new('de')
    end

    it "identifies from 'fr-CH'" do
      expect(ISO::Language.identify('fr-CH')).to eq ISO::Language.new('fr')
    end

    it "returns nil when it can't identify" do
      expect(ISO::Language.identify('csb')).to be_nil
    end
  end
end
