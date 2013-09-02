module VenuesHelper

  def venue_kind_link(value)
    if value.present?
      link_to venues_path(kind:value) do
        content_tag(:span, value, class:"tag tag-type" )
      end
    end
  end
end
