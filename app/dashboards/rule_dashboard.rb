require "administrate/base_dashboard"

class RuleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    kind:             HiddenField,
    slave_rules:      Field::HasMany.with_options(class_name: "Rule"),
    variable:         WithVariableField,
    aids:             Field::HasMany,
    id:               Field::Number,
    name:             Field::String,
    simulated:        Field::String,
    description:      Field::Text,
    value_eligible:   RuleValueField,
    value_ineligible: Field::String,
    operator_kind:    EnumField,
    composition_type: EnumField,
    created_at:       Field::DateTime,
    updated_at:       Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :simulated,
    :variable,
    :aids,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :description,
    :simulated,
    :kind,
    :aids,
    :created_at,
    :updated_at,
    :slave_rules,
    :composition_type,
    :variable,
    :operator_kind,
    :value_eligible,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :kind,
    :description,
    :variable,
    :operator_kind,
    :value_eligible,
    :value_ineligible,
    :slave_rules,
    :composition_type,
    :aids,
  ].freeze

  # Overwrite this method to customize how rules are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(rule)
    "#{rule.name}"
  end
end
