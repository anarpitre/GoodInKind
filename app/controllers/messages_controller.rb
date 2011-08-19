class MessagesController < ApplicationController
  
  layout 'service'

  #Create message
  def new
    if params[:msg_id]
      msg = Message.find(params[:msg_id])
      @message = Message.new(:receiver_id => msg.sender_id, :sender_id => msg.receiver_id, :parent_message_id => msg.id)
      mark_replied
    else
      @message = Message.new(:receiver_id => params[:id], :sender_id => current_user.id)
    end
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      #redirect_to(new_message_path, :notice => 'Message was successfully sent.') 
      redirect_to(services_path, :notice => 'Message was successfully sent.') 
    else
      render :action => 'new'
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.is_read = true
    @message.save
  end

  def list
    @unread_message = Message.get_unread_message(current_user.id)
    @read_message = Message.get_read_message(current_user.id)
  end

  def mark_replied
    unless @message.parent_message_id.to_i == 0
      message = Message.find(@message.parent_message_id)
      message.is_replied = true
      message.save
    end
  end


end
