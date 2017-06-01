# require 'rails_helper'

# describe JobPostingsController do

#   context "When logged in as superadmin" do
#     login_superadmin

#     describe "GET #edit" do
#       it "renders the edit view" do
#         organization = create(:organization_with_regular_job)
#         get :edit, params: { id: organization.jobs.first }
#         expect(response).to render_template :edit
#       end
#     end

#     describe "POST #update" do
#       it "updates a job and redirects to show" do
#         organization = create(:organization)
#         job = create(:job, organization: organization)
#         job_params = { :title => Faker::Job.title }
#         put :update, params: { :id => job.id, :job => job_params }
#         expect(response).to redirect_to(job_path(:id => job.id))
#       end
#     end

#     describe "POST #destroy" do
#       it "deletes the job and redirects to show organization" do
#         organization = create(:organization)
#         job = create(:job, organization: organization)
#         expect { put :destroy, params: { :id => job.id } }.to change(Job, :count).by(-1)
#         expect(response).to redirect_to(organization_path(:id => organization.id))
#       end
#     end
#   end

#   context "When logged in as student" do
#     login_student

#     before(:each) do
#       @organization = create(:organization)
#     describe "GET #index" do
#       it "renders the index view" do
#         organization = create(:organization_with_regular_job)
#         get :show, params: { id: organization.jobs.first }
#         expect(response).to render_template :show
#       end
#     end

#     describe "GET #show" do
#       it "renders the show view" do
#         organization = create(:organization_with_regular_job)
#         get :show, params: { id: organization.jobs.first }
#         expect(response).to render_template :show
#       end
#     end
#   end

# end