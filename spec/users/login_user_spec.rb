require 'rails_helper.rb'

feature 'Regular user' do
  scenario 'can login' do
    user = create(:student)
    visit '/users/sign_in'
    fill_in 'user_email', with: 'regular@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Regular')
  end
end