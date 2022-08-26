require 'rails_helper'

RSpec.describe Student do
  describe '#show page'do
    it 'navigates to the show page' do
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
      visit "/students"

      within ".students" do
        within "#student-#{student1.id}" do
          expect(page).to have_link("Quincey Jones")        
          click_link "Quincey Jones"
          expect(current_path).to eq("/students/#{student1.id}")
        end
      end
    end

    it 'shows all the student information' do
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
      visit "/students/#{student1.id}"

      expect(page).to have_content("Quincey Jones")
      expect(page).to have_content("No")
      expect(page).to have_content("6")
      expect(page).to have_content("Phyllis Waters")
      expect(page).to have_content("#{student1.created_at.strftime("%m/%d/%y")}")
      expect(page).to have_content("#{student1.updated_at.strftime("%m/%d/%y")}")

      expect(page).to_not have_content("Aliya Blackmon")
      expect(page).to_not have_content("Prince Miles")
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

      visit "/students/#{student1.id}"

      expect(page).to have_link("Students")
      click_on "Students"
      expect(current_path).to eq("/students")

      visit "/students"

      expect(page).to have_link("Teachers")
      click_on "Teachers"
      expect(current_path).to eq("/teachers")
    end

    it 'has a link to update a student' do
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

      visit "/students/#{student1.id}"

      expect(page).to have_link("Update Student")
      click_link "Update Student"
      expect(current_path).to eq("/students/#{student1.id}/edit")
    end

    it 'can update student information' do
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

      visit "/students/#{student1.id}/edit"

      fill_in 'Name', with: 'Shirley Temple', exact: true
      select 'false', from: "otg"
      select "7", from: "max_classes", exact: true

      click_button "Submit"

      expect(current_path).to eq("/students/#{student1.id}")
      expect(page).to have_content('Shirley Temple')
      expect(page).to have_content('No Max Classes: 7')
      expect(page).to_not have_content(' No Max Classes: 6')
      expect(page).to_not have_content('Quincy Jones')
    end
  end
end