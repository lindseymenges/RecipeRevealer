get '/' do
  if session[:id]
    @user = User.find(session[:id])
    redirect "/account_page/#{@user.id}"
  else
    redirect '/login_or_signup'
  end

end

get '/login_or_signup' do 
  erb :login_or_signup
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by_username(params[:username])
  if @user == nil
    redirect '/signup'
  elsif @user.password == params[:password]
    session[:id] = @user.id
    redirect "/account_page/#{@user.id}"
  else
    redirect '/login'
  end
end

get '/account_page/:id' do
  if session[:id].to_s == params[:id].to_s
    @user = User.find(params[:id])
    @recipes = Recipe.all.select{ |recipe| recipe.user_id == @user.id }
    p @recipes
    erb :account_page
  else
    redirect '/'
  end
end

get '/newrecipe' do
  erb :newrecipe
end

post '/newrecipe' do
  @recipe = Recipe.new(params)
  @recipe.user_id = session[:id]
  @user = User.find(session[:id])
  if @recipe.save
    redirect "/account_page/#{@user.id}"
  else
    flash[:errors] = @recipe.errors.messages
    erb :newrecipe
  end
end

get '/recipe/:id' do
  @recipe = Recipe.find(params[:id])
  erb :recipepage
end

get '/signup/newuser' do
  erb :signup
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


