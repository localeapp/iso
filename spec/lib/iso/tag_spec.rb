require 'spec_helper'

describe ISO::Tag do
  describe ".new(code)" do
    it "returns a tag containing the language and region" do
      tag = ISO::Tag.new('en-MX')
      expect(tag.language.code).to eq 'en'
      expect(tag.region.code).to eq 'MX'
    end

    it "returns a tag containing the language and UN region" do
      tag = ISO::Tag.new('en-419')
      expect(tag.language.code).to eq 'en'
      expect(tag.region.code).to eq '419'
    end

    it "returns a tag containing the language only" do
      tag = ISO::Tag.new('en-XXXXXX')
      expect(tag.language.code).to eq 'en'
      expect(tag.region).to be_nil
    end

    it "returns a tag containing the region only" do
      tag = ISO::Tag.new('gsw-CH')
      expect(tag.language).to be_nil
      expect(tag.region.code).to eq 'CH'
    end

    it "returns a tag containing the UN region only" do
      tag = ISO::Tag.new('gsw-419')
      expect(tag.language).to be_nil
      expect(tag.region.code).to eq '419'
    end

    it "returns a tag containing no language or region" do
      tag = ISO::Tag.new('csb-XXXXXX')
      expect(tag.language).to be_nil
      expect(tag.region).to be_nil
    end
  end

  describe "#codes" do
    it "returns an array containing each subtag's code" do
      expect(ISO::Tag.new('en-US').codes).to eq %w(en US)
    end
  end

  describe "#subtags" do
    it "returns an array containing the language" do
      tag = ISO::Tag.new('fr')
      expect(tag.subtags.size).to eq 1
      expect(tag.subtags.first).to be_kind_of(ISO::Language)
      expect(tag.subtags.first.code).to eq 'fr'
    end

    it "returns an array containing the language and the region" do
      tag = ISO::Tag.new('fr-CH')
      expect(tag.subtags.size).to eq 2

      expect(tag.subtags.first).to be_kind_of(ISO::Language)
      expect(tag.subtags.first.code).to eq 'fr'

      expect(tag.subtags.last).to be_kind_of(ISO::Region)
      expect(tag.subtags.last.code).to eq 'CH'
    end
  end

  describe "#valid?" do
    it "returns true when a valid language is supplied" do
      expect(ISO::Tag.new('da')).to be_valid
    end

    it "returns true when a valid language and region are supplied" do
      expect(ISO::Tag.new('da-AT')).to be_valid
    end

    it "returns true when a valid language an UN region are supplied" do
      expect(ISO::Tag.new('es-419')).to be_valid
    end

    it "returns false when no code is supplied" do
      expect(ISO::Tag.new('')).to_not be_valid
    end

    it "returns false when supplied language is invalid" do
      expect(ISO::Tag.new('lol')).to_not be_valid
    end

    it "returns false when supplied region is invalid" do
      expect(ISO::Tag.new('en-lol')).to_not be_valid
    end

  end
end
