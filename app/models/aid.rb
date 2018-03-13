class Aid < ApplicationRecord
  extend FriendlyId  

  has_paper_trail ignore: [:updated_at]
  
  friendly_id :name, use: :slugged
  belongs_to :rule, optional: true
  belongs_to :contract_type, optional: true

  validates :name, presence: true, uniqueness: true  

  scope :unarchived, -> { where(archived_at: nil) }
  scope :linked_to_rule, -> { where.not(rule_id: nil) }
  scope :activated,  -> { self.unarchived.linked_to_rule }
  scope :ordered_by_creation, -> { order(created_at: :asc) }
  
  def should_generate_new_friendly_id?
    name_changed?
  end

end
