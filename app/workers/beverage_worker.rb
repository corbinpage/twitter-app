class BeverageWorker
  include Sidekiq::Worker
    sidekiq_options :retry => false 

  def perform
    Scan.create(category: 'beverages').run_twitter_stream_beverages
  end
end