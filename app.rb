require 'sinatra/base'
require "sinatra/reloader"
require 'pg'
require 'date'
require_relative './lib/space'

class Makersbnb < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
  end

  enable :sessions

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
    p params
    @start_date = session[:trip_start]
    @end_date = session[:trip_end]
    erb :dates
  #   place = params[:place]
  #   start_date = params[:trip-start]
  #   end_date = params[:trip-end]
  end
  
  post '/selected-dates' do
    @start_date = params[:trip_start]
    session[:trip_start] = @start_date
    @end_date = params[:trip_end]
    session[:trip_end] = @end_date
    redirect '/dates'
    # Space.dates(place: params[:id], start: params[:trip-start], end: params[:trip-end]) 
  end

  run! if app_file == $0
end
