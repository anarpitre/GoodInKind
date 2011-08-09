class HomeController < ApplicationController
  before_filter :set_seo_tags
  layout 'home'

  def index
    @services = Service.all
  end

  def set_seo_tags
    @head = {
      :title => "Home",
      :keywords => "a b c d",
      :description => 'this is awesome'
    }
  end
end
