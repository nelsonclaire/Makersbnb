feature 'select a trips-start date' do
  scenario 'has a date picker to select start date' do
    visit('/dates')
    expect(page).to have_content "Start date:"
    fill_in('trip-start', with: '2022-02-25')
    # within_table("//input[@id='start']") do
    #   fill_in 'trip-start', with: '2022-02-25'
    # end
    expect(page).to have_content "25/02/2022"
  end
end