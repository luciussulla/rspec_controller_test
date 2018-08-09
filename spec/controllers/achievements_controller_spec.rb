require 'rails_helper'

RSpec.describe AchievementsController, type: :controller do

# guest user 

    describe "guest user" do 
        
        describe "GET Index" do 
            it "renders index" do 
                get :index 
                expect(response).to render_template(:index)
            end    
            
            it "assigns only publico achievements" do 
                public_a = FactoryGirl.create(:public_achievements) 
                get :index
                expect(assigns(:public_achievements)).to match_array([public_a])
            end 
        end 
        
        describe "GET show" do 
            let(:achievement) {FactoryGirl.create(:achievement)}
            
            it "Renders :show tempate" do 
                get :show, id: achievement.id
                expect(response).to render_template(:show)
            end 
            
            it "Assigns requred achievement to @achievement" do 
                expect(achievement.privacy).to eq("privato")
            end 
        end 
        
        describe "GET new" do 
            it "renders :new temple" do 
                get :new
                expect(response).to redirect_to(new_user_session_url)
            end  
            it "assigns Achievement to @achevement" do 
                get :new 
                expect(assigns(:achievement)).to redirect_to(new_user_session_url)
            end 
        end 
        describe "POST create" do 
            
            it "post redirects to achievements#show" do 
                post :create, achievement: FactoryGirl.attributes_for(:achievement)
                expect(response).to redirect_to(new_user_session_url)
            end 
        end
    end 
    
# end of guest user
# begin of authernicated user

   describe "authenticated user" do 
       let(:user) {FactoryGirl.create(:user)}
       
       before do 
        sign_in(user)
       end 
       
       context "user not owne of resource" do 
           describe "GET Index" do 
                it "renders index" do 
                    get :index 
                    expect(response).to render_template(:index)
                end    
                
                it "assigns only publico achievements" do 
                    public_a = FactoryGirl.create(:public_achievements) 
                    get :index
                    expect(assigns(:public_achievements)).to match_array([public_a])
                end 
            end 
            
            describe "GET show" do 
                let(:achievement) {FactoryGirl.create(:achievement)}
                
                it "Renders :show tempate" do 
                    get :show, id: achievement.id
                    expect(response).to render_template(:show)
                end 
                
                it "Assigns requred achievement to @achievement" do 
                    expect(achievement.privacy).to eq("privato")
                end 
            end 
            
            describe "POST create" do 
                context "valid data" do 
                    it "post redirects to achievements#show" do 
                        post :create, achievement: FactoryGirl.attributes_for(:achievement)
                        expect(response).to redirect_to(achievement_path(assigns[:achievement]))
                    end 
                    
                    it "creates a new achievement in db" do 
                        expect {
                            post :create, achievement: FactoryGirl.attributes_for(:achievement)
                        }.to change(Achievement, :count).by(1)
                    end 
                end 
            
                context 'invalid data' do 
                    let(:invalid_data) {FactoryGirl.attributes_for(:achievement, title: "")}
                    it 'does not create achievement' do 
                        post :create, achievement: invalid_data
                        expect(response).to render_template(:new)
                    end 
                    it "achievement not created in db" do 
                       expect { 
                           post :create, achievement: invalid_data
                       }.to change(Achievement, :count).by(0) 
                    end
                end 
            end
        
            describe "Achievement #edit " do 
                let(:achievement) {FactoryGirl.create(:achievement)}
                it "renders :edit" do 
                    get :edit, id: achievement.id
                    expect(response).to redirect_to achievements_path
                end
            end 
        end 
        context "user owner of the resouce" do 
            let(:achievement) {FactoryGirl.create(:achievement, user: user)}
            
            describe "authorized user" do
                describe "POST create" do 
                    context "valid data" do 
                        it "post redirects to achievements#show" do 
                            post :create, achievement: FactoryGirl.attributes_for(:achievement)
                            expect(response).to redirect_to(achievement_path(assigns[:achievement]))
                        end 
                        
                        it "creates a new achievement in db" do 
                            expect {
                                post :create, achievement: FactoryGirl.attributes_for(:achievement)
                            }.to change(Achievement, :count).by(1)
                        end 
                    end 
                    context 'invalid data' do 
                        let(:invalid_data) {FactoryGirl.attributes_for(:achievement, title: "")}
                        it 'does not create achievement' do 
                            post :create, achievement: invalid_data
                            expect(response).to render_template(:new)
                        end 
                        it "achievement not created in db" do 
                           expect { 
                               post :create, achievement: invalid_data
                           }.to change(Achievement, :count).by(0) 
                        end
                    end 
                end 
                
                describe "Achievement #edit " do 
                    it "renders :edit" do 
                        get :edit, id: achievement.id
                        expect(response).to render_template(:edit)
                    end 
                    it "assignes the @achivement to templace" do 
                        get :edit, id: achievement.id 
                        expect(assigns(:achievement)).to eq(achievement)
                    end 
                end 
                
                describe "Achievement #update" do 
                    context "when valid data submitted" do 
                        let(:valid_data) {FactoryGirl.attributes_for(:achievement, title: "edited")}
                        
                        it "redirect_to the show achievement" do 
                            put :update, id: achievement.id, achievement: valid_data
                            expect(response).to redirect_to achievement_path(assigns(:achievement))
                        end 
                        
                        it "updates the db entry" do
                            put :update, id: achievement.id, achievement: valid_data
                            achievement.reload
                            expect(achievement.title).to eq("edited")
                        end 
                    end 
                end 
                
                describe "Delete" do 
                    it "redirect after destroy" do
                        delete :destroy, id: achievement.id 
                        expect(response).to redirect_to root_url
                    end 
                    
                    it "chnges the db status" do 
                         delete :destroy, id: achievement.id, method: :delete
                         expect(Achievement.exists?(achievement)).to be_falsey
                    end
                end 
            end
        end 
   end 
end

