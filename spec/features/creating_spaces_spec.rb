feature 'Adding a new space' do
  scenario 'A user can add a space to Makersbnb' do
    visit('/spaces/new')
    fill_in('name', with: 'Happy Home')
    fill_in('description', with: 'Coastal location, close to great restaurants, open plan kitchen')
    fill_in('price', with: 100.00)
    click_button('List my space')
    expect(page).to have_content("Book a space")
  end
end 

