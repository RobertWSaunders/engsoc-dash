json.extract! interview, :id, :job_posting_id, :start_time, :end_time, :created_at, :updated_at
json.url interview_url(interview, format: :json)