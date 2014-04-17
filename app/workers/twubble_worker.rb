class TwubbleWorker
  include Sidekiq::Worker
    sidekiq_options :retry => 2, :queue => :twubbles_queue

  def perform
    Scan.create(category: 'twubbles').run_twitter_stream_twubbles
  end
end