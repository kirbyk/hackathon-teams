class AddAttachmentResumeToHackers < ActiveRecord::Migration
  def self.up
    change_table :hackers do |t|
      t.attachment :resume
    end
  end

  def self.down
    drop_attached_file :hackers, :resume
  end
end
