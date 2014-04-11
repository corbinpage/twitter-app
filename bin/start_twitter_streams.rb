system "rake twitter:start_prod_nyc RAILS_EV=production --trace &" 
# system "rake twitter:start_prod_nyc RAILS_EV=#{Rails.env} --trace >> #{Rails.root}/log/rake.log&"