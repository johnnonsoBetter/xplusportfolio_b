# To deliver this notification:
#
# NewProjectNotification.with(post: @post).deliver_later(current_user)
# NewProjectNotification.with(post: @post).deliver(current_user)

class NewProjectNotification < Noticed::Base
  # Add your delivery methods
  #
   deliver_by :database
   deliver_by :email, mailer: "ProjectMailer"
   deliver_by :action_cable, channel: WallChannel, format: :action_cable_data
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
   param :project

   def to_database 
    {
      message: @project.title
    }
   end

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message")
  end

  def custom_stream
    "user_#{recipient.id}"
  end
  def action_cable_data
    { user_id: recipient.id }
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
