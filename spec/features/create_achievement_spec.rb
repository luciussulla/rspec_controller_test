require 'rails_helper'
feature 'create new achievement' do 
    
    scenario 'can create new achievement' do
        
        visit('/')
        click_on "new achievement"
        
        fill_in('achievement_title', with: "new title")
        fill_in("achievement_description", with: "description") 
        select("Publico", from: "achievement_privacy") 
        check("Featured")
        click_on("Submit")
        
        expect(page).to have_content("success")
        expect(Achievement.last.title).to eq("new title")
        
    end 
end 