# encoding: utf-8

class ContactsImportUploader < CarrierWave::Uploader::Base
#  include CarrierWave::MimeTypes
  include CarrierWaveDirect::Uploader

  # process :set_content_type

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(csv txt)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
=begin
  def fog_attributes
    {'Content-Disposition' => "attachment"}
  end
=end  
end
