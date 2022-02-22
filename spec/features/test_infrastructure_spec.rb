feature 'test the infrastructure' do 
  scenario 'it can go to the home page' do 
    visit '/' 
    expect(page).to have_content 'Welcome to Makersbnb'
  end 
end 

