feature 'Adding a new space' do
  scenario 'A user can add a space to Makersbnb' do
    visit('/index')
    fill_in('name', with: 'Happy Home')
    fill_in('description', with: 'Coastal location, close to great restaurants, open plan kitchen')
    fill_in('price', with: 100.00)
    click_button('Submit')
    expect(page).to have_content("Successfully submitted Happy Home")
  end
end 

