require 'spec_helper'

describe ISO::Tag do
  describe ".new(code)" do
    it "returns a tag containing the language and region" do
      tag = ISO::Tag.new('en-MX')
      tag.language.code.should == 'en'
      tag.region.code.should   == 'MX'
    end

    it "returns a tag containing the language only" do
      tag = ISO::Tag.new('en-XXXXXX')
      tag.language.code.should == 'en'
      tag.region.should be_nil
    end

    it "returns a tag containing the region only" do
      tag = ISO::Tag.new('gsw-CH')
      tag.language.should be_nil
      tag.region.code.should == 'CH'
    end

    it "returns a tag containing no language or region" do
      tag = ISO::Tag.new('csb-XXXXXX')
      tag.language.should be_nil
      tag.region.should be_nil
    end
  end

  describe "#codes" do
    it "returns an array containing each subtag's code" do
      ISO::Tag.new('en-US').codes.should == %w(en US)
    end
  end

  describe "#subtags" do
    it "returns an array containing the language" do
      tag = ISO::Tag.new('fr')
      tag.subtags.size.should == 1
      tag.subtags.first.should be_kind_of(ISO::Language)
      tag.subtags.first.code.should == 'fr'
    end

    it "returns an array containing the language and the region" do
      tag = ISO::Tag.new('fr-CH')
      tag.subtags.size.should == 2

      tag.subtags.first.should be_kind_of(ISO::Language)
      tag.subtags.first.code.should == 'fr'

      tag.subtags.last.should be_kind_of(ISO::Region)
      tag.subtags.last.code.should == 'CH'
    end
  end

  describe "#valid?" do
    it "returns true when a valid language is supplied" do
      ISO::Tag.new('da').should be_valid
    end

    it "returns true when a valid language and region are supplied" do
      ISO::Tag.new('da-AT').should be_valid
    end

    it "returns false when no code is supplied" do
      ISO::Tag.new('').should_not be_valid
    end

    it "returns false when supplied language is invalid" do
      ISO::Tag.new('lol').should_not be_valid
    end

    it "returns false when supplied region is invalid" do
      ISO::Tag.new('en-lol').should_not be_valid
    end
  end
end
