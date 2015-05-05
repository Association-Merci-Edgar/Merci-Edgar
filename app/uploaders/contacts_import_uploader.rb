# encoding: utf-8

class ContactsImportUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader

  def extension_white_list
    %w(csv txt)
  end
end
