feature 'a signed-up user can log out' do
  scenario 'clicking Logout logs out user and takes user to login page' do
    visit('/dates')
    click_link 'Sign Out'
    expect(current_path).to eq '/login'
    expect(page).to have_content 'Email Address'
    expect(page).to have_content 'Password'
    expect(page).to have_button 'Log in'
  end
end
