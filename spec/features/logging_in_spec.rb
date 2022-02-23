feature 'a signed-up user can log in' do
  scenario 'clicking Login takes user to login page' do
    visit('/homepage')
    click_link 'Login'
    expect(current_path).to eq '/login'
    expect(page).to have_content 'Enter Email'
    expect(page).to have_content 'Enter Password'
    expect(page).to have_button 'Login'
  end
end