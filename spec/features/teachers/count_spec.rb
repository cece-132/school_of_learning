require 'rails_helper'

RSpec.describe Teacher do
  describe 'EXTENSION: teacher.students.count' do
    it 'has a button to sort by student count' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Alpha Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)
      
      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
                                teacher_id: teacher1.id)
      visit '/teachers'

      expect(page).to have_link("Sort by Student Count")
      click_link "Sort by Student Count"
      expect(current_path).to eq("/teachers/count")
      
      within ".teachers" do
        within "#teacher-#{teacher1.id}" do
          expect(page).to have_content("Student Count: 2")
        end
      end


      click_link "Teachers"
      expect(current_path).to eq("/teachers")
    end
  end
end