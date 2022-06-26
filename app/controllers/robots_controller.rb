class RobotsController < ApplicationController
  def index
    # Don't forget to delete /public/robots.txt
    respond_to :text
  end
end
