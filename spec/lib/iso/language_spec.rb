require 'spec_helper'

describe ISO::Language do
  let(:language) { ISO::Language.new('de', name: 'German') }

  it "is a ISO Subtag" do
    language.should be_kind_of(ISO::Subtag)
  end

  it "has a code" do
    language.code.should == 'de'
  end

  it "has a name" do
    language.name.should == 'German'
  end

  describe "#plural_rule_names" do
    it "defaults to %w(one other)" do
      language.plural_rule_names.should == ISO::Language::DEFAULT_PLURAL_RULE_NAMES
    end

    it "is overwriteable" do
      language = ISO::Language.new('ja', plural_rule_names: ['other'])
      language.plural_rule_names.should == ['other']
    end
  end

  describe "#direction" do
    it "defaults to 'ltr'" do
      language.direction.should == 'ltr'
    end

    it "is overwriteable" do
      language = ISO::Language.new('ar', direction: :rtl)
      language.direction.should == :rtl
    end
  end

  describe ".identify(full_code)" do
    it "identifies from 'de'" do
      ISO::Language.identify('de').should == ISO::Language.new('de')
    end

    it "identifies from 'fr-CH'" do
      ISO::Language.identify('fr-CH').should == ISO::Language.new('fr')
    end

    it "returns nil when it can't identify" do
      ISO::Language.identify('csb').should be_nil
    end
  end
end
