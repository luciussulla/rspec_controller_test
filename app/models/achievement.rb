class Achievement < ActiveRecord::Base
    validates :title, presence: true 
    enum privacy: [:publico, :privato]
    belongs_to :user
end

