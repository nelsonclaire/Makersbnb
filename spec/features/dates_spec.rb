feature 'select a trips-start date' do
  scenario 'has a date picker to select start date' do
    visit('/dates')
    expect(page).to have_content "Start date:"
    fill_in('trip_start', with: '2022-02-25')
    fill_in('trip_end', with: '2022-02-28')
    click_button('submit_dates')
    
    expect(page).to have_content "Selected dates: 2022-02-25 - 2022-02-28"
  end
end