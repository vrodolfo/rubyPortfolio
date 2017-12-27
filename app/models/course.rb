class Course < ActiveRecord::Base
  belongs_to :user


  validates :name, :school, :country, :status,:city, :presence => true,length: { minimum: 2, maximum:100 }
  validates :start, :end, :presence => true
end
