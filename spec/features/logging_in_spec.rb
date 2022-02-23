feature 'a signed-up user can log in' do
  scenario 'clicking Login takes user to login page' do
    visit('/homepage')
    click_link 'Login'
    expect(current_path).to eq '/login'
    expect(page).to have_content 'Enter Email'
    expect(page).to have_content 'Enter Password'
    expect(page).to have_button 'Login'
  end

  scenario 'loggin in takes the user to the dates page' do 
    visit('/login')
    user = create_test_user 
    fill_in('email', with: 'test@gmail.com')
    fill_in('password', with: 'password123')
    click_button('Login')
    expect(current_path).to eq '/dates'
    expect(page).to have_content "Welcome, #{user.name}! You are logged in."
  end 
end
