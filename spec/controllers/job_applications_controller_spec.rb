require 'rails_helper'

describe JobApplicationsController do

  context "When logged in as superadmin" do
    login_superadmin


  end

  context "When logged in as student" do
    login_student

  end

end

# index
#   gets job applications for a given job posting
# new
#   if job app exists for job posting, and not submitted
#     redirect to edit job app job posting answer
#     if submitted
#       redirect to job posting path, with flash message
#   else
#     create new job app
# show
#   already created job app
# finalize
#   if submitted, update app to 'submitted', and redirect to user job app path
# destroy
# user
#   show my job app
# hire
#   can select one or many applicants
#   change selected job application(s) status(es) to 'hired'
#   change non-selected job application(s) status(es) to 'declined'
#   change job posting to 'closed'

#   set job_application user_ids to be job user_ids
#   save

