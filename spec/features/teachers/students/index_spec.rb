require 'rails_helper'

RSpec.describe Teacher do
  describe 'Teacher Students index page' do
    it 'has a link to view teachers students' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincey Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: false, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers/#{teacher1.id}"

      expect(page).to have_link("View Students")

      click_link "View Students"
      expect(current_path).to eq("/teachers/#{teacher1.id}/students")
    end

    it 'should show the teachers students and their attributes' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincey Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: false, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers/#{teacher1.id}/students"

      within ".students" do
        within "#student-#{student1.id}" do
          expect(page).to have_content("Quincey Jones")
          expect(page).to have_content("No")
          expect(page).to have_content("6")

          expect(page).to_not have_content("Aliya Blackmon")
          expect(page).to_not have_content("Prince Miles")
        end
        expect(page).to_not have_content("Aliya Blackmon")
      end
    end

    it 'has a navbar links' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: false, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers/#{teacher1.id}/students"

      expect(page).to have_link("Students")
      click_on "Students"
      expect(current_path).to eq("/students")

      visit "/students"

      expect(page).to have_link("Teachers")
      click_on "Teachers"
      expect(current_path).to eq("/teachers")
    end
  end
end