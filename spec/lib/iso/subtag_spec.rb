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
      ISO::Region.find('SY').should == ISO::Region.find('SY')
    end

    it "returns false when they have different codes" do
      ISO::Region.find('FR').should_not == ISO::Region.find('GB')
    end
  end

  describe "#name" do
    let(:fake_region)  { ISO::Subtag.new('FR', name: 'This is a lie') }
    let(:mars)  { ISO::Subtag.new('MRS') }

    it 'will accept a name option' do
      I18n.should_not_receive(:t)
      fake_region.name.should == 'This is a lie'
    end

    it 'falls back to the translation' do
      I18n.should_receive(:t).with('MRS', scope: 'vendor.iso').and_return('Mars')
      mars.name.should == 'Mars'
    end

  end

  describe "#full_name" do
    it "is composed of the code and the name" do
      full_name = Subtag.find('fr').full_name
      full_name.should match(/fr/)
      full_name.should match(/French/)
    end
  end

  describe ".all" do
    it "gets its definition from the DEFINITIONS_FILE" do
      subtags = Subtag.all
      subtags[0].should == Subtag.find('en')
      subtags[1].should == Subtag.find('fr')
      subtags[2].should == Subtag.find('de')
    end
  end

  describe ".find(code)" do
    it "finds a subtag by code" do
      subtag = Subtag.find('de')
      subtag.code.should == 'de'
      subtag.name.should == 'German'
    end

    it "returns nil when no language can be found" do
      Subtag.find('xxxx').should be_nil
    end
  end

  describe ".default" do
    it "finds from DEFAULT_CODE" do
      Subtag.default.should == Subtag.find('fr')
    end
  end

  describe ".codes" do
    it "returns an array of all codes" do
      Subtag.codes.should == %w(en fr de)
    end
  end
end
