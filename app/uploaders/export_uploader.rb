class ExportUploader < CarrierWave::Uploader::Base
  storage :fog
end