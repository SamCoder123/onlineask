# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

create_account = User.create([email: '123@123', password: '123123', password_confirmation: '123123', is_admin: 'true'])
puts "Admin account created."

create_replyer = User.create([email: '1@1', password: '123123', password_confirmation: '123123', is_admin: 'false',role:"replyer",description:"I am studing in Havard currently",gender:"male",school:"Havard",major:"IT",name:"Havard boy"])

create_asker = User.create([email: '2@2', password: '123123', password_confirmation: '123123', is_admin: 'false',role:"asker",description:"I want to study in Havard",gender:"female",major:"IT",name:"Shoot"])
