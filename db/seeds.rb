# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#teachers
teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now, renew_license: false, max_students: 32)
teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now, renew_license: false, max_students: 32)
teacher3 = Teacher.create!(name: "Peter Rosas", license_issued: Time.now, renew_license: false, max_students: 32)