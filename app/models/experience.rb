class Experience < ActiveRecord::Base
	belongs_to :user
	
	has_many :skillexperiences
end
