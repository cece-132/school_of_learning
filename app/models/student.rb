class Student < ApplicationRecord
  validates_presence_of :name
  validates :otg, inclusion: [true, false]
  validates_presence_of :max_classes
  validates_presence_of :teacher_id
  
  belongs_to :teacher
end
