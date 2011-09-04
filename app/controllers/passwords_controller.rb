class PasswordsController < Devise::PasswordsController
  layout 'signup'
  before_filter :css_style

  private

  def css_style
    @class_name = 'sign_up' #css class set for Layout
  end

end
