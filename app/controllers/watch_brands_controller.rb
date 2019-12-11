require "nokogiri"
require "httparty"
require "byebug"
require "scraper.rb"

class WatchBrandsController < ApplicationController

  def index
    scrapeModelNames

    render json: @@watch_brands
  end




end
