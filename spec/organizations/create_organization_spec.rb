# require 'rails_helper.rb'

# # 1. login user
# # 2. go to root path
# # 3. click on admin dropdown
# # 4. click on organizations button
# # 5. click on create organization
# # 6. fill out form
# # 7. submit form
# # 8. see organizations show page

# feature 'Create organization' do
#   scenario 'can create an organization' do
#     user = create(:superadmin)
#     login_as(user, :scope => :user)
#     # 1.
#     visit '/'
#     # 2.
#     save_and_open_page
#     click_link 'Admin'
#     click_link 'Organizations'
#     click_link 'Create Organization'
#   end
# end