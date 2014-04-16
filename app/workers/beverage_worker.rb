class BeverageWorker
  include Sidekiq::Worker
    sidekiq_options :retry => 2, :queue => :beverage_queue

  def perform
    Scan.create(category: 'beverages').run_twitter_stream_beverages
  end
end