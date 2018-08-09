FactoryGirl.define do
  factory :achievement do
    title "Title"
    description "Description"
    privacy 'privato'
    featured false
    cover_image "MyString"
    
    factory :public_achievements do 
      privacy 'publico'
    end 

  end
end