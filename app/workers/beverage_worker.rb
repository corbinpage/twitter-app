class BeverageWorker
  include Sidekiq::Worker
    sidekiq_options :retry => false, :queue => :beverage_queue

  def perform
    Scan.create(category: 'beverages').run_twitter_stream_beverages
  end
end