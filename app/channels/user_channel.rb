class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel_#{current_user.id}"

    # stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
