# encoding: utf-8

class XmlExportUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  def store_dir
    "exports"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(xml)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def fog_attributes
    {'Content-Disposition' => "attachment"}
  end
end
