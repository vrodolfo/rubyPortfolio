class Skill < ActiveRecord::Base
  belongs_to :user

  has_many :skillexperiences

  validates :name, :category , :presence => true,length: { minimum: 2, maximum:100 }
  validates :comment,length: { minimum: 2, maximum:500 }
  validates :years, :numericality => {:only_integer => true}
end
