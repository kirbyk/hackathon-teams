class Hacker < ActiveRecord::Base
  belongs_to :school
  belongs_to :team
  has_many :ratings
  belongs_to :status
  has_attached_file :resume,
    :storage => :s3,
    :s3_credentials => {
	    :bucket => "bm-resumes",
      :access_key_id => "AKIAJXJUB7RVDVG3SAVA",
      :secret_access_key => "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"
    }
end