require 'rails_helper'

RSpec.describe Achievement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  describe 'validations' do 
      it "requires title" do 
         achievement = Achievement.new(title: '') 
         expect(achievement.valid?).to be_falsy
      end 
  end 
end
