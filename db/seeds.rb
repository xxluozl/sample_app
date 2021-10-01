# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'create administrator'
User.create(
  name: '怪诞奇遇',
  email: 'zhonglinluo@foxmail.com',
  password: '123456',
  password_confirmation: '123456',
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

puts 'create others users'
199.times do
  User.create(
    name: FFaker::NameCN.name,
    email: FFaker::Internet.email,
    password: '123456',
    password_confirmation: '123456',
    activated: true,
    activated_at: Time.zone.now
  )
end