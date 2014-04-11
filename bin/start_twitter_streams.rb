system "rake twitter:start_prod_nyc RAILS_EV=development --trace &" 
# system "rake twitter:start_prod_nyc RAILS_EV=#{Rails.env} --trace >> #{Rails.root}/log/rake.log&"