require 'spec_helper'

describe ISO::UN::Region do
  let(:has_iso) { ISO::UN::Region.find('004') }
  let(:no_iso)  { ISO::UN::Region.find('002') }

  describe "#iso_code" do
    it "returns the corresponding iso code" do
      expect(has_iso.iso_code).to eq 'AF'
    end

    it "returns nil when there is no corresponding iso code" do
      expect(no_iso.iso_code).to be_nil
    end
  end

  describe "#name" do
    it "uses the correct scope when there is an iso code" do
      expect(has_iso.name).to eq 'Afghanistan'
    end

    it "uses the correct scope when there is no iso code" do
      expect(no_iso.name).to eq 'Africa'
    end
  end

  describe ".identify(full_code)" do
    it "identifies from 'es-419'" do
      region = ISO::UN::Region.identify('es-419')
      expect(region).to_not be_nil
      expect(region).to eq ISO::UN::Region.find('419')
    end

    it "returns nil when it can't identify" do
      expect(ISO::UN::Region.identify('gsw')).to be_nil
    end
  end
end
