require 'rails_helper.rb'

# 1. login user
# 2. go to root path
# 3. click on admin dropdown
# 4. click on organizations button
# 5. click on create organization
# 6. fill out form
# 7. submit form
# 8. see organizations show page

feature 'Superadmin user' do
  scenario 'can login' do
    user = create(:superadmin)
    login_as(user, :scope => :user)
    visit '/'
    expect(page).to have_content('Admin')
  end
end