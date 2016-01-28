def current_user
  User.find(session[:user_id]) if session[:user_id]
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/signup' do
  erb :'users/signup'
end

get '/items' do
  @items = Item.all
  erb :'items/index'
end

post '/users' do
  user_name = params[:user_name]
  password = params[:password]
  @user = User.new(user_name: user_name, password: password)
  if @user.save
    session[:user_id] = @user.id
    redirect '/items'
  else
    redirect '/users/signup'
  end
end

post '/validation' do
  user_name = params[:user_name]
  password = params[:password]
  @user = User.find_by(user_name: user_name, password: password)
  if @user
    session[:user_id] = @user.id
    redirect '/items'
  else
    redirect '/users/signup'
  end
end

get '/items/new' do
  erb :'items/new'
end

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

get '/users/:id' do
  @user = User.find(current_user.id)
  @items = Item.where(user_id: current_user.id)
  erb :'users/profile'
end