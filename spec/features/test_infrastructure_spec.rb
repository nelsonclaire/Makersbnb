feature 'test the infrastructure' do
  scenario 'it can go to the home page' do
    visit '/'
    expect(page).to have_content 'MakersBnB - Feel at home'
  end
end
