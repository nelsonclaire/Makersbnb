xfeature 'select a trips-start date' do
  scenario 'has a date picker to select start date' do
    create_test_user
    
    list_test_space
    visit('/dates')
    expect(page).to have_content "Available from (DD/MM/YY)"
    fill_in('trip_start', with: Date.today.to_s)
    fill_in('trip_end', with: (Date.today + 1).to_s)
    click_button('List spaces')
    # visit('/selected-dates')

    expect(page).to have_content "Test space"
  end
end
