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
    it "can sort students by number of max classes" do
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
