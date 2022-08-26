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

      visit "/teachers"

      expect(page).to have_link("Students")
      click_on "Students"
      expect(current_path).to eq("/students")

      visit "/students"

      expect(page).to have_link("Teachers")
      click_on "Teachers"
      expect(current_path).to eq("/teachers")
    end

    it 'new teacher link' do
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

      visit "/teachers"

      expect(page).to have_link("New Teacher")
      click_link "New Teacher"
      expect(current_path).to eq("/teachers/new")
    end

    it 'can sort alphabetically' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Abby Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: false, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers"
      expect(page).to have_link("Sort Alphabetically")

      expect(teacher1.name).to appear_before('Abby Whitemon')
      expect(teacher2.name).to_not appear_before('Phyllis Waters')

      click_link "Sort Alphabetically"

      expect(teacher1.name).to_not appear_before(teacher2.name)
      expect(teacher2.name).to appear_before(teacher1.name)
    end

    it 'can update a teacher from the index' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Abby Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: false, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers"


      within ".teachers" do
        within "#teacher-#{teacher1.id}" do
          expect(page).to have_link("Update #{teacher1.name}")
          click_link "Update #{teacher1.name}"
          expect(current_path).to eq("/teachers/#{teacher1.id}/edit")
        end
      end

    end

    it 'can delete a teacher' do
      teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
        renew_license: false, max_students: 32)
      teacher2 = Teacher.create!(name: "Abby Whitemon", license_issued: Time.now,
        renew_license: false, max_students: 32)

      student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                                teacher_id: teacher1.id)
      student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                                teacher_id: teacher2.id)
      student3 = Student.create!(name: "Prince Miles", otg: false, max_classes: 5,
                                teacher_id: teacher1.id)

      visit "/teachers"
      within ".teachers" do
        within "#teacher-#{teacher1.id}" do
          expect(page).to have_content("Delete")
          click_link "Delete"
          expect(current_path).to eq("/teachers")
        end
      end
      
      within ".teachers" do
        expect(page).to_not have_content("#{teacher1.name}")
      end

    end
  end
end