class CreateSkillexperiences < ActiveRecord::Migration
  def change
    create_table :skillexperiences do |t|
      t.references :skill, index: true, foreign_key: true
      t.references :experience, index: true, foreign_key: true
      t.text :comment

      t.timestamps null: false
    end
  end
end
