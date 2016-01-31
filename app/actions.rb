def current_user
  User.find(session[:user_id]) if session[:user_id]
end

# Homepage/Login page
get '/' do
  erb :index
end

#lists all users
get '/users' do
  @user = User.new
  @users = User.all
  erb :'users/index'
end

#Signup page
get '/users/signup' do
  erb :'users/signup'
end

# Lists all items (do not need)
# get '/items' do
#   @items = Item.all
#   erb :'items/index'
# end

#After sign up, creats a new user.
post '/users' do
  user_name = params[:user_name]
  password = params[:password]
  @user = User.new(
    user_name: user_name,
    password: password,
    image: "avatar.png"
    )
  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{current_user.id}"
  else
    redirect '/users/signup'
  end
end

#Deletes a user's profile
get '/users/delete' do
  @user = current_user
  @user.destroy
  redirect '/'
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
    redirect '/'
  end
end

#Item add page
get '/items/new' do
  @user = User.new
  erb :'items/new'
end

#Creates a new item. Auto-assigned to user who creates it (via model)
post '/items' do
  @user = User.new
  name = params[:name]
  description = params[:description]
  @item = Item.new(
    name: name,
    description: description,
    user_id: current_user.id,
    image: "itemsilhouette.jpg"
    )
  if @item.save
    redirect "/users/#{current_user.id}"
  else
    erb :'/items/new'
  end
end

#Item profile/status page
get '/items/:id' do
  @user = User.new
  @item = Item.find(params[:id])
  erb :'items/profile'
end

#Creates a loan when a user borrows an item.
#Ties the loan to that user.
post '/items/:id/borrow' do
  @user = User.new
  @item = Item.find(params[:id])
  user = Item.find(params[:id]).user
  @loan = Loan.new(
    user_id: current_user.id,
    item_id: params[:id],
    checkout: params[:borrow_date] || Date.today,
    checkin: params[:return_date],
    details: params[:details]
    )
  if @loan.save
    redirect "/users/#{user.id}"
  else
    erb :'/items/profile'
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
  if current_user && params[:id] == current_user.id
    @user = User.find(current_user.id)
    @items = Item.where(user_id: current_user.id)
    erb :'users/profile'
  else
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id])
    erb :'users/profile'
  end
end

#Upload profile image
post '/users/upload_image' do
  #[:filename] is a default key of the name of the file
  @filename = params[:file_data][:filename]
  #[:tempfile] is a default key for the temporary path of the file in the browser
  file = params[:file_data][:tempfile]
  File.open("./public/images/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  user = current_user
  user.image = @filename
  user.save
  redirect "/users/#{current_user.id}"
end

#Upload item image
post '/items/:id/upload_image' do
  @filename = params[:file_data][:filename]
  file = params[:file_data][:tempfile]
  File.open("./public/images/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  item = Item.find(params[:id])
  item.image = @filename
  item.save
  redirect "/items/#{item.id}"
end

#Deletes session id, logging out the user.
get '/logout' do
  session.delete(:user_id)
  redirect '/'
end