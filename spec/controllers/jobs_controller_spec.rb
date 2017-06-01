require 'rails_helper'

describe JobsController do

  context "When logged in as superadmin" do
    login_superadmin

  end

  context "When logged in as student" do
    login_student

    describe "GET #show" do
      it "renders the show view" do
        organization = create(:organization_with_regular_job)
        get :show, params: { id: organization.jobs.first }
        expect(response).to render_template :show
      end
    end
  end

end
