feature 'a signed-up user can log out' do
  scenario 'clicking Logout logs out user and takes user to login page' do
    visit('/dates')
    click_link 'Log out'
    expect(current_path).to eq '/login'
    expect(page).to have_content 'Enter Email'
    expect(page).to have_content 'Enter Password'
    expect(page).to have_button 'Login'
  end
end