class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'online_channel'
    current_user.is_online
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
