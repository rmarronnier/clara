class AddPublicationStatusToAids < ActiveRecord::Migration[5.1]
  def change
    add_column :aids, :status, :string, :default => "drafted"
  end
end
