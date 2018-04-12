class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = current_user.current_room
    if room
      stream_from "room_channel_#{room}"
      stream_from "room_channel_#{room}_#{current_user.id}"
    end
  end

  def unsubscribed
    current_user.update!(current_room: nil)
  end
end
