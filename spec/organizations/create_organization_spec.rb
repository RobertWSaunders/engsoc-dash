# require 'rails_helper.rb'

# # 1. go to root path
# # 2. click on admin dropdown
# # 3. click on organizations button
# # 4. click on create organization
# # 5. fill out form
# # 6. submit form
# # 7. see organizations show page

# feature 'Create organization' do
#   scenario 'can create an organization' do
#     user = create(:student)
#     # 1.
#     visit '/users/sign_in'
#     # 2.
#     # click_link 'Admin'
#     fill_in 'user_email', with: 'regular@example.com'
#     fill_in 'user_password', with: 'password'
#     click_button 'Log in'
#     expect(page).to have_content('Regular')
#   end
# end