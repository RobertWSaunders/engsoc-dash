require 'rails_helper'

describe JobPostingsController do

  context "When logged in as superadmin" do
    login_superadmin

    # index
    # new
    # select - only show job postings user can manage
    # create
    # edit
    # update
    # destroy
    # admin
      # do they have access to admin func on this page?
    # approve, withdraw, interview, manage

  end

  context "When logged in as student" do
    login_student

    before(:all) do
      # create necessary org, job, and jp test objects
      @active_org = create(:organization, :active)
      @job_active_org = create(:job, organization: @active_org)
      # these cases imply that two job postings can be created for a single job
      # inactive org related jps shouldn't show
      @inactive_org = create(:organization, :waiting_approval)
      @job_inactive_org = create(:job, organization: @inactive_org)
    end

    describe "GET #index" do
      render_views
      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
      it "shows open postings for active organizations" do
        open_jp_active_org = create(:job_posting, :open, job: @job_active_org)
        get :index
        expect(response.body).to have_content(open_jp_active_org.title)
      end
      it "shouldn't show waiting_approval postings for active organizations" do
        waiting_approval_jp_active_org = create(:job_posting, :waiting_approval, job: @job_active_org)
        get :index
        expect(response.body).not_to have_content(waiting_approval_jp_active_org.title)
      end
      it "shouldn't show closed postings for active organizations" do
        closed_jp_active_org = create(:job_posting, :closed, job: @job_active_org)
        get :index
        expect(response.body).not_to have_content(closed_jp_active_org.title)
      end
      it "shouldn't show open postings for inactive organizations" do
        open_jp_inactive_org = create(:job_posting, :open, job: @job_inactive_org)
        get :index
        # expect(response.body).not_to have_content(open_jp_inactive_org.title)
        expect(response.body).not_to have_content(@inactive_org.name)
      end
    end

    # show
      # only approved ones

  end

end
