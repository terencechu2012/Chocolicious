class Claim < ActiveRecord::Base
  has_attached_file :supportdoc
  #validates_attachment_content_type :attachment, :content_type => ['application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
  validates_attachment_presence :supportdoc
  # do_not_validate_attachment_file_type :supportdoc
end
