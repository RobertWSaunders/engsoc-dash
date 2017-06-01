require 'rails_helper'

describe JobPostingsController do

  context "When logged in as superadmin" do
    login_superadmin

  end

  context "When logged in as student" do
    login_student

    before(:each) do
      @organization = create(:organization)
    end
  end

end
