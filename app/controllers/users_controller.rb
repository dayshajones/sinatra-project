class UsersController < ApplicationController

    get '/users' do
        @users = User.all
        erb :'/users/index'
    end
    
    get "/users/new" do
        erb :"users/new"
    end

    post "/users" do
        u = User.new(username: params['username'], password: params['password'])
        if u.username.blank? || u.password.blank? || User.find_by_username(params['username'])
            flash[:alerts] = "Invalid, please try again."
           redirect '/users/new'
        else
            u.save
            session[:user_id] = u.id
            redirect '/items'
        end
    end

    get "/users/:id" do
        @user = User.find(params[:id])
        erb :"users/show"
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        user = User.find_by_username(params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/"
        else
        flash[:error] = "Invalid username or password, please try again."
          redirect "/login"
        end
    end

    get '/logout' do
        session.clear
        redirect '/users/new'
    end

end