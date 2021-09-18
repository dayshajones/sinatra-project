class ItemsController < ApplicationController

    get '/items' do     
        if logged_in?
            @user = current_user
            @items = @user.items
        erb :'items/index'
        else
            redirect '/login'
        end
    end

    get '/items/new' do 
        @item = Item.new
        erb :'items/new'
    end

    get '/items/:id' do 
        @item = Item.find(params[:id])
        erb :'items/show'
    end
    
    post '/items' do    
        item = current_user.items.create(name: params[:name], quantity: params[:quantity])
            if item.name.blank? || item.quantity.blank?
                flash[:invalid] = "Please enter a valid item and quantity."
                redirect '/items/new'
            else
                if item.valid?
                redirect '/items'
            end
        end
    end

    get '/items/:id/edit' do 
        @item = Item.find(params["id"])
        if @item.user != current_user
            redirect '/items'
        else
            erb :'items/edit'
        end
    end

    patch '/items/:id' do 
        item = Item.find(params[:id])
        item.update(params[:item])
        redirect "items/#{@item.id}"
    end

    delete '/items/:id' do 
        item = Item.find(params[:id])
        if item.user == current_user
            item.destroy
            redirect "/items"
        end
    end
end