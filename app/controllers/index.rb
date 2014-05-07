#really like that you used pseudocode!
#naming and overall structure if great! 
#you kept your logic in the right places and made some awesome routes :)
#comments to describe your routes are really great for others as well as you...great!
#try not to leave spaces in between code, because apparently it makes it seem like you could be missing or forgot to include something

# To Implement:
# Oauth (with FB, Google, etc.)
# User can delete recipe uploads
# Look into file path thing Adam talked about (add '/user' route?)
# Look into whether or not current setup will work with Heroku
# STYLING
# Put a message on page if user has not uploaded any recipes?

# Index Route
get '/' do
  # session.clear
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
    @recipe = @recipes.first
    p @recipe
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
  @uploaded_file = Upload.new(filepath: params[:upload], name: params[:name])
  @uploaded_file.user_id = @user.id
  # if @uploaded_file.save
  #   redirect "/account_page/#{@user.id}"
  # else
  #   flash[:errors] = @uploaded_file.errors.messages
  #   erb :uploadrecipe
  # end

  # validation for including a recipe name not currently working, will try to get that functional after basic MVP
  @uploaded_file.save!

  redirect '/'

  
end



