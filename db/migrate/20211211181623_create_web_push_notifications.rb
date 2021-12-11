class CreateWebPushNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :web_push_notifications do |t|
      t.string :endpoint
      t.string :auth_key
      t.string :p256dh_key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
