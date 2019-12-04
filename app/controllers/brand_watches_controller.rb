require "nokogiri"
require "httparty"
require "byebug"
require "scraper"

class BrandWatchesController < ApplicationController
  @@brand_watches = []

  def showWatchModels
    # byebug
    brand = params[:brand].split('').slice(1,params[:brand].split('').length-2).join()
    url = "https://www.tourneau.com/watches/brands/#{brand}/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    watches = parsed_page.css('ul.search-result-items').css('li')
    watches.each do |watch|
        if watch.children.css('div.product-tile').empty?
          nil
        else
           watch = {
             model: watch.children.css('div.product-tile').css('div.product-image').children.children[1].values[1],
             image_url: watch.children.css('div.product-tile').css('div.product-image').children.children[1].values[0]
           }
           @@brand_watches << watch
      end
    end
  end

  def index
    showWatchModels
    # @brand_watches = @@brand_watches
    render json: @@brand_watches
  end

end
