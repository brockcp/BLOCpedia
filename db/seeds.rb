
require 'random_data'
require 'faker'

Faker::UniqueGenerator.clear

5.times do
    User.create!(
        email: Faker::Internet.unique.email,
        password: Faker::Internet.password(6, 14)
    )
end
users= User.all

5.times do
    Wiki.create!(
        user: users.sample,
        title: Faker::GameOfThrones.character,
        body: Faker::GameOfThrones.quote
    )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
