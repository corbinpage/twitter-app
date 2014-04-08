class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    render 'heatmap'
  end

  def update
  end

  def realtime
  end

  def about
  end

end
