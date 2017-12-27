class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :technology
      t.text :description
      t.string :link
      t.string :logo
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
