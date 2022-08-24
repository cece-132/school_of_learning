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

    it 'can sort by created_at' do
      # As a visitor
      # When I visit the Teacher index,
      # I see that records are ordered by most recently created first
      # And next to each of the records I see when it was created

      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Paul Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher3 = Teacher.create!(name: "Peter Rosas", license_issued: Time.now,
          renew_license: false, max_students: 32)      
      
      visit "/teachers"

      within ".teachers" do
        expect(teacher1.name).to appear_before(teacher2.name)
        expect(teacher2.name).to appear_before(teacher3.name)
        expect(teacher3.name).to_not appear_before(teacher1.name)
      end

      within ".teachers" do
        within "#teacher-#{teacher1.id}" do
          expect(page).to have_content("Phyllis Waters, Started At: #{teacher1.created_at.strftime("%m/%d/%y")}")
        end
      end
    end
  end
end