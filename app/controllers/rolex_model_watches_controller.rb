require "nokogiri"
require "httparty"
require "byebug"

class RolexModelWatchesController < ApplicationController
  @@rolex_model_watches = []

  def get_rolex_details
    rolex_model = params[:rolex_model].split('').slice(1,params[:rolex_model].split('').length-2).join()
    url = "https://www.tourneau.com/rolex/rolex-watches/#{rolex_model}/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page).css('div.primary-content')
    # watches = parsed_page.css('div.primary-content').css('div.search-result-content').css('li').children.children.children
    watches = parsed_page.css('div.primary-content').css('div.search-result-content').css('ul').css('li')

    watches.each do |watch|
      # byebug
      watch = {
        watch_url: watch.children[7].css('div.product-name').children.children[3].attributes["href"].value,
        description: watch.children[7].css('div.product-name').children.children[5].text,
        name: watch.children[7].css('div.product-image').children[2].children[1].attributes["title"].value,
        image_url: watch.children[7].css('div.product-image').children[2].children[1].attributes["src"].value
      }
      @@rolex_model_watches << watch
      end
      # puts allWatches
  end


  def index
    get_rolex_details
    # @rolex_model_watches = @@all_rolex_watches
    render json: @@rolex_model_watches
  end

end