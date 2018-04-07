class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearance_channel'
    current_user.update!(online: true)
  end

  def unsubscribed
    current_user.update!(online: false)
  end
end
