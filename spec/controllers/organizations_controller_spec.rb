require 'rails_helper'

describe OrganizationsController do

  context "When logged in as superadmin" do
    login_superadmin

    describe "GET #new" do
      it "renders the new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create with valid params" do
      it "creates a new org" do
        organization_params = FactoryGirl.attributes_for(:organization)
        expect { post :create, params: { :organization => organization_params } }.to change(Organization, :count).by(1)
      end
    end

    # should be in model spec
    describe "POST #create with invalid params" do
      it "doesn't create a new org" do
        organization_params = FactoryGirl.attributes_for(:organization, :invalid)
        expect { post :create, params: { :organization => organization_params } }.to change(Organization, :count).by(0)
      end
    end

    describe "POST #update" do
      it "update the org, and redirect to show it" do
        organization = create(:organization)
        organization_params = { :name => Faker::Team.name }
        put :update, params: { :id => organization.id, :organization => organization_params }
        expect(response).to redirect_to(organization)
      end
    end

    describe "POST #destroy" do
      it "destroys the org, and redirects to index" do
        organization = create(:organization)
        put :destroy, params: { :id => organization.id }
        expect(response).to redirect_to ("/organizations")
      end
    end

    describe "GET #admin" do
      it "renders the admin view" do
        get :admin
        expect(response).to render_template :admin
      end
    end

    # describe "POST #withdraw" do
    #   it "withdraws the "

  end

  context "When logged in as student" do
    login_student

    describe "GET #index" do
      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      it "does not render the new view" do
        get :new
        expect(response).not_to render_template :new
      end
    end

    describe "POST #create with valid params" do
      it "does not creates a new org, no permissions" do
        organization_params = FactoryGirl.attributes_for(:organization)
        expect { post :create, params: { :organization => organization_params } }.to change(Organization, :count).by(0)
      end
    end

    describe "GET #show" do
      it "renders the show view" do
        organization = create(:organization)
        get :show, params: { id: organization.id }
        expect(response).to render_template :show
      end
    end

    describe "GET #admin" do
      it "does not render the admin view" do
        get :admin
        expect(response).not_to render_template :admin
      end
    end

    describe "GET #user" do
      it "render the user view" do
        get :user
        expect(response).to render_template :user
      end
    end

  end

end
