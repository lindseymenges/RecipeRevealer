# To Implement:
# JAVASCRIPT (Login/signup page erb switches to login or signup erb depending on what was clicked [DONE], append upload_recipe erb upon upload click)
# User can delete recipe uploads
# Along with this ^, need to figure out how to not only delete the object from the database but ALSO delete the PDF file itself (research deleting things from AWS buckets?)

# STRETCH
# User can edit uploads (name and/or filepath)
# Oauth (with FB, Google, etc.)
# Put a message on page if user has not uploaded any recipes?
# User can delete account?


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
    redirect '/signup'
  elsif @user.password == params[:password]
    session[:id] = @user.id
    redirect "/account_page/#{@user.id}"
  else
    redirect '/login'
  end
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

  ### validation for including a recipe name not currently working, will try to get that functional after basic MVP
  @uploaded_file.save!

  redirect '/' 
end



