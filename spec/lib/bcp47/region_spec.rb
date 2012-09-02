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
