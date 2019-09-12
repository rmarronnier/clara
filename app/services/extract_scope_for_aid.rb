class ExtractScopeForAid

  def call(aid)
    res = {}

    if aid.is_a?(Aid) && aid.rule
      res = _fill(aid.rule)
    end

    return res
  end

  def _fill(rule)
    h = {}
    h[:name] = rule.name
    if h[:name].include?("root_box")
      h[:name] = "root_box" 
    else
      h[:name] = "box_" + h[:name].split("box_")[1]
    end

    h[:subcombination] = rule.composition_type == "and_rule" ? "AND" : rule.composition_type == "or_rule" ? "OR" : ""
    h[:xvar] = rule.variable.try(:name)
    h[:xop] = rule.operator_kind
    h[:xval] = rule.value_eligible
    h[:subboxes] = []
    h[:is_editing] = false

    rule.slave_rules.each_with_index do |subrule, i|
      h[:subboxes].push(_fill(subrule))
    end
    h
  end

end



# {
#               "name" => "root_box",
#     "subcombination" => "AND",
#           "subboxes" => [
#         {
#                       "name" => "box_1568038992875",
#             "subcombination" => "",
#                   "subboxes" => [],
#                       "xval" => "cat_12345",
#                        "xop" => "equal",
#                       "xvar" => "v_category",
#                       "xtxt" => "Être en catégorie 1, 2, 3, 4 ou 5",
#                 "is_editing" => false
#         },
#         {
#                       "name" => "box_1568038997729",
#             "subcombination" => "OR",
#                   "subboxes" => [
#                  {
#                               "name" => "box_1568039005966b",
#                     "subcombination" => "",
#                           "subboxes" => [],
#                               "xval" => "42",
#                                "xop" => "less_than",
#                               "xvar" => "v_age",
#                               "xtxt" => "Avoir un âge strictement inférieur à 42 ans",
#                         "is_editing" => false
#                 },
#                 {
#                               "name" => "box_1568039005966a",
#                     "subcombination" => "",
#                           "subboxes" => [],
#                               "xval" => "plus_d_un_an",
#                                "xop" => "equal",
#                               "xvar" => "v_duree_d_inscription",
#                               "xtxt" => "Être inscrit depuis plus d'un an à Pôle Emploi",
#                         "is_editing" => false
#                 }
#             ],
#                       "xval" => "",
#                        "xop" => "",
#                       "xvar" => "",
#                       "xtxt" => "",
#                 "is_editing" => false
#         }
#     ]
# }
