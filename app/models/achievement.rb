class Achievement < ActiveRecord::Base
    enum privacy: [:publico, :privato]
    
end
