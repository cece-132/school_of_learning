require 'rails_helper'

RSpec.describe Teacher do
  describe "New teacher form" do
    it 'has a form to create a new teacher' do
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

      visit "/teachers/new"
      
      fill_in 'Name', with: 'Shirley Temple', exact: true
      fill_in "When was the teaching license issued?", with: Time.now, exact: true
      select 'false', from: "Does the teachers license need renewal within the next 6 months?"
      fill_in "Max Students per class:", with: 22, exact: true

      click_button "Submit"

      expect(current_path).to eq("/teachers")

      within('.teachers') do
        expect(page).to have_content('Shirley Temple')
      end
    end
  end
end