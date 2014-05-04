get '/' do
  if session[:id]
    p "Hey lookit that, you're logged in!"
  else
    p "You've gotta log in, yo"
  end

end
