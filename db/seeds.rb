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


# "title"
# "description"
# "vote"
# "is_hidden"
# "user_id"
# "created_at",  null: false
# "updated_at"

create_question = Question.create([title:'问题一',description:'问题一的描述',user_id:1])
create_question = Question.create([title:'问题二',description:'问题二的描述',user_id:1])
create_question = Question.create([title:'问题三',description:'问题三的描述',user_id:1])

create_question = Question.create([title:'问题四',description:'问题四的描述',user_id:2])
create_question = Question.create([title:'问题五',description:'问题五的描述',user_id:2])
create_question = Question.create([title:'问题六',description:'问题六的描述',user_id:2])
