require 'rails_helper'

RSpec.describe Teacher do
  describe '#show page' do
    it 'can navigate to #show page' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher3 = Teacher.create!(name: "Peter Rosas", license_issued: Time.now,
          renew_license: false, max_students: 32)

      visit "/teachers"

      within ".teachers" do
        expect(page).to have_link("Phyllis Waters")

        click_link "Phyllis Waters"
        expect(current_path).to eq("/teachers/#{teacher1.id}")
      end
    end

    it 'can show the teacher information' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher3 = Teacher.create!(name: "Peter Rosas", license_issued: Time.now,
          renew_license: false, max_students: 32)

      visit "/teachers"
      
      within ".teachers" do
        click_link "Phyllis Waters"
        expect(current_path).to eq("/teachers/#{teacher1.id}")
      end

      expect(page).to have_content("Name: Phyllis Waters")
      expect(page).to have_content("License Issued: #{teacher1.license_issued.strftime("%m/%d/%y")}")
      expect(page).to have_content("License Renewal: No")
      expect(page).to have_content("Start Date: #{teacher1.created_at.strftime("%m/%d/%y")}")
      expect(page).to have_content("Last Update: #{teacher1.updated_at.strftime("%m/%d/%y")}")

      expect(page).to_not have_content("Name: Paul Whitemon")
      expect(page).to_not have_content("Name: Peter Rosas")
    end

    it 'shows the number of students for a teacher' do
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

      expect(page).to have_content("Current Number of Students: #{teacher1.students.count}")
    end

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

      visit "/teachers/#{teacher1.id}"

      expect(page).to have_link("Students")
      click_on "Students"
      expect(current_path).to eq("/students")

      visit "/students"

      expect(page).to have_link("Teachers")
      click_on "Teachers"
      expect(current_path).to eq("/teachers")
    end

    it 'has link to update teacher' do
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

      visit "/teachers/#{teacher1.id}"

      expect(page).to have_link("Update Teacher")
      click_link "Update Teacher"
      expect(current_path).to eq("/teachers/#{teacher1.id}/edit")
    end
    it "can update a teacher" do
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
                                
      visit "/teachers/#{teacher1.id}/edit"
      
      fill_in 'Name', with: 'Shirley Temple', exact: true
      fill_in "When was the teaching license issued?", with: Time.now, exact: true
      select 'false', from: "Does the teachers license need renewal within the next 6 months?"
      fill_in "Max Students per class:", with: 22, exact: true
      
      click_button "Submit"

      expect(current_path).to eq("/teachers/#{teacher1.id}")
      expect(page).to have_content('Shirley Temple')
      expect(page).to_not have_content('Quincy Jones')
    end

    it 'can delete a teacher record' do
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
                                
      visit "/teachers/#{teacher1.id}"

      expect(page).to have_content("Delete #{teacher1.name}")
      click_link "Delete #{teacher1.name}"
      expect(current_path).to eq("/teachers")
      
      within ".teachers" do
        expect(page).to_not have_content("#{teacher1.name}")
      end
    end

  end
end