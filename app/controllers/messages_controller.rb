class MessagesController < ApplicationController
 require "will_paginate/array"
  before_filter :authenticate_user!, :except => [:new, :create]
  before_filter :get_user
  before_filter :is_owner, :except => [:new, :create]
  layout 'service'

  def index
    @unread_message = Message.get_unread_message(@user.id)
    @read_message = Message.get_read_message(@user.id)
    @messages = @unread_message + @read_message 
    @messages = @messages.paginate(:per_page => PER_PAGE_RECORDS, :page => params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  #Create message
  def new
    if current_user.blank?
      session[:message] = true
      session[:message_to] = params[:id]
      redirect_to new_user_session_path and return
    end
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
    reply = true if @message.parent_message_id.to_i != 0
    respond_to do |format|
      if @message.save
        mark_replied if reply 
        Notifier.new_message(@message.receiver.email).deliver
        flash[:notice] = 'Message was successfully sent.'
        format.js   { render :js => "window.location='#{reply ? messages_path(current_user) : services_path}'" }
      else
        format.js   { render :partial => 'new'  }
      end
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
