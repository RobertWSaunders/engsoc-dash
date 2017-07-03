class Position < ApplicationRecord

  belongs_to :job
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true

  def active?
    if start_date.nil? || end_date.nil?
      return false
    else
      DateTime.current >= start_date && DateTime.current <= end_date
    end
  end

end
