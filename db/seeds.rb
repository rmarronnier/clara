variable_list = [
  {name: "v_age", variable_kind: "integer", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_duree_d_inscription", variable_kind: "selectionnable", description: nil, elements: "plus_d_un_an,moins_d_un_an,non_inscrit", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_category", variable_kind: "selectionnable", description: nil, elements: "cat_12345,autres_cat", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_diplome", variable_kind: "selectionnable", description: nil, elements: "niveau_1,niveau_2,niveau_3,niveau_4,niveau_5,niveau_infra_5", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_allocation_value_min", variable_kind: "integer", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_qpv", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_handicap", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_autres", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_protection_internationale", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_detenu", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_harki", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_location_city", variable_kind: "string", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_location_citycode", variable_kind: "string", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_location_country", variable_kind: "string", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_location_route", variable_kind: "string", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_location_state", variable_kind: "string", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_location_zipcode", variable_kind: "string", description: nil, elements: nil, name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_spectacle", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_allocation_type", variable_kind: "selectionnable", description: nil, elements: "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_zrr", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_cadre", variable_kind: "selectionnable", description: nil, elements: "oui,non", name_translation: nil, elements_translation: nil, is_visible: true},
  {name: "v_location_label", variable_kind: "string", description: "", elements: "", name_translation: "", elements_translation: "", is_visible: false},
  {name: "v_location_street_number", variable_kind: "string", description: "", elements: "", name_translation: "", elements_translation: "", is_visible: false},
]

existing_variables = Variable.all.map(&:name)

named_variables = Variable.all.group_by(&:name).transform_values{|e| e[0]}

variable_list.each do |variable_attr|
  unless named_variables.keys.include?(variable_attr[:name])
    Variable.create!(variable_attr)
  end
end


explicitation_list = [
  ["e_age_more_than", 
      named_variables["v_age"], 
      :more_than, 
      nil, 
      "Être âgé de XX ans ou plus"],
  ["e_age_equal", 
      named_variables["v_age"], 
      :equal, 
      nil, 
      "Être âgé de XX ans"],
  ["e_allocation_type_equal_ass", 
      named_variables["v_allocation_type"], 
      :equal, 
      "ASS_AER_APS_AS-FNE", 
      "Être bénéficiaire de l'ASS, l'AER, l'APS, ou l'AS-FNE"],
  ["e_allocation_type_equal_pas_indemnise", 
    named_variables["v_allocation_type"],  
    :equal, 
    "pas_indemnise", 
    "Ne recevoir aucune allocation"],
]
existing_explicitations = Explicitation.all.map(&:name)

explicitation_list.each do |name_arg, variable_arg, operator_kind_arg, value_eligible_arg, template_arg|
  unless existing_explicitations.include?(name_arg)
    Explicitation.create!(
      name: name_arg, 
      variable: variable_arg, 
      operator_kind: operator_kind_arg, 
      value_eligible: value_eligible_arg, 
      template: template_arg
    )
  end
end


