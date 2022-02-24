feature 'a signed-up user can log in' do
  scenario 'clicking Login takes user to login page' do
    visit('/homepage')
    click_link 'Login'
    expect(current_path).to eq '/login'
    expect(page).to have_content 'Email Address'
    expect(page).to have_content 'Password'
    expect(page).to have_button 'Log in'
  end

  scenario 'logging in takes the user to the dates page' do
    visit('/login')
    user = create_test_user
    fill_in('email', with: 'test@gmail.com')
    fill_in('password', with: 'password123')
    click_button('Log in')
    expect(current_path).to eq '/dates'
    expect(page).to have_content "You are logged in #{user.name}!"
  end
end
