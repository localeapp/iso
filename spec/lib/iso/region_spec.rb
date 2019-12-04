require 'spec_helper'

describe ISO::Region do
  let(:region) { ISO::Region.new('FR', name: 'France') }

  it "is a ISO Subtag" do
    expect(region).to be_kind_of(ISO::Subtag)
  end

  it "has a code" do
    expect(region.code).to eq 'FR'
  end

  it "has a name" do
    expect(region.name).to eq 'France'
  end

  describe ".identify(full_code)" do
    it "identifies from 'fr-CH'" do
      expect(ISO::Region.identify('fr-CH')).to eq ISO::Region.find('CH')
    end

    it "identifies from 'es_MX" do
      expect(ISO::Region.identify('es_MX')).to eq ISO::Region.find('MX')
    end

    it "returns nil when it can't identify" do
      expect(ISO::Region.identify('gsw')).to be_nil
    end
  end
end
