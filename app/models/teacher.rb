class Teacher < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :license_issued
  validates :renew_license, inclusion: [true, false]
  validates_presence_of :max_students

  has_many :students
end
