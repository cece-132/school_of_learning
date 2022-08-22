require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :license_issued }
    it { should validate_presence_of :renew_license }
    it { should validate_presence_of :max_students }
  end

  describe 'relationships' do
    it { should have_many :students}
  end
end
