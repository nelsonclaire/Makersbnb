feature 'Adding a new space' do
  scenario 'A user can add a space to Makersbnb' do
    visit('/spaces/new')
    fill_in('name', with: 'Test Space')
    fill_in('description', with: 'A space for testing against')
    fill_in('price', with: 90)
    click_button('List my space')
    expect(page).to have_content("Book a space")
  end
end
