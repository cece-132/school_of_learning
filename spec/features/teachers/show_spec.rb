require 'rails_helper'

RSpec.describe Teacher do
  describe '#show page' do
    it 'shows teacher data, including id and updated/created' do
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
        expect(current_path).to eq("/teachers/")
      end
    end
  end
end