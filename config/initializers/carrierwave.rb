CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  if Rails.env.development? || Rails.env.test?
    config.fog_credentials = {
      provider: "Local",
      local_root: "#{Rails.root}/publi/upload"
    }
  else
    config.fog_credentials = {
      provider: "AWS",
      region: "eu-west-1",
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    }
    config.fog_directory = ENV["AWS_S3_BUCKET"]
  end
end
