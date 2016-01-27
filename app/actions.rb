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

get '/items/:id' do
  @items = Item.all
  erb :'items/index'
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
  @item = Item.new
  erb :'items/new'
end

post '/items' do
  name = params[:name]
  description = params[:description]
  @item = Item.new(
    name: name,
    description: description
    )
  if @item.save
    redirect '/items'
  else
    redirect '/items/new'
  end
end