class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :company
      t.string :position
      t.date :start
      t.date :end
      t.string :category
      t.text :description
      t.string :termination
      t.string :website
      t.string :phone1
      t.string :phone2
      t.text :comment
      t.string :city
      t.string :state
      t.string :country
      t.string :address
      t.text :achievement
      t.text :responsabilities

      t.timestamps null: false
    end
  end
end
