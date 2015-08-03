require 'zip'

class ContactsExportsController < AppController

  def new
    zipfile_name = File.join(Dir.tmpdir, "archive-#{Time.now}.zip")
    files = current_account.export_contacts

   Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
     files.each do |file|
       zipfile.add(File.basename(file), File.absolute_path(file))
     end
    end
    send_file(zipfile_name)
  end
end
