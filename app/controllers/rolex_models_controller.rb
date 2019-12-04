require "nokogiri"
require "httparty"
require "byebug"
require 'scraper.rb'

class RolexModelsController < ApplicationController
  def index
    findRolexModels
    # @rolex_models = @@rolex_models
    render json: @@rolex_models
  end

end
