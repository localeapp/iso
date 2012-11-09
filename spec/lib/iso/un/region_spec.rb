require 'spec_helper'

describe ISO::UN::Region do
  let(:has_iso) { ISO::UN::Region.find('004') }
  let(:no_iso)  { ISO::UN::Region.find('002') }

  describe "#iso_code" do
    it "returns the corresponding iso code" do
      has_iso.iso_code.should == 'AF'
    end

    it "returns nil when there is no corresponding iso code" do
      no_iso.iso_code.should be_nil
    end
  end

  describe "#name" do
    it "uses the correct scope when there is an iso code" do
      has_iso.name.should == 'Afghanistan'
    end

    it "uses the correct scope when there is no iso code" do
      no_iso.name.should == 'Africa'
    end
  end

  describe ".identify(full_code)" do
    it "identifies from 'es-419'" do
      region = ISO::UN::Region.identify('es-419')
      region.should_not be_nil
      region.should == ISO::UN::Region.find('419')
    end

    it "returns nil when it can't identify" do
      ISO::UN::Region.identify('gsw').should be_nil
    end
  end
end
