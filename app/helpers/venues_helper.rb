module VenuesHelper

  def venue_kind_link(value)
    if value.present?
      link_to venues_path(kind:value), class:"tag tag-type" do
        content_tag(:span, t(value, scope:"simple_form.options.venue.venue_info.kind"))
      end
    end
  end

  def venue_capacity_link(value)
    if value.present?
      case
      when value =~ /< (\d+)/
        filter_link(only_contacts_path(filter:"capacities_less_than", nb:$1),value)
      when value =~ /> (\d+)/
        filter_link(only_contacts_path(filter:"capacities_more_than", nb:$1),value)
      when value =~ /(\d+)-(\d+)/
        filter_link(only_contacts_path(filter:"capacities_between", nb1:$1,nb2:$2),value)
      end
    end
  end

  def filter_link(link, value)
    link_to link, class:"tag tag-custom" do
      content_tag(:span, value)
    end
  end
end
