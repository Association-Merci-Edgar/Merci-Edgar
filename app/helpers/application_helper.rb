# encoding: utf-8
module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def previous
    @previous = @previous.blank? ? request.env['HTTP_REFERRER'] : @previous
  end

  def display_errors(object)
    notice = get_errors(object)
    content_tag(:div, notice, class:'notice error') if notice
  end

  def display_inline_errors(object)
    notice = get_errors(object)
    content_tag(:span, notice, class:'help-inline') if notice
  end
  
  def get_errors(object)
    if object && object.respond_to?(:errors) && object.errors.present?
      notice = content_tag(:span, "Oups ! Quelques erreurs se sont glissées !", class:'noticetitle')
      object.errors.full_messages.each do |m|
        notice += content_tag(:span, m + ' / ')
      end
      notice
    end
    
  end
  
  def menu_link(link_text, link, icon, controller, badge)
    class_name = controller.include?(controller_name) ? "active" : ""
    badge_tag = content_tag(:span,badge, class:"badge")
    link_tag = link_to link do
      content_tag(:i,nil,class:"ico #{icon}") + " " + link_text + badge_tag
    end
    content_tag(:li,link_tag, id: "#{controller[0]}-tab", class: class_name)
  end

  def showcase_menu_link(link_text, link, action)
    class_name = action_name == action ? "active" : ""    
    link_tag = link_to(link_text, link)
    content_tag(:li,link_tag, class: class_name)
  end
  
  def show_badge(color, text)
    badge_color = "badge-#{color}" if color
    content_tag(:div,text,class:"badge #{badge_color}")
  end

  def add_asset(asset)
    session[:history] ||= []
    session[:history].delete(asset.id)
    session[:history] << asset.id
    session[:history].shift if session[:history].length > 4
  end
  
  def translate_multiple_values(values, scope)
    if values
      translated_values = []
      values.split(',').map(&:strip).each do |v|
        translated_values.push(I18n.t(v, scope: scope))
      end
      translated_values.join(', ')
    end
  end

end
