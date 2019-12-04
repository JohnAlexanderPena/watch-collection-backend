require "nokogiri"
require "httparty"
require "byebug"
require "scraper.rb"

class BrandWatchesController < ApplicationController

  def index
    showWatchModels

    # @brand_watches = @@brand_watches
    render json: @@brand_watches
  end

end
