class CreateJoinTableNeedFilterAid < ActiveRecord::Migration[5.2]
  def change
    create_join_table :need_filters, :aids
  end
end
