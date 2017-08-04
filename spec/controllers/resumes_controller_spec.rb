require 'rails_helper'

RSpec.describe ResumesController, type: :controller do

  context "When logged in as student" do
    login_student

    describe "GET #index" do
      it "returns http success" do
        get :index, params: { :profile_id => controller.current_user.id }
        expect(response).to have_http_status(:success)
      end
    end

  end

end
