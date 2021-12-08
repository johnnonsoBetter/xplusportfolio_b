class Api::V1::UsersController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:index, :show, :project_index, :suggestion_index, :anticipation_index, :follower_index] 
    before_action :find_user, only: [:show, :project_index, :suggestion_index, :anticipation_index, :follower_index]
   
    def index 
        if params[:page].present?
            @pagy, @users = pagy(User.all, page: params[:page])
        else
            @pagy, @users = pagy(User.all, page: 1)
        end
        render 'api/v1/users/index.json.jbuilder'
    end


    def show 
        render 'api/v1/users/show.json.jbuilder'
    end

    def project_index 
        if params[:page].present?    
            @pagy, @projects = pagy(@user.projects, page: params[:page])
        else
            @pagy, @projects = pagy(@user.projects, page: 1)
        end

        render 'api/v1/users/project_index.json.jbuilder'
    end

    def anticipation_index 
        if params[:page].present?  
              
            @pagy, @anticipations = pagy(@user.anticipations.includes(:anticipation_cover), page: params[:page])
        else
            @pagy, @anticipations = pagy(@user.anticipations.includes(:anticipation_cover), page: 1)
        end
        render 'api/v1/users/anticipation_index.json.jbuilder'
    end


    def suggestion_index
        if params[:page].present?    
            @pagy, @suggestions = pagy(@user.suggestions.includes(:user), page: params[:page])
        else
            @pagy, @suggestions = pagy(@user.suggestions.includes(:user), page: 1)
        end
        render 'api/v1/users/suggestion_index.json.jbuilder'
    end

    def follower_index 
        if params[:page].present?    
            @pagy, @followers = pagy(followers, page: params[:page])
        else
            @pagy, @followers = pagy(followers, page: 1)
        end
        render 'api/v1/users/follower_index.json.jbuilder'
    end

 
    private 
    def find_user 
        @user = User.all.friendly.find_by_slug(params[:id]) 
        unless @user 
            render json: 'Not Found', message: "User does not exist", status: :not_found
        end
    end

    def followers 
        User.where({id: @user.followers})
    end
end
