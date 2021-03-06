module ApiDoc
    module V1
      module Notifications
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Notification' do
            endpoint '/notifications'
            group 'Notification'
            desc 'notifications.md'
          end
        end
  
        document :index do
          action 'Get notifications'
        end

        document :update do 
          action "Update Notification"
        end


        document :mark_all do 

          action "Mark All notifications"
        end
  
        
  
      
      end
    end
  end