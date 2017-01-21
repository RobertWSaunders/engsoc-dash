class User < ApplicationRecord
  has_many :jobs
  has_many :organizations, :through => :jobs
  has_many :job_applications, dependent: :destroy
  has_many :job_postings, :foreign_key => :creator_id
  enum role: [:student, :management, :admin, :superadmin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
