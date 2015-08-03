require 'zip'

class ContactsExportsController < AppController

  def new
    folder = "truc"
    zipfile_name = "archive.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
    end

    send_file(zipfile_name)
  end
end
