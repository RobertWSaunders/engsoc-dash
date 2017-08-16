require 'rails_helper'

# https://hackernoon.com/your-guide-to-testing-in-ruby-on-rails-5-c8bd122e38ad

# Model/Unit, Controller, View tests just rely on RSpec
# An example of a 'controller test' (of a user controller w/ Devise)
# full form header syntax:
  # RSpec.describe UsersController, type: :controller do
# short form header syntax:
describe UsersController do

  # Having difficulty on which route to route the test to (since index is not available by default), so comment out for now - this case is already covered in feature tests below

  # context 'When student user login is valid' do
  #   # using helper in /support/controller_helpers.rb (included in spec_helper.rb file)
  #   login_student
  #   it 'logs in user, and they can access index' do
  #     get 'index'
  #     expect(response).to render_template :index
  #   end
  # end

  context 'When any user not logged in' do
    # using helper in /support/controller_helpers.rb (included in spec_helper.rb file)
    it 'redirect to sign in page' do
      get 'index'
      expect(response).to redirect_to ("/users/sign_in")
    end
  end

  context 'When superadmin user login is valid' do
    # to test if admin login was successful, need to verify page content...
    # https://stackoverflow.com/questions/39894061/how-to-writes-test-case-in-rails-for-html-content
    render_views
    login_superadmin
    it 'logs in user and directs them to index' do
      get 'index'
      expect(response).to render_template :index
      expect(response.body).to have_content('Admin')
    end
    # as suggested in the SO post, this sort of test can be a feature test instead, like below
  end
end

# Feature tests use Capybara & RSpec
# Example of a 'feature test', with a Warden helper 'stub' authentication
feature 'Login Superadmin user' do
  scenario 'can login' do
    user = create(:superadmin)
    login_as(user, :scope => :user)
    visit '/'
    expect(page).to have_content('Admin')
  end
end

# Example of feature test, this time a more thorough way
feature 'Login Regular user' do
  scenario 'can login' do
    user = create(:student)
    visit '/users/sign_in'
    fill_in 'user_email', with: 'regular@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).not_to have_content('Admin')
  end
end
