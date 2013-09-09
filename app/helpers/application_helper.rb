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
    if object && object.respond_to?(:errors) && object.errors.present?
      notice = content_tag(:span, "Oups ! Quelques erreurs se sont glissées !", class:'noticetitle')
      object.errors.full_messages.each do |m|
        notice += content_tag(:span, m + ' / ')
      end
      
      content_tag(:div, notice, class:'notice error')
    end
  end

  def menu_link(link_text, link, icon, controller, badge)
    class_name = controller_name == controller ? "active" : ""
    badge_tag = content_tag(:span,badge, class:"badge")
    link_tag = link_to link do
      content_tag(:i,nil,class:"entypo #{icon}") + " " + link_text + badge_tag
    end
    content_tag(:li,link_tag,class: class_name)
  end

  def show_badge(color, text)
    badge_color = "badge-#{color}" if color
    content_tag(:div,text,class:"badge #{badge_color}")
  end
end
