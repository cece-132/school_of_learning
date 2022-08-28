class Teacher < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :license_issued
  validates :renew_license, inclusion: [true, false]
  validates_presence_of :max_students

  has_many :students

  def student_classes(search_params)
    self.students.where('max_classes >= ?', search_params).order(:max_classes)
  end

  def self.order_student_count
    left_joins(:students).group(:id).order('count(students.id) desc') 
  end

  def self.search_teacher(params)
    if where(name: params).count > 0
      where(name: params)
    else
      where("name like ?", "%#{params}%")
    end
  end

end
