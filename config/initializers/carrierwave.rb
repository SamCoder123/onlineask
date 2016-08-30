CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :aws
    config.aws_bucket = ENV["AWS_BUCKET_NAME"]
    config.aws_acl = 'public-read'

    config.aws_credentials = {
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: "us-west-1"
    }
    config.aws_attributes = {
      expires: 1.month.from_now.httpdate,
      cache_control: 'max-age=604800'
    }
  else
    config.storage :file
  end
end
