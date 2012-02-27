module ApplicationHelper
  
  def header_nav_link(link_text, link_path)
    case link_path
    when root_path
      class_name = current_page?(root_path) ? 'active' : ''
    when services_path
      class_name = current_page?(root_path) ? '' : 'active'
    end
  
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
  
  def admin_nav_link(link_text, link_path) 
    case link_path
    when services_path
      class_name = params[:controller] == 'services' || params[:controller]== 'events' ? 'active' : ''
    when statuses_path
      class_name = params[:controller] == 'statuses' ? 'active' : ''
    end
    
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end    
  end
  
end