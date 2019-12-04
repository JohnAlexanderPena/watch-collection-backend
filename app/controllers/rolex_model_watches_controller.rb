require "nokogiri"
require "httparty"
require "byebug"

class RolexModelWatchesController < ApplicationController
  @@allRolexWatches = []

  def get_rolex_details
    url = "https://www.tourneau.com/rolex/rolex-watches/day-date/"
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
      @@allRolexWatches << watch
      end
      # puts allWatches
  end


  def index
    get_rolex_details
    @all_rolex_model_watches = @@allRolexWatches
    render json: @all_rolex_model_watches
  end

end
