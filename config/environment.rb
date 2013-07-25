# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Kippribor::Application.initialize!

#ENV['S3_KEY']='AKIAJ5CN6JNJ7WVYFJ7Q' 
#ENV['S3_SECRET']='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' 
#ENV['S3_BUCKET']='kippribor' 
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.locum.ru',
  :port           => '25',
  :authentication => 'plain',
  :user_name      => 'info@kipinform.ru',
  :password       => 'info123456',
  :domain         => 'kipinform.ru',
  :enable_starttls_auto => false
}