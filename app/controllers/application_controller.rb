class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home

  end

  def update
    # Stalker.enqueue("scan.pub")
    # Scan.pub

    # PrivatePub.publish_to("/tweets/new","$('.header').append('<li>' + 'Hello World' + '</li>');")
    # s = Scan.new()
    # s.initialize_twitter_stream
    # puts "||||Doneski"
    # Scan.initialize_twitter_stream
    # Scan.pub
    # @tweet = Tweet.last
    # PrivatePub.publish_to("/tweets/new",tweet: @tweet)
  end

  def about
  end

end
