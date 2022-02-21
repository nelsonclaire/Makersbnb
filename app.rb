require 'sinatra/base'
require "sinatra/reloader"
require 'pg'
require_relative './lib/space'

class Makersbnb < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
  end



  run! if app_file == $0
end