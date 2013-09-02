module ContactsHelper
  def nav_link(link_text, link_path, logo)
    class_name = current_page?(link_path) ? 'active' : ''

    link_to(link_path, class: class_name) do
      content_tag(:i,"",class:"entypo #{logo}") + link_text
    end
  end

  def tag_link(value,class_name)
    if value.present?
      link_to tag_path(value) do
        content_tag(:span,value, class:"tag #{class_name}")
      end
    end
  end

end