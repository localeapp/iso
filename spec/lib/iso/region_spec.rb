require 'spec_helper'

describe ISO::Region do
  let(:region) { ISO::Region.new('FR', name: 'France') }

  it "is a ISO Subtag" do
    region.should be_kind_of(ISO::Subtag)
  end

  it "has a code" do
    region.code.should == 'FR'
  end

  it "has a name" do
    region.name.should == 'France'
  end

  context 'un-m49 regions' do
    let(:afghanistan_region) { ISO::Region.new('004') }
    let(:africa_as_a_region) { ISO::Region.new('002') }

    it 'takes an un-m49 code and returns an instance' do
      afghanistan_region.should be_a(ISO::Region)
    end

    it 'replaces the un-m49 code with the country code' do
      afghanistan_region.code.should == 'AF'
    end

    it 'preserves the un-m49 code if it represents a region greater than a country' do
      africa_as_a_region.code.should == '002'
      africa_as_a_region.name.should == 'Africa'
    end
  end

  describe ".identify(full_code)" do
    it "identifies from 'fr-CH'" do
      ISO::Region.identify('fr-CH').should == ISO::Region.find('CH')
    end

    it "identifies from 'es_MX" do
      ISO::Region.identify('es_MX').should == ISO::Region.find('MX')
    end

    it "returns nil when it can't identify" do
      ISO::Region.identify('gsw').should be_nil
    end
  end
end
