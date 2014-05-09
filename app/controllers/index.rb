# Index Route
get '/' do
  # session.clear
  if session[:id]
    @user = User.find(session[:id])
    redirect "/account_page/#{@user.id}"
  else
    redirect '/homepage'
  end
end

# Login and Sign Up Routes
get '/homepage' do 
  erb :homepage
end

get '/login' do
  erb :_login, layout: false
end
post '/login' do
  @user = User.find_by_username(params[:username])
  if @user == nil
    redirect '/new_account'
  elsif @user.password == params[:password]
    session[:id] = @user.id
    redirect "/account_page/#{@user.id}"
  else
    redirect '/loginfail'
  end
end

get '/loginfail' do
  erb :_loginfail
end
post '/loginfail' do
  @user = User.find_by_username(params[:username])
  if @user == nil
    redirect '/new_account'
  elsif @user.password == params[:password]
    session[:id] = @user.id
    redirect "/account_page/#{@user.id}"
  else
    redirect '/loginfail'
  end
end

get '/new_account' do
  erb :_new_account
end


get '/signup' do
  erb :_signup, layout: false
end
post '/signup' do
  @user = User.new(params)
  if @user.save
    session[:id] = @user.id
    redirect "/account_page/#{@user.id}"
  else
    flash[:errors] = @user.errors.messages
    erb :signup
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# Account Page Route
get '/account_page/:id' do
  if session[:id].to_s == params[:id].to_s
    @user = User.find(params[:id])
    @recipes = Upload.where(user_id: @user.id).sort{ |a, b| a.name.downcase <=> b.name.downcase }
    erb :account_page
  else
    redirect '/'
  end
end

# Routes for uploading a new recipe
get '/uploadrecipe' do 
  erb :_uploadrecipe, layout: false
end
post '/uploadrecipe' do
  @user = User.find(session[:id])
  @uploaded_file = Upload.new(filepath: params[:upload], name: params[:name])
  @uploaded_file.user_id = @user.id
  @uploaded_file.save!
  redirect '/' 
end

# Routes for deleting a recipe
get '/deleterecipe/:id' do
  @recipe = Upload.find(params[:id])
  erb :_deleterecipe
end
post '/deleterecipe/:id' do
  @recipe = Upload.find(params[:id])
  @recipe.destroy
  redirect '/'
end

# Routes for deleting account
get '/deleteaccount/:id' do
  @user = User.find(params[:id])
  erb :_deleteaccount
end
post '/deleteaccount/:id' do
  @recipes = Upload.where(user_id: params[:id])
  @recipes.each do |recipe|
    recipe.destroy
  end
  @user = User.find(params[:id])
  @user.destroy
  session.clear
  redirect '/'
end



