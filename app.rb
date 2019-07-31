require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require('./lib/city')
require('pry')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "train_system"})

get ('/') do
  erb(:index)
end

get ('/trains') do
  @trains = Train.all
  erb(:trains)
end

get ('/trains/new') do
  erb(:new_train)
end

post ('/trains') do
  train = Train.new({:color => params[:color], :type => params[:type], :id => nil})
  train.save
  redirect to('/trains')
end

get ('/trains/edit/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

patch ('/trains/edit/:id') do
  @train = Train.find(params[:id].to_i)
  @train.update(:color => params[:color], :type => params[:type], :id => nil)
  redirect to('/trains')
end

delete ('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @train.delete
  redirect to('/trains')
end

get ('/cities') do
  @cities = City.all
  erb(:cities)
end

get ('/cities/new') do
  erb(:new_city)
end

post ('/cities') do
  city = City.new({:name => params[:name], :capacity => params[:capacity], :id => nil})
  city.save
  redirect to('/cities')
end

get ('/cities/edit/:id') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
end

patch ('/cities/edit/:id') do
  @city = City.find(params[:id].to_i)
  @city.update(:name => params[:name], :capacity => params[:capacity], :id => nil)
  redirect to('/cities')
end

delete ('/cities/:id') do
  @city = City.find(params[:id].to_i)
  @city.delete
  redirect to('/cities')
end
