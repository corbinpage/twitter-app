class NYCWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false 
  
  def perform
    Scan.create(category: 'nyc').run_twitter_stream_nyc
  end
end