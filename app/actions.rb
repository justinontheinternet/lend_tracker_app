# def current_user
#   User.find(session[:user_id]) if session[:user_id]
# end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/items' do
  @items = Item.all
  erb :'items/index'
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