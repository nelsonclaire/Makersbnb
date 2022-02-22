require 'sinatra/base'
require "sinatra/reloader"
require 'pg'
require_relative './lib/space'

class Makersbnb < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
  end

  get '/' do
    'Welcome to Makersbnb'
  end

  get '/index' do 
    erb :index
  end
  
  post '/spaces' do
    space = Space.list(name: params['name'], description: params['description'], price: params['price'])
    'Successfully submitted ' + space.name 
  end 

  get '/dates' do
    erb :dates
  #   place = params[:place]
  #   start_date = params[:trip-start]
  #   end_date = params[:trip-end]
  end
  
  post '/selected-dates' do
    # Space.dates(place: params[:place-id], start: params[:trip-start], end: params[:trip-end]) 
  end

  run! if app_file == $0
end
