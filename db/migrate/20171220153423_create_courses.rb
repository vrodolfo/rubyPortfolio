class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :category
      t.string :school
      t.date :start
      t.date :end
      t.string :status
      t.string :city
      t.string :country
      t.string :description
      t.string :website

      t.timestamps null: false
    end
  end
end
