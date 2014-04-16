class NYCWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :queue => :nyc_queue
  
  def perform
    Scan.create(category: 'nyc').run_twitter_stream_nyc
  end
end