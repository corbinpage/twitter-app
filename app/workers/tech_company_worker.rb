class TechCompanyWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false 
  
  def perform
    Scan.create(category: 'tech_companies').run_twitter_stream_tech_companies
  end
end