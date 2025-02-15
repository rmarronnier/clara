require 'rails_helper'

describe HydrateAddress do

  before do
    _fake_is_zrr
    _fake_get_zip_city_region
  end
  describe ".call" do
    it "Raise an error if arg is not a asker attributes hash" do
      expect { HydrateAddress.new.call(//) }.to raise_error(ArgumentError)
    end
    it "Do not raise an error if arg is a asker attributes hash" do
      expect { HydrateAddress.new.call(Asker.new.attributes) }.not_to raise_error
    end
    it "Returns an asker" do
      subject = HydrateAddress.new.call(Asker.new.attributes) 
      expect(subject.is_a?(Asker)).to eq(true)
    end
    it "Returns an asker with same attributes if citycode is not here" do
      asker = Asker.new(v_location_zipcode: "59440")
      returned_asker = HydrateAddress.new.call(asker.attributes) 
      expect(returned_asker.attributes).to eq(asker.attributes)
    end
    it "Returns an asker with same attributes if zipcode is already here" do
      asker = Asker.new(v_location_citycode: "59035", v_location_zipcode: "59440")
      returned_asker = HydrateAddress.new.call(asker.attributes) 
      expect(returned_asker.attributes).to eq(asker.attributes)
    end
    it "Returns an asker with fulfilled geo attributes if citycode is here, but not zipcode" do
      asker = Asker.new(v_location_citycode: "59035")
      returned_asker = HydrateAddress.new.call(asker.attributes) 
      h = returned_asker.attributes
      expect(h["v_location_city"]).to eq("Avesnelles")
      expect(h["v_location_label"]).to eq("59440 Avesnelles")
      expect(h["v_location_state"]).to eq("Hauts-de-France (Nord-Pas-de-Calais)")
      expect(h["v_location_zipcode"]).to eq("59440")
      expect(h["v_zrr"]).to eq("oui")
    end
  end

  def _fake_is_zrr
    allow_any_instance_of(IsZrr).to receive(:call).and_return('oui')
  end

  def _fake_get_zip_city_region
    allow_any_instance_of(GetZipCityRegion).to receive(:call).and_return(['59440', 'Avesnelles', 'Hauts-de-France (Nord-Pas-de-Calais)'])
  end

end
