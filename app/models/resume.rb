class Resume < ApplicationRecord

  # validate :resume_size_validation
  # TODO: this validation needs to be tested!

  # https://www.tutorialspoint.com/ruby-on-rails/rails-file-uploading.htm

  mount_uploader :attachment, AttachmentUploader

  belongs_to :user
  has_many :job_applications, foreign_key: "resumes_id", dependent: :nullify

  validates :user_id, presence: true
  validates :name, presence: true
  validates :attachment, presence: true, file_size: { less_than: 2.megabytes }
  # validate :resume_size_validation

  private

    def resume_size_validation
      errors[:resume] << "should be less than 2MB" if this.size > 2.megabytes
    end
end
