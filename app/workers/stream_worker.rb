class StreamWorker
  include Sidekiq::Worker

  def perform(category = :all)
    category == :all ? open_all_streams : open_stream(category)
  end

  private
    def open_stream(category)
        Scan.create(category: category).send("run_twitter_stream_#{category}")
    end

    def open_all_streams
        categories = [:nyc, :beverages, :tech_companies, :languages]
        categories.each { |category| open_stream(category) }
    end
end