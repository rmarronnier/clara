variable_list = [
  {name: "v_age",                       
    variable_kind: "integer", 
    description: nil, 
    elements: nil,
    name_translation: "âge", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_duree_d_inscription",       
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "plus_d_un_an,moins_d_un_an,non_inscrit",
    name_translation: "durée d'inscription", 
    elements_translation: "plus d'un an, moins d'un an, non inscrit", 
    is_visible: true},
  {name: "v_category",                  
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "cat_12345,autres_cat",
    name_translation: "catégorie", 
    elements_translation: "1 à 5, autres catégories", 
    is_visible: true},
  {name: "v_diplome",                   
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "niveau_1,niveau_2,niveau_3,niveau_4,niveau_5,niveau_infra_5",
    name_translation: "diplôme", 
    elements_translation: "bac +4 et +, bac +3, bac +1 et +2 (BTS/DUT), Bac, CAP/BEP, aucun diplôme", 
    is_visible: true},
  {name: "v_allocation_value_min",      
    variable_kind: "integer", 
    description: nil, 
    elements: nil,
    name_translation: "montant minimum d'allocation", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_qpv",                       
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est en QPV", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_handicap",                  
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est en situation de handicap", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_autres",                    
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est dans situation autre que cadre, handicap, artiste", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_protection_internationale", 
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est bénéficiaire d'une protection internationale", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_detenu",                    
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est détenu ou ancien détenu", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_harki",                     
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est descendant de harki", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_city",             
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : nom de la ville", 
    elements_translation: nil, 
    is_visible: false},
  {name: "v_location_citycode",         
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : code INSEE de la ville", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_country",          
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : pays", 
    elements_translation: nil, 
    is_visible: false},
  {name: "v_location_route",            
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : nom de la rue", 
    elements_translation: nil, 
    is_visible: false},
  {name: "v_location_state",            
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : région", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_zipcode",          
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : code postal", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_spectacle",                 
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est intermittent du spectacle", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_allocation_type",           
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise",
    name_translation: "type d'allocation", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_zrr",                       
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est en ZRR", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_cadre",                     
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est un cadre", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_label",            
    variable_kind: "string", 
    description: "",
    elements: "",
    name_translation: "est un cadre", 
    elements_translation: "",
    is_visible: false},
  {name: "v_location_street_number",    
    variable_kind: "string", 
    description: "",
    elements: "",
    name_translation: "geo : numéro de voie", 
    elements_translation: "",
    is_visible: false},
]

# First time creation
named_variables = Variable.all.group_by(&:name).transform_values{|e| e[0]}

variable_list.each do |v_attributes|
  v_name = v_attributes[:name]
  unless named_variables.keys.include?(v_name)
    named_variables[v_name] = Variable.create!(v_attributes)
  end
end

explicitation_list = [
  ["v_duree_d_inscription", 
      :equal, 
      "non_inscrit", 
      "Ne pas être inscrit à Pôle Emploi"],
  ["v_duree_d_inscription", 
      :equal, 
      "moins_d_un_an", 
      "Être inscrit depuis moins d'un an à Pôle Emploi"],
  ["v_duree_d_inscription", 
      :equal, 
      "plus_d_un_an", 
      "Être inscrit depuis plus d'un an à Pôle Emploi"],
  ["v_category", 
      :equal, 
      "cat_12345", 
      "Être en catégorie 1, 2, 3, 4 ou 5"],
  ["v_category", 
      :equal, 
      "autres_cat", 
      "Être en catégorie autre que 1, 2, 3, 4 ou 5"],
  ["v_allocation_type", 
      :equal, 
      "ARE_ASP", 
      "Être bénéficiaire de l'ARE ou de l'ASP"],
  ["v_allocation_type", 
      :equal, 
      "ASS_AER_APS_AS-FNE", 
      "Être bénéficiaire de l'ASS, l'AER, l'APS, ou l'AS-FNE"],
  ["v_allocation_type", 
      :equal, 
      "radio_RPS_RFPA_RFF_pensionretraite", 
      "Être bénéficiaire du RPS, du RFPA, du RFF, ou percevoir une pension de retraite"],
  ["v_allocation_type", 
      :equal, 
      "RSA", 
      "Être bénéficiaire du RSA"],
  ["v_allocation_type", 
      :equal, 
      "AAH", 
      "Être bénéficiaire de l'AAH"],
  ["v_allocation_type",
    :equal, 
    "pas_indemnise", 
    "Ne recevoir aucune allocation"],
  ["v_age", 
      :more_than, 
      nil, 
      "Être âgé de XX ans ou plus"],
  ["v_age", 
      :equal, 
      nil, 
      "Être âgé de XX ans"],
]

explicitation_list.each do |variable_name_arg, operator_kind_arg, value_eligible_arg, template_arg|
  name = "e_" + variable_name_arg + "_" + operator_kind_arg.to_s + "_" + value_eligible_arg.to_s
  unless Explicitation.find_by(name: name)
    Explicitation.create!(
      name: name,
      variable: named_variables[variable_name_arg], 
      operator_kind: operator_kind_arg, 
      value_eligible: value_eligible_arg, 
      template: template_arg
    )
  end
end


