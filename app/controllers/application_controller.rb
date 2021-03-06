require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV["SESSION_SECRET"]
    register Sinatra::Flash
  end

  not_found do
    status 404
  end

  get "/" do
    erb :welcome
  end

  get '/about' do
    erb :about
  end

  helpers do
    def logged_in?
      !!current_user
		end

    def current_user
      @user = User.find_by_id(session[:user_id])
    end
	end

end
