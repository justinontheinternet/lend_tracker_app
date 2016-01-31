require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'Empties and populates the database'
task "db:populate" do
  User.destroy_all
  Item.destroy_all
  Loan.destroy_all
  @u1 = User.new(user_name: "Elliot", password: "123", location: "Toronto", image: "avatar.png")
  @u1.save!
  @u2 = User.new(user_name: "Ruth", password: "123", image: "avatar.png")
  @u2.save!
  @u3 = User.new(user_name: "Horatio", password: "123", location: "Etobicoke", image: "avatar.png")
  @u3.save!
  @i1 = Item.new(user_id: @u1.id, name: "Toothbrush", description: "Well loved.", image: "itemsilhouette.jpg")
  @i1.save!
  @i2 = Item.new(user_id: @u1.id, name: "Half-eaten sandwich", description: "It's still good!", image: "itemsilhouette.jpg")
  @i2.save!
  @i3 = Item.new(user_id: @u2.id, name: "Watch", description: "It's just a constant reminder I'm running out of time.", image: "itemsilhouette.jpg")
  @i3.save!
  @i4 = Item.new(user_id: @u2.id, name: "Belly-top", description: "What?", image: "itemsilhouette.jpg")
  @i4.save!
  @i5 = Item.new(user_id: @u3.id, name: "Self-respect", description: "I'm not using it anyway", image: "itemsilhouette.jpg")
  @i5.save!
  @i6 = Item.new(user_id: @u3.id, name: "Netflix password", description: "Let's chill.", image: "itemsilhouette.jpg")
  @i6.save!
end