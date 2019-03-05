# create_table "rules", id: :serial, force: :cascade do |t|
#   t.string "name"
#   t.string "value_eligible"
#   t.integer "composition_type"
#   t.integer "variable_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.text "description"
#   t.string "value_ineligible"
#   t.string "kind"
#   t.string "operator_kind"
#   t.index ["variable_id"], name: "index_rules_on_variable_id"
# end
class Rule < ApplicationRecord
  include Prefixable

  enum operator_kind: ListOperatorKind.new.call

  after_save    { ExpireCacheJob.perform_later }
  after_update  { ExpireCacheJob.perform_later }
  after_destroy { ExpireCacheJob.perform_later }
  after_create  { ExpireCacheJob.perform_later }

  has_paper_trail ignore: [:updated_at]

  enum composition_type: [:and_rule, :or_rule]

  has_many :compound_rules, dependent: :delete_all
  has_many :slave_rules, through: :compound_rules
  belongs_to :variable, optional: true

  has_many :aids
  has_many :contract_type
  has_many :custom_rule_checks, dependent: :delete_all


  validates :name, uniqueness: true
  validates_with RuleValidator

  def tested
    {
      status: "ok"
    }
  end

end
