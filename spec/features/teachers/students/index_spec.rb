require 'rails_helper'

RSpec.describe Teacher do
  describe 'Teacher Students index page' do
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

    it "create students link for teacher" do
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

      expect(page).to have_link("Create Student")
      click_link "Create Student"
      expect(current_path).to eq("/teachers/#{teacher1.id}/students/new")
    end

    it 'can create a new student' do
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

      visit "/teachers/#{teacher1.id}/students/new"
      fill_in 'Name', with: 'Shirley Temple', exact: true
      select 'false', from: "otg"
      select "6", from: "max_classes", exact: true

      click_button "Submit"

      expect(current_path).to eq("/teachers/#{teacher1.id}/students")

      within('.students') do
        expect(page).to have_content('Shirley Temple')
      end
    end

    it 'can sort students by otg' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: true, max_classes: 8,
                                teacher_id: teacher1.id)
      student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers/#{teacher1.id}/students"

      expect(page).to have_link("Off Track to Graduate")

      click_link "Off Track to Graduate"
      
      expect(page).to have_content(student3.name)
      expect(page).to have_content(student2.name)
      expect(page).to_not have_content(student1.name)
    end

    it 'can sort students by alphabetically' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: true, max_classes: 8,
                                teacher_id: teacher1.id)
      student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers/#{teacher1.id}/students"

      expect(page).to have_link("Sort Alphabetically")

      click_link "Sort Alphabetically"
      
      expect(student2.name).to appear_before(student3.name)
save_and_open_page
      expect(student3.name).to appear_before(student1.name)
      expect(student1.name).to_not appear_before(student2.name)

    end
  end
end