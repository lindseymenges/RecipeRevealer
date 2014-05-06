# Index Route
get '/' do
  if session[:id]
    @user = User.find(session[:id])
    redirect "/account_page/#{@user.id}"
  else
    redirect '/login_or_signup'
  end

end

# Login and Sign Up Routes
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

# Account Page Route

get '/account_page/:id' do
  if session[:id].to_s == params[:id].to_s
    @user = User.find(params[:id])
    @recipes = Upload.where(user_id: @user.id)
    erb :account_page
  else
    redirect '/'
  end
end




# Routes for uploading a new recipe

get '/uploadrecipe' do 
  erb :uploadrecipe
end

post '/uploadrecipe' do
  @user = User.find(session[:id])
  @uploaded_file = @user.uploads.create :filepath => params[:upload]
  @user.save!

  redirect '/'

  
end



