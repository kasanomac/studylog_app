# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Studytime.create!(studytime_hours: 1, studytime_minutes: 2, memo: 'dijivo', user_id: 2)
Studytime.create!(studytime_hours: 3, studytime_minutes: 21, memo: 'bgrwa', user_id: 3)
Studytime.create!(studytime_hours: 1, studytime_minutes: 10, memo: 'y5whw', user_id: 4)
Studytime.create!(studytime_hours: 4, studytime_minutes: 54, memo: 'hrwqhgraw', user_id: 2)

User.create!(name: "fukase", email: "fukase@gmail.com", password: "fukase1013", password_confirmation: "fukase1013" )
User.create!(name: "saori", email: "saori@gmail.com", password: "saori0813", password_confirmation: "saori0813" )
User.create!(name: "nakaji", email: "nakaji@gmail.com", password: "nakaji1022", password_confirmation: "nakaji1022" )
User.create!(name: "love", email: "love@gmail.com", password: "love0823", password_confirmation: "love0823" )

