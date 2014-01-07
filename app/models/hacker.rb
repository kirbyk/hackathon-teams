class Hacker < ActiveRecord::Base
  belongs_to :school
  belongs_to :team
  has_many :ratings
  belongs_to :status
  has_attached_file :resume
  validates_format_of :resume_file_name, :with => %r{\.(docx|doc|pdf)\z}i
end
