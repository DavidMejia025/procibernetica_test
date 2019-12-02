# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

clear_db = -> () {
  Task.destroy_all
  Category.destroy_all
  Comment.destroy_all
}

create_task = -> (status) do
  category =  rand(2) != 0 ? Category.all.sample : Category.first

  rand_date = rand(3) == 0 ? Date.today - 7 : Date.today + 7

  category.tasks.create(
    title:       Faker::Name.name_with_middle,
    description: Faker::Lorem.paragraph(sentence_count: 7),
    status:      status,
    deadline:   rand_date
  )
end

create_comments = -> (task) do
  number = rand(3)

  number.times do |i|
    task.comments.create(text: Faker::Lorem.sentences)
  end
end

clear_db.call

Category.create(name: "General")

6.times do |i|
  Category.create(name: Faker::Name.name_with_middle)
end

10.times do |i|
  create_task.call(:to_do)
end

10.times do |i|
  create_task.call(:done)
end

Task.all.each do |task|
  create_comments.call(task)
end
