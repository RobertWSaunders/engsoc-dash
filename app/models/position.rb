class Position < ApplicationRecord

  belongs_to :job
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_date_cannot_be_after_end_date, :end_date_cannot_be_before_start_date

  def active?
    if start_date.nil? || end_date.nil?
      return false
    else
      DateTime.current >= start_date && DateTime.current <= end_date
    end
  end

  private

    def start_date_cannot_be_after_end_date
      if start_date > end_date
        errors.add(:start_date, "can't be later than the end date")
      end
    end

    def end_date_cannot_be_before_start_date
      if end_date < start_date
        errors.add(:end_date, "can't be before the start date")
      end
    end

end
