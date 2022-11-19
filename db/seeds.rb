# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'ikeda',
              email: 'ikeda@example.com',
              password: 'ikedaikeda',
              password_confirmation:'ikedaikeda',
              created_at: "2022-11-11 04:41:14", 
              updated_at: "2022-11-11 04:41:14",
              admin: true)

10.times do |num|
  User.create!(name: "yua#{num + 1}",
              email: "yua#{num + 1}@example.com",
              password: "777666#{num + 1}",
              password_confirmation: "777666#{num + 1}"
              )
end

10.times do |num|
  Task.create!(name: "don#{num + 1}",
              detail: "dond#{num + 1}",
              user_id: rand(20..31)
              )
end              

10.times do |num|
  Label.create!(name:"label#{num}")
end