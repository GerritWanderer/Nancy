if ENV['RAILS_ENV'] == 'production'
  wkhtml_config = {:exe_path => Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s}
else
  wkhtml_config = {:exe_path => '/usr/local/bin/wkhtmltopdf'}
end
WickedPdf.config = wkhtml_config