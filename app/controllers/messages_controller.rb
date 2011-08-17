class MessagesController < ApplicationController
  
  layout 'service'

  #Create message
  def new
    @message = Message.new(:receiver_id => params[:id])
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      redirect_to(new_message_path, :notice => 'Message was successfully sent.') 
    else
      render :action => 'new'
    end
  end

  def show
  end

end
