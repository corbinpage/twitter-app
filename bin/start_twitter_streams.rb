system "sudo rake twitter:start_all_prod RAILS_ENV=production --trace &" 
# system "rake twitter:start_prod_nyc RAILS_EV=#{Rails.env} --trace >> #{Rails.root}/log/rake.log&"