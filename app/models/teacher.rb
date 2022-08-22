class Teacher < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :license_issued
  validates_presence_of :renew_license
  validates_presence_of :max_students

  has_many :students
end
