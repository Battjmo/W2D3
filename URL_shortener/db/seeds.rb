# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create!(email: 'CJ@CJ.com')
  user2 = User.create!(email: 'Flarnie@Flarnie.net')
  user3 = User.create!(email: 'Jeff@Geoff.net')
  user4 = User.create!(email: 'Georges St. Pierre@punchy.com')

  ShortenedUrl.destroy_all
  ShortenedUrl.shorten_url(user1, "course2.id")
  ShortenedUrl.shorten_url(user2, "course2.id")
  ShortenedUrl.shorten_url(user3, "larry.com")
  ShortenedUrl.shorten_url(user4, "course1.id")
end
