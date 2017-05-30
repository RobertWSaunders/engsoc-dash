require 'rails_helper'

describe OrganizationsController do

  login_superadmin

  describe "GET #index" do
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

end
