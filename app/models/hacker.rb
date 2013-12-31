class Hacker < ActiveRecord::Base
  belongs_to :school
  belongs_to :team
end
