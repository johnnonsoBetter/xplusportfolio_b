# To deliver this notification:
#
# AnticipationSubscriptionNotification.with(post: @post).deliver_later(current_user)
# AnticipationSubscriptionNotification.with(post: @post).deliver(current_user)

class AnticipationSubscriptionNotification < Noticed::Base
   include BroadcastToUsersHelper
  # Add your delivery methods
  #
  deliver_by :database
   # deliver_by :email, mailer: "AnticipationMailer", delay: 1.hour, unless: :read?
  # deliver_by :slack
  deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?

  # Add required params

   param :anticipation, :action_owner, :total_performers

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  after_database :broadcast_anticipation_subscription


  def webpush_data 
    @anticipation = record[:params][:anticipation]
    @action_owner = record[:params][:action_owner]
    @total_performers = record[:params][:total_performers]


    {
      title: "New Anticipation Subscriber",
      body: "Your anticipation, #{@anticipation.body} has a new subscriber",
      action_owner: @action_owner,
      total_performers: @total_performers
    }
  end

  def action_cable_data
    { anticipation: record[:params][:anticipation] }
  end


  private 

   def broadcast_anticipation_subscription
    # Logic for sending the notification

    anticipation = params[:anticipation]
    

    user = anticipation.user

    users = []
    users.push(user)

    relay_message_from(@recipient, 'anticipation_subscription_channel', users, false)

  end

  
end
