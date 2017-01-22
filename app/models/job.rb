class Job < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  accepts_nested_attributes_for :user, :organization
end
