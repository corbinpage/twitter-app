# class LanguageWorker
#   include Sidekiq::Worker
#   sidekiq_options :retry => 2, :queue => :language_queue
  
#   def perform
#     Scan.create(category: 'languages').run_twitter_stream_languages
#   end
# end