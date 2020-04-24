require './config/environment'

class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
      id = params[:id]
         new_params = {}
         old = Recipe.find(id)
         new_params[:name] = params[:name]
         new_params[:ingredients] = params[:ingredients]
         new_params[:cook_time] = params[:cook_time]
         old.update(new_params)

      redirect to "/articles/#{@articles.id}"
    end

  post '/recipes' do
    @recipes = Recipe.create(params)
    redirect to "/recipes/#{@recipes.id}"
  end

  delete '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.delete
    redirect to '/recipes'
  end

end
