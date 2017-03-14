class Job < ApplicationRecord
  #Relationships
  belongs_to :organization
  belongs_to :user

  #Validations
  validates :organization_id, presence: true
  validates :user_id, presence: true, :uniqueness => { :scope => :organization_id }
  validates :title, presence: true

  accepts_nested_attributes_for :user, :organization
end
