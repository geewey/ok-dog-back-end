# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Command.delete_all
UserCommand.delete_all
Api.delete_all
ApiCommand.delete_all

user1 = User.create(email: "gordon.lanza@gmail.com")
user2 = User.create(email: "geewey@gmail.com")
user3 = User.create(email: "likoxie@gmail.com")

command1 = Command.create(name: "news")
command2 = Command.create(name: "weather")
command3 = Command.create(name: "jokes")

api1 = Api.create(name: "News API")
api2 = Api.create(name: "DarkSky API")
api3 = Api.create(name: "icanhazdadjoke.com API")

user1.commands << command1
user1.commands << command2

user2.commands << command1
user2.commands << command3

user3.commands << command1
user3.commands << command2
user3.commands << command3

api1.commands << command1
api2.commands << command2
api3.commands << command3