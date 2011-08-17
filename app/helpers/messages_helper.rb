module MessagesHelper

  def get_unread_message_size
    Message.get_unread_message(current_user.id).size
  end

end
