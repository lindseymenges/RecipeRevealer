# To Implement:
# Add a condition / error message if user puts in wrong username/password?
# Ask about adding validations after the fact
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
  ### validation for including a recipe name not currently working, will try to get that functional after basic MVP

  # if @uploaded_file.save
  #   redirect "/account_page/#{@user.id}"
  # else
  #   flash[:errors] = @uploaded_file.errors.messages
  #   erb :uploadrecipe
  # end

  @uploaded_file.save!

  redirect '/' 
end



