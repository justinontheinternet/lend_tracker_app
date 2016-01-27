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
