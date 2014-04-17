God.watch do |w|
  w.name = "twubble_angel"
  w.group = "stream"
  w.start = "#{Rails.root}/app/angels/twubble_angel.rb"
  w.start_grace = 10.seconds
  w.keepalive
end

God.watch do |w|
  w.name = "nyc_angel"
  w.group = "stream"
  w.start = "#{Rails.root}/app/angels/nyc_angel.rb"
  w.start_grace = 10.seconds
  w.keepalive
end

God.watch do |w|
  w.name = "tech_company_angel"
  w.group = "stream"
  w.start = "#{Rails.root}/app/angels/tech_company_angel.rb"
  w.start_grace = 10.seconds
  w.keepalive
end