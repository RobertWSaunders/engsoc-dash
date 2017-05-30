module ControllerHelpers

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:superadmin]
      sign_in FactoryGirl.create(:superadmin) # Using factory girl as an example
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:student]
      sign_in FactoryGirl.create(:student)
    end
  end
end
