class RemoveColumnDoneFromTask < ActiveRecord::Migration[6.0]
  def up
    remove_column :tasks, :done
  end

  def down
    add_column :tasks, :done, :boolean
  end
end
