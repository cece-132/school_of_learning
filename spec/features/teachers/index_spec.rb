require 'rails_helper'

RSpec.describe Teacher do
  describe '#index' do
    it 'lists all teachers' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
                                renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
                                renew_license: false, max_students: 32)
      teacher3 = Teacher.create!(name: "Peter Rosas", license_issued: Time.now,
                                  renew_license: false, max_students: 32)

      visit "/teachers"
      within ".teachers" do
        expect(page).to have_content("Phyllis Waters")
        expect(page).to have_content("Paul Whitemon")
        expect(page).to have_content("Peter Rosas")
      end
    end

    it 'has teacher links' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher3 = Teacher.create!(name: "Peter Rosas", license_issued: Time.now,
          renew_license: false, max_students: 32)      
      
      visit "/teachers"
      within ".teachers" do
        expect(page).to have_link("Phyllis Waters")
        expect(page).to have_link("Paul Whitemon")
        expect(page).to have_link("Peter Rosas")
      end
    end
  end
end