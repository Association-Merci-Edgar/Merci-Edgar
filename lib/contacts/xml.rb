module Contacts
  module Xml
    def deep_xml(skip_instruct = true, builder=nil)
      to_xml(:builder => builder, :skip_instruct => skip_instruct, :skip_types => true, except: [:id, :created_at, :updated_at, :account_id, :avatar]) do |xml|
        structure.deep_xml(xml)
        xml.base64_avatar do
          xml.filename self.avatar.file.filename 
          xml.content self.base64_avatar
        end unless self.avatar_url == self.avatar.default_url
      end
    end
    
    def base64_avatar
      Base64.encode64(open(self.avatar_url, &:read))
    end
    
    def upload_base64_avatar(options)
      if options
        filename = options["filename"]
        encoded_content = options["content"]
        
        filename_array = filename.split('.')
        filename_array[1] = ".#{filename_array[1]}" 
        file = Tempfile.new(filename_array)
        file.binmode
        file << Base64.decode64(encoded_content)
        self.avatar = file
        file.close
      end
    end

  end
end    