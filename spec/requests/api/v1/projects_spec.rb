require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
  include ApiDoc::V1::Projects::Api

  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @project_url = '/api/v1/projects'

    @login_params = {
      email: @user.email,
      password: @user.password 
    }

    post @login_url, params: @login_params 

    @headers = {
      'access-token' => response.headers['access-token'],
      'client' => response.headers['client'],
      'uid' => response.headers['uid']
    }

  end


  describe "POST /create" do
    include ApiDoc::V1::Projects::Create 

    before do 
      
      @project_params = {

        project: {
          title: "Todo Application",
          description: "A todo application that help people to keep track of all their activities"
  
        }
        
      }

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post '/api/v1/projects/', params: @project_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "new project is created" do
        subject { post @project_url, params: @project_params, headers: @headers } 

        # it "increment Project.count by 1" do
        #   expect{subject}.to change{Project.count}.by(1)  
        # end

        # it "returns http status :created" do
        #   subject
        #   expect(response).to have_http_status(:created)
        # end

        # it "matches with performed job" do
        #   ActiveJob::Base.queue_adapter = :test
        #   ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
          
        #   expect {
        #     subject
        #   }.to have_performed_job(NewProjectJob)
        # end
        
        
      end

      context "project failed to be created" do
        # it "do not increment Project.count " do
        #   expect{subject}.to_not change{Project.count}  
        # end

        # it "returns http status :unprocessable_entity" do
        #   post @project_url, params: {project: {title: "", description: "this is a todo application"}}, headers: @headers
        #   expect(response).to have_http_status(:unprocessable_entity)
        # end
      
      end
      
    end
  
  end


  describe "PUT /update" do
    include ApiDoc::V1::Projects::Update 

    before do 
      @project_url = '/api/v1/projects/todo-application'
      @project_params = {

        project: {
          title: "Todo Application",
          description: "A todo application that help people to keep track of all their activities"
  
        }
        
      }


      create :project, title: "Todo Application", description: "A Todo App", user: @user


    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/projects/todo-application', params: @project_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "project is updated" do
        subject { put @project_url, params: @project_params, headers: @headers } 

        
        it "returns http status :ok" do
          subject
          expect(response).to have_http_status(:ok)
        end
        
        
      end

      context "project failed to be updated" do

        it "returns http status :unprocessable_entity" do
          put @project_url, params: {project: {title: "", description: "this is a todo application"}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end

      context "project could not be found" do
        it "returns http status :not_found" do
          put '/api/v1/projects/todo', headers: @headers, params: @project_params
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end


  describe "DELETE /destroy" do
    include ApiDoc::V1::Projects::Destroy 

    before do 
      @project_url = '/api/v1/projects/todo-application'
      
      create :project, title: "Todo Application", description: "A Todo App", user: @user

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        delete '/api/v1/projects/todo-application'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "project is deleted" do
        subject { delete @project_url, headers: @headers } 

        
        it "returns http status :no_content" do
          subject
          expect(response).to have_http_status(:no_content)
        end

        it "return nil project" do
          subject
          expect(Project.friendly.find_by_slug('todo-application')).to eq(nil)  
          
        end 
        
      end

      context "project could not be found" do
        it "returns http status :not_found" do
          delete '/api/v1/projects/todo', headers: @headers
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end


  describe "GET /show" do
    include ApiDoc::V1::Projects::Show 

    before do 
      @project_url = '/api/v1/projects/todo-application'
      
      create :project, title: "Todo Application", description: "A Todo App", user: @user

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get '/api/v1/projects/todo-application'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "project is found" do
        subject { get @project_url, headers: @headers } 

        
        it "returns http status :ok" do
          subject
          expect(response).to have_http_status(:ok)
        end

        it "returns project as json response" do
          get '/api/v1/projects/todo-application', headers: @headers
          json_data = JSON.parse(response.body)

          
          expect(json_data['project']).to  include({
            'title' => 'Todo Application',
            'description' => 'A Todo App'
          })
        end
        
        
      end

      context "project could not be found" do
        it "returns http status :not_found" do
          get '/api/v1/projects/todo', headers: @headers
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end


  describe "POST /upvote" do
    include ApiDoc::V1::Projects::Upvote

    before do 
     
      @searched_user = create :user, name: "paul obi"
      @project = create :project, title: "todo application", user: @searched_user, description: "A real world todo application"
      @project_url = "/api/v1/projects/todo-application/voters"
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "project could not be found " do
        it "returns http status :not_found" do
          post '/api/v1/projects/sdfsrdeds/voters', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "current user vote a project" do

        it "increment project votes" do
          
          expect{post @project_url, headers: @headers}.to change{@project.get_upvotes.size}.by(1) 
        end

        it "returns http status :ok" do
          post @project_url, headers: @headers

          
          expect(response).to have_http_status(:ok) 
        end

      end

     

    end
    
  end


  describe "POST /downvote" do
    include ApiDoc::V1::Projects::Downvote

    before do 
     
      @searched_user = create :user, name: "paul obi"
      @project = create :project, title: "todo application", user: @searched_user, description: "A real world todo application"
      @project_url = "/api/v1/projects/todo-application/voters"
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        delete @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "project could not be found " do
        it "returns http status :not_found" do
          delete '/api/v1/projects/sdfsrdeds/voters', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "current user vote a project" do

        it "increment project votes" do
          
          expect{delete @project_url, headers: @headers}.to change{@project.get_downvotes.size}.by(1) 
        end

        it "returns http status :ok" do
          delete @project_url, headers: @headers

          
          expect(response).to have_http_status(:ok) 
        end

      end

     

    end
    
  end


  describe "POST /up" do
    include ApiDoc::V1::Projects::Up

    before do 
      @searched_user = create :user, name: "paul obi"
      @project = create :project, title: "todo application", user: @searched_user, description: "A real world todo application"
      @project_url = "/api/v1/projects/todo-application/likes"
      
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "project could not be found " do
        it "returns http status :not_found" do
          post '/api/v1/projects/sdfsrdeds/likes', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      
      context "current user  likes a project" do

        it "increment project likes" do
          
          expect{post @project_url, headers: @headers}.to change{@project.get_likes.size}.by(1)
        end

        it "returns http status :ok" do
          post @project_url, headers: @headers

          
          
          expect(response).to have_http_status(:ok) 
        end

      end
 
    end
    
  end


  describe "DELETE /down" do
    include ApiDoc::V1::Projects::Down

    before do 
      @searched_user = create :user, name: "paul obi"
      @project = create :project, title: "todo application", user: @searched_user, description: "A real world todo application"
      @project_url = "/api/v1/projects/todo-application/likes"
      @user.likes @project
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        delete @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "project could not be found " do
        it "returns http status :not_found" do
          delete '/api/v1/projects/sdfsrdeds/likes', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      
      context "current user  unlikes an  project" do

        it "decrement project likes" do
          
          expect{delete @project_url, headers: @headers}.to change{@project.get_likes.size}.from(1).to(0)
        end

        it "returns http status :ok" do
          delete @project_url, headers: @headers
          expect(response).to have_http_status(:ok) 
        end

      end
 
    end
    
  end




  describe "GET /suggestion_index" do
    include ApiDoc::V1::Projects::SuggestionIndex

    before do 
      @searched_user = create :user, name: "paul obi"
      @project = create :project, title: "todo application", user: @searched_user, description: "A real world todo application"
      @project_url = "/api/v1/projects/todo-application/suggestions"

      20.times do |sug|
        create :suggestion, content: "#{sug} make the button on the left edge align", project: @project, user: @user

      end
     
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url, params: {page: 1}
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated" do

      context "project could not be found " do
        it "returns http status :not_found" do
          get '/api/v1/projects/sdfsrdeds/suggestions', params: {page: 2}, headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end

      context "page params exists" do

        before do 
          get @project_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user followings" do
          
          #expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @project_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user followings" do
        
          #expect(@json_data.length).to eq(10)
        end
        
      end
      
      
    end
    


    
  end



  describe "GET /project_index" do
    include ApiDoc::V1::Projects::Index

    before do 

      20.times do |n|
        create :project, user: @user
      end


      @project_url = '/api/v1/projects'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      

      context "page params exists" do

        before do 
          get @project_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user projects" do
          
          #expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @project_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user projects" do
        
          #expect(@json_data.length).to eq(10)
        end
        
      end
      
    end
    
  end







   describe "GET /suggestion_index" do
    include ApiDoc::V1::Projects::SuggestionIndex

    before do 
      @searched_user = create :user, name: "paul obi"
      @project = create :project, title: "todo application", user: @searched_user, description: "A real world todo application"
      @project_url = "/api/v1/projects/todo-application/notes"


      create :note, user: @searched_user, project: @project, content: "work on react part"
      create :note, user: @searched_user, project: @project, content: "make some part of the code to be really stable"
      create :note, user: @user, project: @project, content: "code having some really odd issue"
      create :note, user: @user, project: @project, content: "work on the project now"

      
     
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated" do

      context "the json_data is being served " do 

        before do 

          get @project_url, headers: @headers


          @json_data = JSON.parse(response.body)
          

        end

        it "returns proper first json response " do 

          expect(@json_data.first).to include({
            'content' =>  'work on the project now' 
          })
        end

         it "returns proper last json response " do 

          expect(@json_data.last).to include({
            'content' => 'work on react part'
          })
        end

      end


      context "project could not be found " do
        it "returns http status :not_found" do
          get '/api/v1/projects/sdfsrdeds/notes', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      
    end
    


    
  end

end
