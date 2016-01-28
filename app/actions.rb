def current_user
  User.find(session[:user_id]) if session[:user_id]
end

# Homepage/Login page
get '/' do
  erb :index
end

#lists all users
get '/users' do
  @users = User.all
  erb :'users/index'
end

#Signup page
get '/users/signup' do
  erb :'users/signup'
end

get '/items' do
  @items = Item.all
  erb :'items/index'
end

#After sign up, creats a new user.
post '/users' do
  user_name = params[:user_name]
  password = params[:password]
  @user = User.new(user_name: user_name, password: password)
  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{current_user.id}"
  else
    redirect '/users/signup'
  end
end

#Validates that user exists when logging in
post '/validation' do
  user_name = params[:user_name]
  password = params[:password]
  @user = User.find_by(user_name: user_name, password: password)
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{current_user.id}"
  else
    redirect '/users/signup'
  end
end

#Item add page
get '/items/new' do
  erb :'items/new'
end

#Creates a new item. Auto-assigned to user who creates it (via model)
post '/items' do
  name = params[:name]
  description = params[:description]
  @item = Item.new(
    name: name,
    description: description,
    user_id: current_user.id
    )
  if @item.save
    redirect "/users/#{current_user.id}"
  else
    redirect '/items/new'
  end
end

#Item profile/status page
get '/items/:id' do
  @item = Item.find(params[:id])
  erb :'items/profile'
end

#Creates a loan when a user borrows an item.
#Ties the loan to that user.
post '/items/:id/borrow' do
  user = Item.find(params[:id]).user
  @loan = Loan.new(
    user_id: current_user.id,
    item_id: params[:id],
    checkout: Date.today
    )
  if @loan.save
    redirect "/users/#{user.id}"
  else
    redirect "/users/#{current_user.id}"
  end
end

#Current user confirms an item has been returned, terminating loan.
post '/items/:id/return' do
  item = Item.find(params[:id])
  if item.loan.destroy
    redirect "/users/#{current_user.id}"
  else
    redirect "/users/#{current_user.id}"
  end
end

#User profile page (current user and other user).
get '/users/:id' do
  if params[:id] == current_user.id
    @user = User.find(current_user.id)
    @items = Item.where(user_id: current_user.id)
    erb :'users/profile'
  else
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id])
    erb :'users/profile'
  end
end

#Deletes session id, logging out the user.
get '/logout' do
  session.delete(:user_id)
  redirect '/'
end