# class StreamWorker
#   include Sidekiq::Worker

  # [:nyc, :beverages, :tech_companies, :languages].each do |category|
  #   worker = Class.new do 
  #     include Sidekiq::Worker

  #     define_method :perform do 
  #       Scan.create(category: category.to_s).send("run_twitter_stream_#{category}")    
  #     end
  #   end

    # Kernel.const_set("#{category.to_s.capitalize}Worker", worker)
  # end


  # def perform(category = :all)
  #   category == :all ? open_all_streams : open_stream(category)
  # end

  # def open_stream(category)
  #   Scan.create(category: category.to_s).send("run_twitter_stream_#{category}")
  # end

  # def open_all_streams
  #   categories = [:nyc, :beverages, :tech_companies, :languages]
  #   categories.each { |category| open_stream(category) }
  # end
# end