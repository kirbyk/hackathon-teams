class School < ActiveRecord::Base
  has_many :hackers

  validates :name, presence: true, uniqueness: true
end
