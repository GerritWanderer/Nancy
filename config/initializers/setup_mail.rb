ActionMailer::Base.smtp_settings = {  
  :address              => ENV['SMTP_SERVER'] || 'mail.example.org',
  :port                 => 25,  
  :domain               => ENV['SMTP_DOMAIN'] || 'example.org',
  :user_name            => ENV['SMTP_USER'] || 'exampleuser',
  :password             => ENV['SMTP_PASSWORD'] || 'examplepassword',
  :authentication       => "plain",  
  :enable_starttls_auto => false  
}