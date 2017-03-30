class Interview < ApplicationRecord
  belongs_to :job_application

  validate :start_time_is_earlier
  validate :less_than_2_hours

  private

    def start_time_is_earlier
      errors.add(:start_time, "should be before end time") if self.start_time > self.end_time
    end

    # it would be wise to take in the max hours as a param to make this a reusable component
    def less_than_2_hours
      two_hours_later = self.start_time + 2.hours
      errors.add(:end_time, "should be at most 2 hours after start time (interviews must be shorter than 2 hours in duration)") if self.end_time > two_hours_later
    end
end
