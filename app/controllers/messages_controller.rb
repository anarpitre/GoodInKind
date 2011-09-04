class MessagesController < ApplicationController
  before_filter :get_user
  
  layout 'service'

  def index
    @unread_message = Message.get_unread_message(@user.id)
    @read_message = Message.get_read_message(@user.id)
  end

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
      if @message.parent_message_id.to_i != 0
        mark_replied
      end
      redirect_to(services_path, :notice => 'Message was successfully sent.') 
    else
      render :action => 'new'
    end
  end

  def show
    @msg = Message.find(params[:id])
    @msg.is_read = true
    @msg.save
    @message = Message.new(:receiver_id => @msg.sender_id, :sender_id => @msg.receiver_id, :parent_message_id => @msg.id)
  end

  def mark_replied
    unless @message.parent_message_id.to_i == 0
      message = Message.find(@message.parent_message_id)
      message.is_replied = true
      message.save
    end
  end


end
