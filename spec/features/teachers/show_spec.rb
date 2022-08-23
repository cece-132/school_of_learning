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
    
  end
end