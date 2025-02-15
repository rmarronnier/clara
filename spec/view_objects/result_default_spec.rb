require 'rails_helper'

describe ResultDefault do

  describe '.sort_and_order_eligies' do
    
    it 'Cannot sort unexisting prop' do
      sut = ResultDefault.new(nil, nominal_data)
      res = sut.sort_and_order("unexisting_prop")
      expect(res).to eq([])
    end

    it 'Can sort "flat_all_eligible"' do
      sut = ResultDefault.new(nil, nominal_data)
      res = sut.sort_and_order("flat_all_eligible")
      expect(res).not_to eq([])
    end

    it 'Can sort "flat_all_ineligible"' do
      sut = ResultDefault.new(nil, nominal_data)
      res = sut.sort_and_order("flat_all_ineligible")
      expect(res).not_to eq([])
    end

    it 'Can sort "flat_all_uncertain"' do
      sut = ResultDefault.new(nil, nominal_data)
      res = sut.sort_and_order("flat_all_uncertain")
      expect(res).not_to eq([])
    end


    it 'Sort aids along "ordre_affichage" property' do
      sut = ResultDefault.new(nil, nominal_data)
      res = sut.sort_and_order("flat_all_eligible")
      expect(res).to eq(
        [
          [{"id"=>6,
            "name"=>"Aides aux bénéficiaires du RSA, ou adultes",
            "slug"=>"aides-aux-beneficiaires-du-rsa-ou-adultes",
            "short_description"=>"",
            "ordre_affichage"=>4,
            "contract_type_id"=>2,
            "filters"=>[{"id"=>1}, {"id"=>3}],
            "eligibility"=>"eligible"},
            {"id"=>4,
            "name"=>"Aides aux habitants en QPV ou adultes",
            "slug"=>"aides-aux-habitants-en-qpv-ou-adultes",
            "short_description"=>"",
            "ordre_affichage"=>5,
            "contract_type_id"=>2,
            "filters"=>[{"id"=>1}, {"id"=>2}],
            "eligibility"=>"eligible"},
           ]
        ]
      )
    end

    it 'Sort contract_type key along to the "ordre_affichage" property of contract_type' do
      sut = ResultDefault.new(nil, nominal_data)
      res = sut.sort_and_order("flat_all_uncertain")
      expect(res).to eq([
        
          [{"id"=>3,
            "name"=>"Aide aux habitants en QPV adultes",
            "slug"=>"aide-aux-habitants-en-qpv-adultes",
            "short_description"=>"",
            "ordre_affichage"=>3,
            "contract_type_id"=>2,
            "filters"=>[{"id"=>2}, {"id"=>1}, {"id"=>4}],
            "eligibility"=>"uncertain"}],

          [{"id"=>2,
            "name"=>"Aide aux habitants en zone QPV",
            "slug"=>"aide-aux-habitants-en-zone-qpv",
            "short_description"=>"",
            "ordre_affichage"=>1,
            "contract_type_id"=>1,
            "filters"=>[{"id"=>2}],
            "eligibility"=>"uncertain"}],
        
        ])     
    end

    it 'Evict entries without contract_type' do
      sut = ResultDefault.new(nil, nominal_data)
      res = sut.sort_and_order("flat_all_ineligible")
      expect(res).to eq([
        
        [{"id"=>7,
         "name"=>"Aides aux bénéficiaires du RSA et adultes",
         "slug"=>"aides-aux-beneficiaires-du-rsa-et-adultes",
         "short_description"=>"",
         "ordre_affichage"=>99,
         "contract_type_id"=>2,
         "filters"=>[{"id"=>1}, {"id"=>3}],
         "eligibility"=>"ineligible"}],
       [{"id"=>1,
         "name"=>"Aide au bénéficiaire du RSA",
         "slug"=>"aide-au-beneficiaire-du-rsa",
         "short_description"=>"",
         "ordre_affichage"=>2,
         "contract_type_id"=>1,
         "filters"=>[{"id"=>3}],
         "eligibility"=>"ineligible"}]
        
        ])     
    end

    it 'Accepts empty ordre_affichage' do
      missing_ordre_affichage = nominal_data
      missing_ordre_affichage[:flat_all_eligible][1]["ordre_affichage"] = nil
      sut = ResultDefault.new(nil, missing_ordre_affichage)
      res = sut.sort_and_order("flat_all_eligible")
      expect(res).to eq(
        [
          [
            {"id"=>6,
            "name"=>"Aides aux bénéficiaires du RSA, ou adultes",
            "slug"=>"aides-aux-beneficiaires-du-rsa-ou-adultes",
            "short_description"=>"",
            "ordre_affichage"=>nil,
            "contract_type_id"=>2,
            "filters"=>[{"id"=>1}, {"id"=>3}],
            "eligibility"=>"eligible"},
            {"id"=>4,
            "name"=>"Aides aux habitants en QPV ou adultes",
            "slug"=>"aides-aux-habitants-en-qpv-ou-adultes",
            "short_description"=>"",
            "ordre_affichage"=>5,
            "contract_type_id"=>2,
            "filters"=>[{"id"=>1}, {"id"=>2}],
            "eligibility"=>"eligible"
            }
          ]
        ]
      )   
    end

  end


  describe ".displayed_filters" do
    it "renders filters that has ordre_affichage" do
      # given
      init_filters = nominal_data[:flat_all_filter]
      expect(init_filters.size).to eq(5)
      # when
      displayed_filters = ResultDefault.new(nil, nominal_data).displayed_filters
      # then
      expect(displayed_filters.size).to eq(4)
    end

    it "order filters according to ordre_affichage" do
      # given
      init_filters = nominal_data[:flat_all_filter]
      expect(ordre_affichage_of(init_filters)).not_to be_a_growing_suite
      # when
      displayed_filters = ResultDefault.new(nil, nominal_data).displayed_filters
      # then
      expect(ordre_affichage_of(displayed_filters)).to be_a_growing_suite
    end

    def ordre_affichage_of(stuff)
      stuff.map { |e| e["ordre_affichage"] }
    end

  end

  def nominal_data
    {:flat_all_eligible=>
  [{"id"=>4,
    "name"=>"Aides aux habitants en QPV ou adultes",
    "slug"=>"aides-aux-habitants-en-qpv-ou-adultes",
    "short_description"=>"",
    "ordre_affichage"=>5,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>1}, {"id"=>2}],
    "eligibility"=>"eligible"},
   {"id"=>6,
    "name"=>"Aides aux bénéficiaires du RSA, ou adultes",
    "slug"=>"aides-aux-beneficiaires-du-rsa-ou-adultes",
    "short_description"=>"",
    "ordre_affichage"=>4,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>1}, {"id"=>3}],
    "eligibility"=>"eligible"}],
 :flat_all_uncertain=>
  [{"id"=>2,
    "name"=>"Aide aux habitants en zone QPV",
    "slug"=>"aide-aux-habitants-en-zone-qpv",
    "short_description"=>"",
    "ordre_affichage"=>1,
    "contract_type_id"=>1,
    "filters"=>[{"id"=>2}],
    "eligibility"=>"uncertain"},
   {"id"=>3,
    "name"=>"Aide aux habitants en QPV adultes",
    "slug"=>"aide-aux-habitants-en-qpv-adultes",
    "short_description"=>"",
    "ordre_affichage"=>3,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>2}, {"id"=>1}, {"id"=>4}],
    "eligibility"=>"uncertain"}],
 :flat_all_ineligible=>
  [{"id"=>1,
    "name"=>"Aide au bénéficiaire du RSA",
    "slug"=>"aide-au-beneficiaire-du-rsa",
    "short_description"=>"",
    "ordre_affichage"=>2,
    "contract_type_id"=>1,
    "filters"=>[{"id"=>3}],
    "eligibility"=>"ineligible"},
   {"id"=>7,
    "name"=>"Aides aux bénéficiaires du RSA et adultes",
    "slug"=>"aides-aux-beneficiaires-du-rsa-et-adultes",
    "short_description"=>"",
    "ordre_affichage"=>99,
    "contract_type_id"=>2,
    "filters"=>[{"id"=>1}, {"id"=>3}],
    "eligibility"=>"ineligible"},
  {"id"=>17,
    "name"=>"Missing contract_type",
    "slug"=>"missing-contract-type",
    "short_description"=>"",
    "ordre_affichage"=>12,
    "filters"=>[{"id"=>1}, {"id"=>3}],
    "eligibility"=>"ineligible"}],
 :flat_all_contract=>
  [{"id"=>1,
    "name"=>"Aide simple",
    "description"=>"Un aide simple, sans règle composite",
    "ordre_affichage"=>50,
    "icon"=>"",
    "slug"=>"aide-simple",
    "category"=>"simple",
    },
   {"id"=>2,
    "name"=>"Aide composite",
    "description"=>"Des aides consitituées de règles complexes",
    "ordre_affichage"=>10,
    "icon"=>"",
    "slug"=>"aide-composite",
    "category"=>"composite",
    }],
 :flat_all_filter=>
  [{"id"=>1, "ordre_affichage" => 13, "name"=>"adulte", "description"=>"Ne concerne que les adultes"},
   {"id"=>2, "ordre_affichage" => 2, "name"=>"argent", "description"=>"Les aides liées à l'argent"},
   {"id"=>3, "ordre_affichage" => 38,
    "name"=>"zône prioritaire",
    "description"=>
     "Je cherche une aide car je suis en zone prioritaire d'habitation"},
   {"id"=>4, "ordre_affichage" => 4,
    "name"=>"special",
    "description"=>"Filtre marqué \"spécial\"..."},
   {"id"=>5,
    "name"=>"sansordreaffichage",
    "description"=>"Na pas l'ordre d'affichage"}],
 :asker=>
  {"v_handicap"=>"oui",
   "v_spectacle"=>"non",
   "v_diplome"=>"niveau_3",
   "v_category"=>"cat_12345",
   "v_duree_d_inscription"=>"plus_d_un_an",
   "v_allocation_value_min"=>"424",
   "v_allocation_type"=>"ASS_AER_APS_AS-FNE",
   "v_qpv"=>nil,
   "v_zrr"=>nil,
   "v_age"=>"22",
   "v_location_label"=>nil,
   "v_location_route"=>nil,
   "v_location_city"=>nil,
   "v_location_country"=>nil,
   "v_location_zipcode"=>nil,
   "v_location_citycode"=>nil,
   "v_location_street_number"=>nil,
   "v_location_state"=>nil}}
  end

end
