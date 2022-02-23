require 'sinatra/base'
require "sinatra/reloader"
require 'sinatra/flash'
require 'pg'
require 'date'
require_relative './lib/space'
require_relative './lib/user'
require_relative './database_connection_setup'

class Makersbnb < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
  end

  enable :sessions

# , :method_override

register Sinatra::Flash

  get '/' do
    'Welcome to Makersbnb'
  end

  get '/spaces/new' do 
    erb :new
  end

  get '/homepage' do 
    erb :homepage
  end

  get '/login' do
    erb :login
  end

  post '/login-details' do
    @user = User.authenticate(email: params['email'], password: params['password'])
    if @user
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      redirect '/dates'
    else
      flash[:notice] = 'User email or password is incorrect'
      redirect '/login'
    end
  end
  
  post '/spaces/new' do  

    space = Space.list(name: params['name'], description: params['description'], 
    price: params['price'], start_date: params['start_date'], end_date: params['end_date'], 
    user_id: session['user_id'])

    if space
      redirect "/dates"
    else
      flash[:notice] = 'All fields must be completed!'
      redirect "/spaces/new"
    end
  end 


  # get '/users/new' do
  #   erb :"users/new"
  # end

  post '/users/new' do
    if params['signup_password'] != params['confirm_signup_password']
      flash[:notice] = 'The password fields must match!'
      redirect "/homepage"
    else
      user = User.create(name: params[:signup_name], username: params[:signup_username],
      email: params[:signup_email], password: params[:signup_password])
    end
    if user
      session[:user_id] = user.id
      redirect "/spaces/new"
    else
      flash[:notice] = 'Email or Username already in use or field(s) is blank!'
      redirect "/homepage"
    end
  end

  get '/dates' do
    p params
    @user_name = session[:user_name]
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

  get '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect '/login'
  end

  run! if app_file == $0
end
