# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'ignacio@acid.cl', status: 401)
User.create(email: 'iverdejo@acid.cl', status: 200)
User.create(email: 'ignatg@gmail.com', status: 200)
User.create(email: 'ignatg2@gmail.com', status: 401)