class RemoveTypeFromSkill < ActiveRecord::Migration
  def change
    remove_column :skills, :type, :string
  end
end
