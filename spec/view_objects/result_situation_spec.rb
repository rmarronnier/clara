require 'rails_helper'

describe ResultSituation do
  describe '.allocation_type' do
    it 'Should respond "ARE ASP" when category is ARE_ASP' do
      sut = ResultSituation.new(nil, {v_allocation_type: 'ARE_ASP'})
      expect(sut.allocation_type).to eq("ARE ASP")
    end
    it 'Should respond "ASS AER APS AS-FNE" when category is ASS_AER_APS_AS-FNE' do
      sut = ResultSituation.new(nil, {v_allocation_type: 'ASS_AER_APS_AS-FNE'})
      expect(sut.allocation_type).to eq("ASS AER APS AS-FNE")
    end
    it 'Should respond "RPS RFPA RFF ou pension de retraite" when category is RPS_RFPA_RFF_pensionretraite' do
      sut = ResultSituation.new(nil, {v_allocation_type: 'RPS_RFPA_RFF_pensionretraite'})
      expect(sut.allocation_type).to eq("RPS RFPA RFF ou pension de retraite")
    end
    it 'Should respond "RSA" when category is RSA' do
      sut = ResultSituation.new(nil, {v_allocation_type: 'RSA'})
      expect(sut.allocation_type).to eq("RSA")
    end
    it 'Should respond "AAH" when category is AAH' do
      sut = ResultSituation.new(nil, {v_allocation_type: 'AAH'})
      expect(sut.allocation_type).to eq("AAH")
    end
    it 'Should respond "aucune" when category is pas_indemnise' do
      sut = ResultSituation.new(nil, {v_allocation_type: 'pas_indemnise'})
      expect(sut.allocation_type).to eq("aucune")
    end
    it 'Should respond "indisponible" when category is unknown' do
      sut = ResultSituation.new(nil, {v_allocation_type: 'nothing_relevant'})
      expect(sut.allocation_type).to eq("indisponible")
    end
    it 'Should return a "indisponible" in the worst scenario' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.allocation_type).to eq("indisponible")
    end
  end
  describe '.diplome' do
    it 'Should respond "Bac +4 et +" when diplome is niveau_1' do
      sut = ResultSituation.new(nil, {v_diplome: 'niveau_1'})
      expect(sut.diplome).to eq("Bac +4 et +")
    end
    it 'Should respond "Bac +3" when diplome is niveau_2' do
      sut = ResultSituation.new(nil, {v_diplome: 'niveau_2'})
      expect(sut.diplome).to eq("Bac +3")
    end
    it 'Should respond "Bac +1 à +2" when diplome is niveau_3' do
      sut = ResultSituation.new(nil, {v_diplome: 'niveau_3'})
      expect(sut.diplome).to eq("Bac +1 à +2")
    end
    it 'Should respond "Bac" when diplome is niveau_4' do
      sut = ResultSituation.new(nil, {v_diplome: 'niveau_4'})
      expect(sut.diplome).to eq("Bac")
    end
    it 'Should respond "CAP BEP" when diplome is niveau_5' do
      sut = ResultSituation.new(nil, {v_diplome: 'niveau_5'})
      expect(sut.diplome).to eq("CAP BEP")
    end
    it 'Should respond "aucun" when diplome is niveau_infra_5' do
      sut = ResultSituation.new(nil, {v_diplome: 'niveau_infra_5'})
      expect(sut.diplome).to eq("aucun")
    end
    it 'Should respond "indisponible" when diplome is unknown' do
      sut = ResultSituation.new(nil, {asker: {v_diplome: 'nothing_relevant'}})
      expect(sut.diplome).to eq("indisponible")
    end
    it 'Should return a "indisponible" in the worst scenario' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.diplome).to eq("indisponible")
    end
  end
  describe '.category' do
    it 'Should respond "12345" when category is cat_12345' do
      sut = ResultSituation.new(nil, {v_category: 'cat_12345'})
      expect(sut.category).to eq("12345")
    end
    it 'Should respond "hors 12345" when category is autres_cat' do
      sut = ResultSituation.new(nil, {v_category: 'autres_cat'})
      expect(sut.category).to eq("hors 12345")
    end
    it 'Should respond "indisponible" when category is unknown' do
      sut = ResultSituation.new(nil, {v_category: 'nothing_relevant'})
      expect(sut.category).to eq("indisponible")
    end
    it 'Should return a "indisponible" in the worst scenario' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.category).to eq("indisponible")
    end
  end
  describe '.duree_d_inscription' do
    it 'Should respond "indisponible" when duree_d_inscription is nil' do
      sut = ResultSituation.new(nil, {v_duree_d_inscription: nil})
      expect(sut.duree_d_inscription).to eq("indisponible")
    end
    it 'Should respond "moins d\'un an" when duree_d_inscription is "moins_d_un_an"' do
      sut = ResultSituation.new(nil, {v_duree_d_inscription: "moins_d_un_an"})
      expect(sut.duree_d_inscription).to eq("moins d\'un an")
    end
    it 'Should respond "plus d\'un an" when duree_d_inscription is "plus_d_un_an"' do
      sut = ResultSituation.new(nil, {v_duree_d_inscription: "plus_d_un_an"})
      expect(sut.duree_d_inscription).to eq("plus d\'un an")
    end
    it 'Should respond "non inscrit" when duree_d_inscription is "non_inscrit"' do
      sut = ResultSituation.new(nil, {v_duree_d_inscription: "non_inscrit"})
      expect(sut.duree_d_inscription).to eq("non inscrit")
    end
  end

  describe '.age' do
    it 'Should respond exactly the same thing as the given age' do
      sut = ResultSituation.new(nil, {v_age: 'anything'})
      expect(sut.age).to eq("anything")
      sut = ResultSituation.new(nil, {v_age: 'any_other_thing'})
      expect(sut.age).to eq("any_other_thing")
    end
    it 'Should return "indisponible" in the worst scenario' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.age).to eq("indisponible")
    end
  end
  describe '.zrr' do
    it 'Should respond "oui" when given String is "oui"' do
      sut = ResultSituation.new(nil, {v_zrr: 'oui'})
      expect(sut.zrr).to eq("oui")
    end
    it 'Should respond "non" when given data is sth else than "true"' do
      sut = ResultSituation.new(nil, {v_zrr: 'rerere'})
      expect(sut.zrr).to eq("non")
      sut = ResultSituation.new(nil, {v_zrr: Date.new})
      expect(sut.zrr).to eq("non")
    end
    it 'Should return "indisponible" when data is not available' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.zrr).to eq("indisponible")
    end
  end
  describe '.handicap' do
    it 'Should respond "oui" when given String is "oui"' do
      sut = ResultSituation.new(nil, {v_handicap: 'oui'})
      expect(sut.handicap).to eq("oui")
    end
    it 'Should respond "non" when given data is sth else than "true"' do
      sut = ResultSituation.new(nil, {v_handicap: 'rerere'})
      expect(sut.handicap).to eq("non")
      sut = ResultSituation.new(nil, {v_handicap: Date.new})
      expect(sut.handicap).to eq("non")
    end
    it 'Should return "indisponible" when data is not available' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.handicap).to eq("indisponible")
    end
  end
  describe '.spectacle' do
    it 'Should respond "oui" when given String is "oui"' do
      sut = ResultSituation.new(nil, {v_spectacle: 'oui'})
      expect(sut.spectacle).to eq("oui")
    end
    it 'Should respond "non" when given data is sth else than "true"' do
      sut = ResultSituation.new(nil, {v_spectacle: 'rerere'})
      expect(sut.spectacle).to eq("non")
      sut = ResultSituation.new(nil, {v_spectacle: Date.new})
      expect(sut.spectacle).to eq("non")
    end
    it 'Should return "indisponible" when data is not available' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.handicap).to eq("indisponible")
    end
  end
  describe '.allocation_value_min' do
    it 'Should respond exactly the same thing as the given allocation_value_min' do
      sut = ResultSituation.new(nil, {v_allocation_value_min: 'anything'})
      expect(sut.allocation_value_min).to eq("anything")
      sut = ResultSituation.new(nil, {v_allocation_value_min: 'any_other_thing'})
      expect(sut.allocation_value_min).to eq("any_other_thing")
    end
    it 'Should return "indisponible" in the worst scenario' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.allocation_value_min).to eq("indisponible")
    end
  end
  describe '.location_label' do
    it 'Should respond exactly the same thing as the given location_label' do
      sut = ResultSituation.new(nil, {v_location_label: 'anything'})
      expect(sut.location_label).to eq("anything")
      sut = ResultSituation.new(nil, {v_location_label: 'any_other_thing'})
      expect(sut.location_label).to eq("any_other_thing")
    end
    it 'Should return "indisponible" in the worst scenario' do
      sut = ResultSituation.new(nil, nil)
      expect(sut.location_label).to eq("Non renseignée")
    end
  end
end
