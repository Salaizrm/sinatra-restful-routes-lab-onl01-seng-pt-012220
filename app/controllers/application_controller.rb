class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end

  get '/' do
    @recipes = Recipe.all
    erb :index
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
    @recipes = Recipe.find_by(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.name = params[:name]
    @recipes.ingredients = params[:ingredients]
    @recipes.cook_time = params[:cook_time]
    @recipes.save
    redirect to "/recipes/#{@recipes.id}"
  end

 post '/recipes' do
   @recipes = Recipe.new(name: params[:name],ingredients: params[:ingredients],cook_time: params[:cook_time])
     @recipes.save
     redirect "/recipes/#{@recipes.id}"
 end

  post '/recipes/:id' do
    @recipes = Recipe.create(params)
    redirect to "/recipes/#{@recipes.id}"
  end

  delete '/recipes/:id/delete' do
    Recipe.find(params[:id]).clear
    redirect '/recipes'
  end

end
