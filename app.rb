require 'sinatra/base'
require "sinatra/reloader"
require 'sinatra/flash'
require 'pg'
require 'date'
require_relative './lib/space'
require_relative './lib/user'
require_relative './lib/booking'
require_relative './database_connection_setup'

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  # :method_override

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

  get '/about' do
    erb :about
  end

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

  get '/requests' do 
    @list_my_bookings = Booking.find_my_bookings(user_id: session[:user_id])
    @list_spaces = Space.all
    @list_my_spaces = Space.find_spaces(user_id: session[:user_id])
    @my_spaces = []
    @list_space_bookings = Booking.find_unconfirmed_bookings
    erb :check_request
  end 

  get '/spaces' do 
    @list_spaces = Space.find_spaces(user_id: session[:user_id])
    erb :spaces
  end 

  get '/dates' do
    @user_name = session[:user_name]
    @start_date = session[:trip_start]
    @end_date = session[:trip_end]
    erb :dates
  end

  post '/selected-dates' do
    session[:trip_start] = params[:trip_start]
    session[:trip_end] = params[:trip_end]

    @user = User.find(id: session[:user_id])
    @list_hosts = User.all
    @spaces = Space.dates(start_date: params[:trip_start], end_date: params[:trip_end])
    erb :choose_dates
  end

  post '/space/request' do
    session[:space_id] = params[:space_id]
    session[:space_name] = params[:space_name]
    @space_name = params[:space_name]

    @date_range = Date.parse(session[:trip_start])..Date.parse(session[:trip_end])

    @bookings = Booking.checkdates(space_id: params[:space_id], date: @date_range, user_id: session[:user_id]) 
    erb :request
  end

  post '/update/request' do
    @space_name = params[:space_name]
    @userid = params[:booking_userid]
    @booking_date = params[:booking_date]
    @booking_id = params[:booking_id]
    @space_id = params[:space_id]
    @user = User.find(id: @userid)
    p @userid
    p @user
    erb :booking
  end

  post '/approve/request' do
    Booking.approve_booking(id: params[:booking_id], date: params[:booking_date], space_id: params[:space_id]) 
    redirect '/requests'
  end

  post '/decline/request' do
    Booking.decline_booking(id: params[:booking_id]) 

    redirect '/requests'
  end

  post '/about' do
  erb :about
end

  get '/space/request' do
    @date_range = Date.parse(session[:trip_start])..Date.parse(session[:trip_end])
    @space_name = session[:space_name]
    @bookings = Booking.checkdates(space_id: session[:space_id], date: @date_range, user_id: session[:user_id]) 
    erb :request
  end

  post '/booking/request' do
    @booking = Booking.create(date: params[:date], space_id: session[:space_id], user_id: session[:user_id])
    redirect "/space/request"
  end

  get '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect '/login'
  end

  run! if app_file == $0
end
