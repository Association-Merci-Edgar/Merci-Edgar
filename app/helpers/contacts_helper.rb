module ContactsHelper
  def nav_link(link_text, link_path, logo)
    class_name = current_page?(link_path) ? 'active' : ''

    link_to(link_path, class: class_name) do
      content_tag(:i,"",class:"entypo #{logo}") + link_text
    end
  end

  def tag_link(type,value,class_name)
    if value.present?
      link_to value,only_contacts_path(filter:type,name:value),class:"tag #{class_name}"
    end
  end

end