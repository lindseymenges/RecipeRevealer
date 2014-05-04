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

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.create(params)
  if @user.valid?
    session[:id] = @user.id
    redirect "/account_page/#{@user.id}"
  end
end


