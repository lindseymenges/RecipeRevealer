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

get '/account_page/:id' do
  if session[:id].to_s == params[:id].to_s
    @user = User.find(params[:id])
    erb :account_page
  else
    redirect '/'
  end
end

get '/signup/newuser' do
  erb :signup
end

post '/signup' do
  @user = User.new(params)
  p '1'
  if @user.save
    p '2'
    session[:id] = @user.id
    redirect "/account_page/#{@user.id}"
  else
    p '3'
    flash[:errors] = @user.errors.messages
    p '4'
    p flash
    erb :signup
  end
end


