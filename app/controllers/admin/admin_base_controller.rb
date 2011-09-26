class Admin::AdminBaseController < ApplicationController

  include ApplicationHelper
  before_filter :authenticate_user!
  before_filter :verify_admin

   def index
   end

  def verify_admin
    return true if is_admin?
    redirect_to root_path, :notice => "Admin priviliges required!"
  end

end
