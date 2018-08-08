class AchievementsController < ApplicationController
    
    def new 
        @achievement = Achievement.new
    end 
    
    def create 
        @achievement = Achievement.new(achievement_params)

        if @achievement.save
            flash[:notice] = "success"
        else 
            flash[:notice] = "no success"
        end 
        redirect_to root_url
    end 
    
    private 
    
    def achievement_params
        params.require(:achievement).permit(:title, :description, :privacy, :featured)
        
    end 
end
