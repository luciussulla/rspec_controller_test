require 'rails_helper'
require_relative '../support/login_form'

feature 'create new achievement' do
    let(:user) { FactoryGirl.create(:user)}
    let(:login_form) { LoginForm.new }

    scenario 'can create new achievement' do
        login_form.visit_page.login_as(user)
        
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