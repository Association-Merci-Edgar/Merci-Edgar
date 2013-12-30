module Contacts
  module Xml
    def deep_xml(skip_instruct = true, builder=nil)
      to_xml(:builder => builder, :skip_instruct => skip_instruct, :skip_types => true, except: [:id, :created_at, :updated_at, :account_id]) do |xml|
        xml.name name
        structure.deep_xml(xml)
      end
    end

  end
end    