require 'rails_helper'

RSpec.describe Student do
  describe 'Student Index' do
    it 'shows all the students' do
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

      visit "/students"
      
      within ".students" do
        within "#student-#{student1.id}" do
          expect(page).to have_content("Quincy Jones")
          expect(page).to have_content("Off Track to Graduate: No")
          expect(page).to have_content("Max Classes: 6")          
        end
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
  
        visit "/students"

        within ".topnav" do
          expect(page).to have_link("Students")
          click_link("Students")
          expect(current_path).to eq("/students")
        end

        within(".topnav") do
          visit "/students"

          expect(page).to have_link("Teachers")
          click_link("Teachers")
          expect(current_path).to eq("/teachers")
        end
    end

    it 'has link to sort true records' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: true, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/students"
      expect(page).to have_link("Off Track to Graduate")
      
      expect(student1.name).to appear_before(student2.name) 
      expect(student2.name).to appear_before(student3.name) 
      expect(student3.name).to_not appear_before(student1.name) 
      
      click_link "Off Track to Graduate" # q: blank
      ## This is how I tested the values
      # click_link "Off Track to Graduate" # "s"=>"otg asc"
      # click_link "Off Track to Graduate" # "s"=>"otg desc"
      # click_link "Off Track to Graduate" # "s"=>"otg asc"

      expect(page).to have_content(student3.name)
      expect(page).to have_content(student2.name)
      expect(page).to_not have_content(student1.name)
    end

    it 'can update students from indexpage' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: true, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/students"
      within ".students" do
        within "#student-#{student1.id}" do
          expect(page).to have_link("Update #{student1.name}")
          click_link "Update #{student1.name}"
          expect(current_path).to eq("/students/#{student1.id}/edit") 
        end
      end

    end

  end
end