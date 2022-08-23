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
  end
end