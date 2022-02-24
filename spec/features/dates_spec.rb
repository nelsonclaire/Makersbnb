feature 'select a trips-start date' do
  scenario 'has a date picker to select start date' do
    visit('/dates')
    expect(page).to have_content "Available from (DD/MM/YY)"
    fill_in('trip_start', with: '2022-02-25')
    fill_in('trip_end', with: '2022-02-28')
    click_button('List spaces')
    visit('/selected-dates')

    expect(page).to have_content "Book a space"
  end
end
