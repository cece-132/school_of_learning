require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'relationships' do
    it {should validate_presence_of :name}
    it { should allow_value(%w(true false)).for(:otg) }
    it {should validate_presence_of :max_classes}
    it {should validate_presence_of :teacher_id}
  end
  
  describe 'validations' do
    it {should belong_to :teacher}
  end

end
