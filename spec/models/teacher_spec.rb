require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :license_issued }
    it { should allow_value(%w(true false)).for(:renew_license) }
    it { should validate_presence_of :max_students }
  end

  describe 'relationships' do
    it { should have_many :students}
  end

  describe 'instance methods' do
    describe 'student_classes(search_params' do
      it "can find students with classes >= search_params" do
        teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
          renew_license: false, max_students: 32)
        student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
                            teacher_id: teacher1.id)
        student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
                            teacher_id: teacher1.id)
        student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
                            teacher_id: teacher1.id)
          
        expected = ([student1, student2])
        expect(teacher1.student_classes("6")).to eq(expected)
      end
    end
  end

  describe 'model methods' do
    describe 'order_student_count' do
      it 'can order teachers by student count' do
        teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
          renew_license: false, max_students: 32)
        teacher2 = Teacher.create!(name: "Alpha Whitemon", license_issued: Time.now,
          renew_license: false, max_students: 32)
        student1 = Student.create!(name: "Quincy Jones", otg: false, max_classes: 6,
          teacher_id: teacher2.id)
        student2 = Student.create!(name: "Aliya Blackmon", otg: false, max_classes: 8,
          teacher_id: teacher2.id)
        student3 = Student.create!(name: "Prince Miles", otg: true, max_classes: 5,
          teacher_id: teacher1.id)

        expected = [teacher2, teacher1]  
              
        expect(Teacher.order_student_count).to eq(expected)
      end
    end

    describe 'search_teacher(params)' do
      it 'can find exact name matches' do
        teacher1 = Teacher.create!(name: "Phyllis Waters", license_issued: Time.now,
          renew_license: false, max_students: 32)
        teacher2 = Teacher.create!(name: "Alpha Whitemon", license_issued: Time.now,
          renew_license: false, max_students: 32)

        expect(Teacher.search_teacher("Alpha Whitemon")).to eq([teacher2])
      end

      it 'can find names with partial searches' do
        teacher1 = Teacher.create!(name: "Allen Waters", license_issued: Time.now,
          renew_license: false, max_students: 32)
        teacher2 = Teacher.create!(name: "Alpha Whitemon", license_issued: Time.now,
          renew_license: false, max_students: 32)

        expect(Teacher.search_teacher("Al")).to eq([teacher1, teacher2])
      end
    end
  end
end
