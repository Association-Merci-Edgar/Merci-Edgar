module UsersHelper
  def user_tab_link(link_text, link, controller)
    class_name = controller_name == controller ? "active" : ""
    link_to link_text, link, :data => {:toggle => "tab"}, class: class_name
  end
end