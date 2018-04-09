class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_channel_all"
    stream_from "notifications_channel_#{current_user.id}"
  end

  def unsubscribed
  end
end
