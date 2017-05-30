require 'rails_helper'

# https://hackernoon.com/your-guide-to-testing-in-ruby-on-rails-5-c8bd122e38ad

# Controller
# An example of a 'controller test' (of a user controller w/ Devise)
# full form header syntax:
  # RSpec.describe UsersController, type: :controller do
# short form header syntax:
describe UsersController do

  # begin writing user controller test cases

  # using helper in /support/controller_helpers.rb (included in spec_helper.rb file)
  login_user

  context 'When student user login is valid' do
    it 'sets student user in session and redirects them to index' do
      get 'index'
      expect(response).to be_success
      # expect(controller.current_user).to eq user
    end
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

# Example of feature test, this time 
feature 'Login Regular user' do
  scenario 'can login' do
    user = create(:student)
    visit '/users/sign_in'
    fill_in 'user_email', with: 'regular@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Regular')
  end
end
