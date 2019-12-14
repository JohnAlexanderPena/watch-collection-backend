require "nokogiri"
require "httparty"
require "byebug"
require "scraper.rb"


class RolexModelWatchesController < ApplicationController
  
  def create
    get_rolex_details
    # @rolex_model_watches = @@all_rolex_watches
    render json: @@all_rolex_watches
  end



end
