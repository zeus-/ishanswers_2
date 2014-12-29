module ApplicationHelper
  
  def formatted_date(x)
    x.strftime("%y-%b-%d")
  end
  def flash_messages 
    flashes = ""
    flash.each do |k, v|
      flashes += content_tag(:div, v, class: f_class(k.to_sym))
    end
    content_tag(:div, flashes.html_safe)
  end
  def f_class(x)
    case x
    when :notice then "alert alert-info"
    when :alert then "alert alert-danger"
    when :success then "alert alert-success" 
    end
  end

end
