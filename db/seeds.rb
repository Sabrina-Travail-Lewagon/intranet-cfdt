# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Create user admin"
User.create(email: "sabrina@test.com", first_name: "Sabrina", last_name:"Test", role: "admin", password: "123456")
User.create(email: "wes@test.com", first_name: "Wes", last_name:"Test", role: "user", password: "123456")
puts "Users créés"
