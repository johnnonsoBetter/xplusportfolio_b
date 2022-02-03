require 'rails_helper'

RSpec.describe "Api::V1::Notifications", type: :request do
  include ApiDoc::V1::Notifications::Api

  describe "GET /index" do
    include ApiDoc::V1::Notifications::Index
    before do 
      @user = create :user
      @user.confirm
      @login_url = '/api/v1/auth/sign_in'

      @user_params = {
        email: @user.email,
        password: @user.password
      }

      @notifications_url = '/api/v1/notifications'

      post @login_url, params: @user_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

      
     
    end



    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @notifications_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do


      before do 

        20.times do |n|
          create :notification, recipient: @user
        end

      end

      

      context "page params exists" do

        before do 
          get @notifications_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user notifications" do
          
          expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @notifications_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user notifications" do
        
          expect(@json_data.length).to eq(10)
        end
        
      end
      
    end




  end



end