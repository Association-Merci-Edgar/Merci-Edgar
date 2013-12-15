module UsersHelper
  def user_tab_link(link_text, link, controller)
    class_name = controller_name == controller ? "active" : ""
    content_tag(:li,link_to(link_text, link), class: class_name)
  end
end