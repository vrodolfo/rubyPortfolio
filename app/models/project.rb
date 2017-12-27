class Project < ActiveRecord::Base
  belongs_to :user
  validates :name, :description, :presence => true,length: { minimum: 2, maximum:250 }
  validates :description, length: { minimum: 2, maximum:500 }
end
