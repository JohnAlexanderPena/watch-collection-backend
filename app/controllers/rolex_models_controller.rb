require "nokogiri"
require "httparty"
require "byebug"

class RolexModelsController < ApplicationController
  @@rolexModels = []

  def findRolexModels
    url = "https://www.tourneau.com/rolex/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    rolexModel = parsed_page.css('div.content-asset').css('ul').css('ul').css('li.landing-watch')
    rolexModel.each do |model|
      if model.children.css('div.landing-image')[0].children.empty? && model.children.css('div.landing-image')[0].children[0].nil? && model.children.css('div.landing-image')[0].children[0].nil?
        nil
      else
      watch = {
        rolex_model: model.children.css('div.landing-image')[0].children[0].children[0].values.first,
        rolex_url: model.children.css('div.landing-image')[0].children[0].values,
        image_url: model.children.css('div.landing-image')[0].children[0].children[0].values.last
      }
    @@rolexModels << watch
      end
    end
  end


  def index
    findRolexModels
    @rolex_models = @@rolexModels
    render json: @rolex_models
  end

end
