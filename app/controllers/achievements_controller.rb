class AchievementsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :owners_only, only: [:edit, :update, :destroy]
    # this allows us to remove the @achievement from edit
    
    def index 
        @public_achievements = Achievement.publico    
    end 
    
    def new 
        @achievement = Achievement.new
    end 
    
    def create 
        @achievement = Achievement.new(achievement_params)

        if @achievement.save
            flash[:notice] = "success"
            redirect_to achievement_path(@achievement)
        else 
            flash[:notice] = "no success"
            render :new
        end 
    end 
    
    def show 
        @achievement = Achievement.find(params[:id])
    end 
    
    def edit 
        
    end 
    
    def update 
        @achievement = Achievement.find(params[:id])
     
        if @achievement.update_attributes(achievement_params) 
            redirect_to achievement_path(@achievement)
        else 
            render(:edit)
        end 
    end 
    
    def destroy 
        @achievement = Achievement.find(params[:id])
        if @achievement.destroy
            flash[:notice] = "success"
            redirect_to root_url
        else 
            flash[:notice] = "failure"
            redirect_to root_url
        end 
        
    end 
    
    private 
    
    def achievement_params
        params.require(:achievement).permit(:title, :description, :privacy, :featured)
    end  
    
    def owners_only 
        @achievement = Achievement.find(params[:id])
        if current_user != @achievement.user 
            redirect_to achievements_path
        end 
    end 
    
end
