module VenuesHelper

  def venue_kind_link(value)
    if value.present?
      link_to venues_path(kind:value), class:"tag tag-type" do
        content_tag(:span, value)
      end
    end
  end
end
