require 'sinatra/base'
require "sinatra/reloader"
require 'sinatra/flash'
require 'pg'
require_relative './lib/space'
require_relative './lib/user'

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

  get '/index' do 
    erb :index
  end
  
  post '/spaces' do
    space = Space.list(name: params['name'], description: params['description'], price: params['price'])
    'Successfully submitted ' + space.name 
  end 

  get '/users/new' do
    erb :"users/new"
  end

  post '/users/new' do
    user = User.create(name: params['name'], username: params['username'], 
    email: params['email'], 
    password: params['password'])
    if user
      session[:user_id] = user.id
      redirect "/index"
    else
      flash[:notice] = 'Email or Username already in use or field(s) is blank!'
      redirect "/users/new"
    end
  end

  run! if app_file == $0
end
