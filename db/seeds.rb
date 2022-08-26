# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#teachers
teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
  renew_license: false, max_students: 32)
teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
  renew_license: false, max_students: 32)

student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                          teacher_id: teacher1.id)
student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                          teacher_id: teacher2.id)
student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
                          teacher_id: teacher1.id)