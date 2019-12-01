class AddColumnCategoryIdToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :category_id, :integer, default: 0
  end
end
