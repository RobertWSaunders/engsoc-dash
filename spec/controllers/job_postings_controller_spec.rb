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

    # before(:each) do
    #   @organization = create(:organization)
    # end

    # index
      # postings for active orgs should be visible
      # postings for inactive orgs should not

    # show
      # only approved ones




  end

end
