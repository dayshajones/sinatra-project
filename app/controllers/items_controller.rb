class ItemsController < ApplicationController

    get '/items' do     #index display all groceries
        if logged_in?
            @user = current_user
            @items = @user.items
        erb :'items/index'
        else
            redirect '/login'
        end
    end

    get '/items/new' do # new return an HTML form for creating a new grocery item
        @item = Item.new
        erb :'items/new'
    end

    get '/items/:id' do #show display a specific grocery item
        @item = Item.find(params[:id])
        erb :'items/show'
    end
    
    post '/items' do #create create new grocery item
        if !logged_in?
            redirect "/login"
          else
            @item = current_user.items.create(name: params[:name], quantity: params[:quantity])
            if @item.name.blank? || @item.quantity.blank? || Item.find_by_name(params['name'])
                flash[:invalid] = "Please enter a valid item and quantity."
            redirect '/items'
            end
          end
    end

    get '/items/:id/edit' do #edit return an HTML form for editing a grocery item
        @item = Item.find(params["id"])
        if @item.user != current_user
            redirect '/items'
        else
            erb :'items/edit'
        end
    end

    patch '/items/:id' do #update a specfic grocery item
        @item = Item.find(params[:id])
        @item.update(params[:item])
        redirect "items/#{@item.id}"
    end

    delete '/items/:id' do #delete a specfic grocery item
        item = Item.find(params[:id])
        if item.user == current_user
            item.destroy
            redirect "/items"
        end
    end
end