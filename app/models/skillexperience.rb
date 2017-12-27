class Skillexperience < ActiveRecord::Base
  belongs_to :skill
  belongs_to :experience
end
