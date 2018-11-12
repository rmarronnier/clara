class CustomFilter < ApplicationRecord 
  extend FriendlyId


  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  belongs_to :custom_parent_filter


  def should_generate_new_friendly_id?
    name_changed?
  end

end
