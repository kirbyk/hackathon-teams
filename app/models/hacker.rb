class Hacker < ActiveRecord::Base
  belongs_to :school
  belongs_to :team
  has_many :ratings
  belongs_to :status
  has_attached_file :resume,
		:storage => :s3,
		:s3_credentials => {
			:bucket => ENV['AWS_BUCKET'],
			:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
			:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
		}
  validates_format_of :resume_file_name, :with => %r{\.(docx|doc|pdf)\z}i
  # validates_resume_content_type :resume, :content_type => [ 'application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ]
end
