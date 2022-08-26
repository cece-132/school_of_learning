class Teacher < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :license_issued
  validates :renew_license, inclusion: [true, false]
  validates_presence_of :max_students

  has_many :students

  def self.search_students(search_param, teacher_id)
    if search_param
      teacher = Teacher.find(teacher_id)
      teacher.students.all
      students = teacher.find_by(max_classes: search_param)
      if students
        self.where(teacher_id: students)
      else
        teacher = Teacher.find(teacher_id)
        teacher.students.all
      end
    else
      teacher = Teacher.find(teacher_id)
      teacher.students.all
    end
  end
end
