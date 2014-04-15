class LanguageWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false 
  
  def perform
    Scan.create(category: 'languages').run_twitter_stream_languages
  end
end