class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer

 def link(text, target, attributes = {} )
   attributes["data-remote"] = true
   super
 end


  protected

  def page_number(page)
    unless page == current_page
      link(page, page, :rel => rel_value(page))
    else
      tag(:span, page, :class => "current")
    end
  end


end
