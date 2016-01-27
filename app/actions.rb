# create a helper for check_user
helpers do

  def check_user
    session.delete(:login_error)
    @user = User.find_by(id: session[:user_id])
    unless @user
      session[:login_error] = "You must be logged in to view tracks."
      redirect '/login'
    end
  end

end

# Homepage (Root path)
get '/' do
  erb :index
end

# Music Wall - Listing of all tracks
get '/tracks' do
	check_user
	@tracks = Track.all
	erb :'tracks/index'
end

# Form to add a new track
get '/tracks/new' do
	@track = Track.new
	erb :'tracks/new'
end

# Add Track
post '/tracks' do
	@track = Track.new(
		song_title: params[:song_title],
		author: params[:author],
		url: params[:url]
		)
	if @track.save
		redirect '/tracks'
	else
		erb :'tracks/new'
	end
end

# Form to add a new user
get '/users/new' do
	@user = User.new
	erb :'users/new'
end

# Add User
post '/users' do
	@user = User.new(
		first_name: params[:first_name],
		last_name: params[:last_name],
		email: params[:email],
		password: params[:password]
		)
	if @user.save
		session[:user_id] = @user.id
		redirect '/tracks'
	else
		erb :'users/new'
	end
end

# Login
get '/login' do
	erb :login
end

# Login validation
post '/validate' do
  email = params[:email]
  password = params[:password]
  user = User.find_by(email: email, password: password)
  if user
    session[:user_id] = user.id
    redirect '/tracks'
  else
    session.delete(:user_id)
    redirect '/login'
  end
end

# Logout
get '/logout' do
  session.delete(:user_id)
  redirect '/login'
end

# Delete track
post '/tracks/:id/delete' do
	track = Track.find(params[:id])
	track.delete
	redirect '/tracks'
end

# Login flow
# 1. Get user info
# 2. Authenticate - check validity of user id
# 3. Create session
# 4. Check if user id in session, check if user id actually exists in the database (if there are pages only for the user)